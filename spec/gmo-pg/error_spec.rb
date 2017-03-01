require 'spec_helper'

describe GMO::PG::Error do
  describe '::from_http_error' do
    subject { GMO::PG::Error.from_http_error(error) }

    context 'with Net::OpenTimeout' do
      let(:error) { Net::OpenTimeout.new }
      it { is_expected.to be_an_instance_of GMO::PG::ConnectionError }
    end

    context 'with Net::OpenTimeout' do
      let(:error) { Net::ReadTimeout.new }
      it { is_expected.to be_an_instance_of GMO::PG::ConnectionError }
    end

    context 'with Net::HTTPError' do
      let(:error) { Net::HTTPError.new(100, 'Continue') }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with Net::HTTPRetriableError' do
      let(:error) { Net::HTTPRetriableError.new(302, 'Found') }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with Net::HTTPServerException' do
      let(:error) { Net::HTTPServerException.new(404, 'Not Found') }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with Net::HTTPFatalError' do
      let(:error) { Net::HTTPFatalError.new(500, 'Internal Server Error') }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with Net::HTTPBadResponse' do
      let(:error) { Net::HTTPBadResponse.new }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with Net::HTTPHeaderSyntaxError' do
      let(:error) { Net::HTTPHeaderSyntaxError.new }
      it { is_expected.to be_an_instance_of GMO::PG::HTTPError }
    end

    context 'with unhandlable error' do
      let(:error) { StandardError.new('unknown') }
      it { is_expected.to be_an_instance_of GMO::PG::Error }
    end
  end

  describe '::from_api_error' do
    subject { GMO::PG::Error.from_api_error(err_code, err_info) }

    context 'with Exx error' do
      context 'with invalid ShopID error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01010001' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid ShopPass error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01020001' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid ShopID and_or ShopPass error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01030002' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid SiteID error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01190001' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid SitePass error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01200001' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid SiteID and/or SitePass error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01210002' }
        it { is_expected.to be_an_instance_of GMO::PG::AuthorizationError }
      end

      context 'with invalid CardNo error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01170001' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid Expire error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01180001' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid CardPass error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01250010' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid Method error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01260001' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid PayTimes error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01270001' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid SecurityCode error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01460008' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with invalid HolderName error' do
        let(:err_code) { 'E01' }
        let(:err_info) { 'E01480008' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with incorrect card error' do
        let(:err_code) { 'E41' }
        let(:err_info) { 'E41170002' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with incorrect card or invalid CardNo error' do
        let(:err_code) { 'E61' }
        let(:err_info) { 'E61010002' }
        it { is_expected.to be_an_instance_of GMO::PG::CardError }
      end

      context 'with configuration error' do
        let(:err_code) { 'E61' }
        let(:err_info) { 'E61010001' }
        it { is_expected.to be_an_instance_of GMO::PG::APIServerError }
      end

      context 'with system error' do
        let(:err_code) { 'E91' }
        let(:err_info) { 'E91099996' }
        it { is_expected.to be_an_instance_of GMO::PG::APIServerError }
      end

      context 'with service temporary unavailable' do
        let(:err_code) { 'E92' }
        let(:err_info) { 'E92000001' }
        it { is_expected.to be_an_instance_of GMO::PG::APIServerError }
      end

      context 'with another error' do
        let(:err_code) { 'E00' }
        let(:err_info) { 'E00000000' }
        it { is_expected.to be_an_instance_of GMO::PG::APIError }
      end
    end

    context 'with Cxx error' do
      let(:err_code) { 'C01' }
      let(:err_info) { '42C010000' }
      it { is_expected.to be_an_instance_of GMO::PG::APIServerError }
    end

    context 'with Gxx error' do
      let(:err_code) { 'G02' }
      let(:err_info) { '42G020000' }
      it { is_expected.to be_an_instance_of GMO::PG::CardError }
    end
  end
end

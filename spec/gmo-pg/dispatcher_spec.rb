require 'spec_helper'

RSpec.describe GMO::PG::Dispatcher do
  let(:dispatcher) { GMO::PG::Dispatcher.new(url) }
  let(:url)        { 'https://example.com' }

  describe 'SSL option' do
    subject { dispatcher.instance_variable_get(:@http) }

    context 'when HTTPS URL is given' do
      let(:url) { 'https://example.com' }
      it { is_expected.to be_use_ssl }
    end

    context 'when HTTP URL is given' do
      let(:url) { 'http://example.com' }
      it { is_expected.not_to be_use_ssl }
    end
  end

  describe '#use_proxy' do
    let(:address) { 'proxyserveraddr' }
    let(:port)    { 1234 }
    let(:user)    { 'proxyuser' }
    let(:pass)    { 'proxypassword' }

    subject do
      dispatcher.use_proxy address: address, port: port, user: user, pass: pass
    end

    it { expect { subject }.to change(dispatcher, :proxy_address).to address }
    it { expect { subject }.to change(dispatcher, :proxy_port).to port }
    it { expect { subject }.to change(dispatcher, :proxy_user).to user }
    it { expect { subject }.to change(dispatcher, :proxy_pass).to pass }
  end

  describe '#connect' do
    it 'starts HTTP connection' do
      expect_any_instance_of(Net::HTTP).to receive(:start).and_yield
      expect { |b| dispatcher.connect(&b) }.to yield_with_args(dispatcher)
    end
  end

  describe '#dispatch' do
    subject { dispatcher.dispatch(request) }

    module Dummy
      extend GMO::PG::APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :Type, :type
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :Type, :type
      end
    end

    let(:request) { Dummy::Request.new(type: 'request') }

    context 'when received HTTP succeess response' do
      before do
        stub_request(:post, dispatcher.base_url + request.path)
          .with(body: GMO::PG::Payload.encode(request.payload))
          .and_return(status: 200, body: GMO::PG::Payload.encode(response.payload))
      end

      context 'when response has no error' do
        let(:response) { Dummy::Response.new(type: 'response') }
        it 'returns response' do
          expect(subject).to be_instance_of Dummy::Response
          expect(subject).not_to be_error
          expect(subject.payload).to eq response.payload
        end
      end

      context 'when response has error' do
        let(:response) { Dummy::Response.new(err_code: 'G02|E00', err_info: '42G020000|E00000000') }

        context 'when :raise_on_api_error option is truthy value' do
          before { dispatcher.raise_on_api_error = true }
          it 'raises first error' do
            expect { subject }.to raise_error GMO::PG::CardError, 'Card error (G02|42G020000)'
          end
        end

        context 'when :raise_on_api_error option is falsey value' do
          before { dispatcher.raise_on_api_error = false }
          it 'returns response' do
            expect { subject }.not_to raise_error
            expect(subject).to be_instance_of Dummy::Response
            expect(subject).to be_error
            expect(subject.payload).to eq response.payload
          end
        end
      end
    end

    context 'when HTTP error occurred' do
      before do
        stub_request(:post, dispatcher.base_url + request.path)
          .with(body: GMO::PG::Payload.encode(request.payload))
          .and_return(status: 500)
      end
      it { expect { subject }.to raise_error GMO::PG::HTTPError }
    end

    context 'when timeout error occurred' do
      before do
        stub_request(:post, dispatcher.base_url + request.path)
          .with(body: GMO::PG::Payload.encode(request.payload))
          .to_timeout
      end
      it { expect { subject }.to raise_error GMO::PG::ConnectionError }
    end
  end
end

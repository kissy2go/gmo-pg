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
      dispatcher.instance_variable_get(:@http)
    end

    it 'configures proxy' do
      http = subject
      expect(http.proxy_address).to eq address
      expect(http.proxy_port).to eq port
      expect(http.proxy_user).to eq user
      expect(http.proxy_pass).to eq pass
    end
  end

  describe '#connect' do
    it 'starts HTTP connection' do
      expect_any_instance_of(Net::HTTP).to receive(:start).and_yield
      expect { |b| dispatcher.connect(&b) }.to yield_with_args(dispatcher)
    end
  end

  describe '#dispatch' do
    subject { dispatcher.dispatch(request) }

    class DummyRequest
      attr_reader :path, :payload

      def self.corresponding_response_class
        DummyResponse
      end

      def initialize(path, payload)
        @path    = path
        @payload = payload
      end
    end

    class DummyResponse
      def self.new(payload)
        payload
      end
    end

    let(:request)  { DummyRequest.new(path, req_body) }
    let(:path)     { '/path/to/endpoint' }
    let(:req_body) { 'Key=Value' }
    let(:res_body) { 'Response=OK' }

    before do
      allow(GMO::PG::Payload).to receive(:encode).with(req_body).and_return(req_body)
      allow(GMO::PG::Payload).to receive(:decode).with(res_body).and_return(res_body)
    end

    context 'when received 2xx response' do
      it 'returns response' do
        stub_request(:post, url + path)
          .with(body: req_body)
          .and_return(status: 200, body: res_body)
        expect(subject).to eq res_body
      end
    end

    context 'when received 3xx response' do
      it 'raises Net::HTTPRetriableError' do
        stub_request(:post, url + path)
          .with(body: req_body)
          .and_return(status: 300)
        expect { subject }.to raise_error Net::HTTPRetriableError
      end
    end

    context 'when received 4xx response' do
      it 'raises Net::HTTPServerException' do
        stub_request(:post, url + path)
          .with(body: req_body)
          .and_return(status: 404)
        expect { subject }.to raise_error Net::HTTPServerException
      end
    end

    context 'when received 5xx response' do
      it 'raises Net::HTTPFatalError' do
        stub_request(:post, url + path)
          .with(body: req_body)
          .and_return(status: 500)
        expect { subject }.to raise_error Net::HTTPFatalError
      end
    end

    context 'when timeout occurred' do
      it 'raises Timeout::Error' do
        stub_request(:post, url + path)
          .with(body: req_body)
          .to_timeout
        expect { subject }.to raise_error Timeout::Error
      end
    end
  end
end

module APIEndpointExamples
  shared_examples 'an API Endpoint' do |endpoint_path|
    describe '::endpoint_path' do
      subject { described_class.endpoint_path }
      it { is_expected.to eq endpoint_path }
    end
  end
end

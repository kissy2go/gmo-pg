module RequestExamples
  RSpec.shared_examples 'a Request' do
    let(:endpoint) { Object.const_get(described_class.name.split('::')[0...-1].join('::')) }

    describe '::corresponding_response_class' do
      subject { described_class.corresponding_response_class }
      it { is_expected.to eq endpoint.const_get(:Response) }
    end

    describe '#path' do
      subject { described_class.new.path }
      it { is_expected.to eq endpoint.endpoint_path }
    end
  end
end

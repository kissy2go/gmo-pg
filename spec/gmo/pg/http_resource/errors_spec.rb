require 'spec_helper'

RSpec.describe GMO::PG::Errors do
  let(:errors) { GMO::PG::Errors.new(err_code, err_info) }

  let(:err_code) { 'E11|E21' }
  let(:err_info) { 'E11010099|E21010001' }

  describe '#each' do
    context 'without block' do
      it 'returns Enumerator' do
        expect(errors.each).to be_an_instance_of Enumerator
      end
    end

    context 'with block' do
      it 'yields per error code and info pair' do
        expected_args = err_code.split('|').zip(err_info.split('|')).map do |(err_code, err_info)|
          GMO::PG::Errors::Record.new(err_code, err_info)
        end
        expect { |b| errors.each(&b) }.to yield_successive_args *expected_args
      end
    end
  end
end

RSpec.describe GMO::PG::Errors::Record do
  describe '#to_error' do
    subject { record.to_error }

    let(:record) { GMO::PG::Errors::Record.new('E00', 'E00000000') }

    it 'delegates GMO::PG::Error::from_api_error with err_code and err_info' do
      expect(GMO::PG::Error).to receive(:from_api_error)
        .with(record.err_code, record.err_info)
        .and_return(:ok)
      expect(subject).to eq :ok
    end
  end
end

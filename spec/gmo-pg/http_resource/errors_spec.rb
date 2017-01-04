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
        expected_args = err_code.split('|').zip(err_info.split('|'))
        expect { |b| errors.each(&b) }.to yield_successive_args *expected_args
      end
    end
  end
end

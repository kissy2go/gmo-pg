require 'spec_helper'

describe GMO::PG::Payload::Typecast do
  describe '::detect' do
    subject { GMO::PG::Payload::Typecast.detect(typecast_option) }

    context 'when :integer is given' do
      let(:typecast_option) { :integer }
      it { is_expected.to be GMO::PG::Payload::TypecastableInteger }
    end

    context 'when :epoch_time is given' do
      let(:typecast_option) { :epoch_time }
      it { is_expected.to be GMO::PG::Payload::TypecastableEpochTime }
    end

    context 'when Hash is given' do
      let(:typecast_option) { {} }
      it 'returns class inherited GMO::PG::Payload::TypecastableValue' do
        expect(subject.ancestors).to include GMO::PG::Payload::TypecastableValue
      end
    end

    context 'when unsupported value is given' do
      let(:typecast_option) { :unsupported }
      it { is_expected.to be GMO::PG::Payload::TypecastableValue }
    end
  end
end

describe GMO::PG::Payload::TypecastableValue do
  let(:typecast_value) { GMO::PG::Payload::TypecastableValue.new(value) }
  let(:value)          { 'raw' }

  describe '::from_hash' do
    let(:clazz) { GMO::PG::Payload::TypecastableValue.from_hash(typecast_option) }

    let(:to_attribute) { -> (value) { "called #to_attribute with #{value}" } }
    let(:to_payload)   { -> (value) { "called #to_payload with #{value}" } }

    context 'with hash has :to_attribute and :to_payload' do
      let(:typecast_option) { { to_attribute: to_attribute, to_payload: to_payload } }

      context '::ancestors' do
        it { expect(clazz.ancestors).to include GMO::PG::Payload::TypecastableValue }
      end

      context 'instance' do
        describe '#to_attribute' do
          subject { clazz.new(value).to_attribute }
          it 'returns result of proc called' do
            expect(subject).to eq to_attribute.call(value)
          end
        end

        describe '#to_payload' do
          subject { clazz.new(value).to_payload }
          it 'returns result of proc called' do
            expect(subject).to eq to_payload.call(value)
          end
        end
      end
    end

    context 'with hash has no :to_attribute or :to_payload' do
      let(:typecast_option) { {} }
      subject { clazz }
      it { is_expected.to be_a_kind_of Class }

      context 'instance' do
        describe '#to_attribute' do
          subject { clazz.new(value).to_attribute }
          it 'returns raw value' do
            expect(subject).to eq value
          end
        end

        describe '#to_payload' do
          subject { clazz.new(value).to_payload }
          it 'returns raw value' do
            expect(subject).to eq value
          end
        end
      end
    end
  end

  describe '#to_attribute' do
    subject { typecast_value.to_attribute }
    it { is_expected.to eq value }
    it { is_expected.not_to equal value }
  end

  describe '#to_payload' do
    subject { typecast_value.to_payload }
    it { is_expected.to eq value }
    it { is_expected.not_to equal value }
  end

  describe '#==' do
    subject { typecast_value == other }

    context 'when GMO::PG::Payload::TypecastableValue instance is given' do
      it 'returns either equal value or not' do
        expect(typecast_value == GMO::PG::Payload::TypecastableValue.new(value)).to be_truthy
        expect(typecast_value == GMO::PG::Payload::TypecastableValue.new("#{value}!")).to be_falsey
      end
    end

    context 'when non GMO::PG::Payload::TypecastableValue instance is given' do
      it 'returns either equal value or not' do
        expect(typecast_value == value).to be_truthy
        expect(typecast_value == "#{value}!").to be_falsey
      end
    end
  end
end

describe GMO::PG::Payload::TypecastableInteger do
  describe '#to_attribute' do
    context 'with convertible value' do
      it 'returns integer value' do
        expect(GMO::PG::Payload::TypecastableInteger.new('123').to_attribute).to eq 123
        expect(GMO::PG::Payload::TypecastableInteger.new('123.0').to_attribute).to eq 123
        expect(GMO::PG::Payload::TypecastableInteger.new(123).to_attribute).to eq 123
        expect(GMO::PG::Payload::TypecastableInteger.new(123.0).to_attribute).to eq 123
      end
    end

    context 'with unconvertible value' do
      it 'returns raw value' do
        expect(GMO::PG::Payload::TypecastableInteger.new(:value).to_attribute).to eq :value
      end
    end
  end

  describe '#to_payload' do
    context 'with convertible value' do
      it 'returns string value' do
        expect(GMO::PG::Payload::TypecastableInteger.new('123').to_payload).to eq '123'
        expect(GMO::PG::Payload::TypecastableInteger.new('123.0').to_payload).to eq '123'
        expect(GMO::PG::Payload::TypecastableInteger.new(123).to_payload).to eq '123'
        expect(GMO::PG::Payload::TypecastableInteger.new(123.0).to_payload).to eq '123'
      end
    end

    context 'with unconvertible value' do
      it 'returns raw value' do
        expect(GMO::PG::Payload::TypecastableInteger.new(:value).to_payload).to eq 'value'
      end
    end
  end
end

describe GMO::PG::Payload::TypecastableEpochTime do
  describe '#to_attribute' do
    context 'with convertible value' do
      it 'returns integer value' do
        epoch_time = Time.new(2017, 1, 2, 12, 34, 56).localtime('+09:00').to_i
        expect(GMO::PG::Payload::TypecastableEpochTime.new(Time.at(epoch_time)).to_attribute).to eq epoch_time
        expect(GMO::PG::Payload::TypecastableEpochTime.new(DateTime.new(2017, 1, 2, 12, 34, 56)).to_attribute).to eq epoch_time
        expect(GMO::PG::Payload::TypecastableEpochTime.new('20170102123456').to_attribute).to eq epoch_time
        expect(GMO::PG::Payload::TypecastableEpochTime.new(epoch_time).to_attribute).to eq epoch_time
      end
    end

    context 'with unconvertible value' do
      it 'returns raw value' do
        expect(GMO::PG::Payload::TypecastableEpochTime.new(:value).to_attribute).to eq :value
      end
    end
  end

  describe '#to_payload' do
    context 'with convertible value' do
      it 'returns string value' do
        epoch_time = Time.new(2017, 1, 2, 12, 34, 56).localtime('+09:00').to_i
        expect(GMO::PG::Payload::TypecastableEpochTime.new(Time.at(epoch_time)).to_payload).to eq '20170102123456'
        expect(GMO::PG::Payload::TypecastableEpochTime.new(DateTime.new(2017, 1, 2, 12, 34, 56)).to_payload).to eq '20170102123456'
        expect(GMO::PG::Payload::TypecastableEpochTime.new('20170102123456').to_payload).to eq '20170102123456'
        expect(GMO::PG::Payload::TypecastableEpochTime.new(epoch_time).to_payload).to eq '20170102123456'
      end
    end

    context 'with unconvertible value' do
      it 'returns raw value' do
        expect(GMO::PG::Payload::TypecastableEpochTime.new(:value).to_payload).to eq 'value'
      end
    end
  end
end

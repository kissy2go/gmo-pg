module PayloadExamples
  RSpec.shared_examples 'a Payload' do |param_name, attr_name|
    it "binds #{param_name} to #{attr_name}" do
      bind_attributes = described_class.instance_variable_get(:@bind_attributes)
      expect(bind_attributes).to include([param_name, attr_name, kind_of(Hash)])
    end
  end

  RSpec.shared_examples 'a typecastable parameter' do |param_name, value_class|
    it "casts #{param_name} as #{value_class}" do
      _, _, options = described_class.send(:detect_bind_attribute, param_name)
      expect(GMO::PG::Payload::Typecast.detect(options[:typecast])).to eq value_class
    end
  end
end

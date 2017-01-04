module PayloadExamples
  RSpec.shared_examples 'a Payload' do |param_name, attr_name|
    it "binds #{param_name} to #{attr_name}" do
      bind_attributes = described_class.instance_variable_get(:@bind_attributes)
      expect(bind_attributes).to include([param_name, attr_name])
    end
  end
end

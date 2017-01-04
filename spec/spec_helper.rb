$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'gmo-pg'

Dir.glob('spec/helper/**/*') { |f| load f }

RSpec.configure do |c|
  c.before :example, type: :api_endpoint do
    include APIEndpointExamples
  end

  c.before :example, type: :request do
    include PayloadExamples
    include RequestExamples
  end

  c.before :example, type: :response do
    include PayloadExamples
    include ResponseExamples
  end
end

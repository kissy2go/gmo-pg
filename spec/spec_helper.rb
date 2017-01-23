$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'vcr'
require 'gmo-pg'

Dir.glob('spec/helper/**/*') { |f| load f }
Dir.glob("spec/steps/**/*steps.rb") { |f| load f }

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

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<SiteID>')   { ENV['GMO_PG_SITE_ID'] }
  c.filter_sensitive_data('<SitePass>') { ENV['GMO_PG_SITE_PASS'] }
  c.filter_sensitive_data('<ShopID>')   { ENV['GMO_PG_SHOP_ID'] }
  c.filter_sensitive_data('<ShopPass>') { ENV['GMO_PG_SHOP_PASS'] }
end

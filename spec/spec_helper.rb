$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'webmock/rspec'
require 'vcr'
require 'gmo-pg'

Dir.glob('spec/helper/**/*') { |f| load f }
Dir.glob("spec/acceptance/steps/**/*_steps.rb") { |f| load f }

RSpec.configure do |c|
  GMO::PG.base_url = 'https://example.com'

  c.before type: :api_endpoint do
    c.include APIEndpointExamples
  end

  c.before type: :request do
    c.include PayloadExamples
    c.include RequestExamples
  end

  c.before type: :response do
    c.include PayloadExamples
    c.include ResponseExamples
  end

  # Turnip configurations
  c.before type: :feature do
    GMO::PG.base_url = 'https://pt01.mul-pay.jp'

    c.include FeatureSteps
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<SiteID>')   { ENV['GMO_PG_SITE_ID'] }   if ENV['GMO_PG_SITE_ID']
  c.filter_sensitive_data('<SitePass>') { ENV['GMO_PG_SITE_PASS'] } if ENV['GMO_PG_SITE_PASS']
  c.filter_sensitive_data('<ShopID>')   { ENV['GMO_PG_SHOP_ID'] }   if ENV['GMO_PG_SHOP_ID']
  c.filter_sensitive_data('<ShopPass>') { ENV['GMO_PG_SHOP_PASS'] } if ENV['GMO_PG_SHOP_PASS']
end

require 'spec_helper'

RSpec.describe GMO::PG do
  describe '::connect' do
    it 'connects remote server' do
      GMO::PG.connect do |dispatcher|
        expect(dispatcher).to be_connected
        expect(dispatcher.base_url).to eq GMO::PG.base_url
        expect(dispatcher.open_timeout).to eq GMO::PG.open_timeout
        expect(dispatcher.read_timeout).to eq GMO::PG.read_timeout
        expect(dispatcher.raise_on_api_error).to eq GMO::PG.raise_on_api_error
      end
    end
  end
end

require 'spec_helper'

RSpec.describe GMO::PG do
  describe '::connect' do
    it 'connects remote server' do
      dispatcher_mock = spy('GMO::PG::Dispatcher')

      expect(GMO::PG::Dispatcher).to receive(:new)
        .with(GMO::PG::base_url)
        .and_yield(dispatcher_mock)
        .and_return(dispatcher_mock)

      expect(dispatcher_mock).to receive(:open_timeout=).with(GMO::PG.open_timeout)
      expect(dispatcher_mock).to receive(:read_timeout=).with(GMO::PG.read_timeout)
      expect(dispatcher_mock).to receive(:connect).and_yield(dispatcher_mock)

      expect { |b| GMO::PG.connect(&b) }.to yield_successive_args dispatcher_mock
    end
  end
end

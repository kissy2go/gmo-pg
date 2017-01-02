require 'spec_helper'

describe GMO::PG do
  describe 'library version' do
    it { expect(GMO::PG::VERSION).to eq '0.0.0' }
  end
end

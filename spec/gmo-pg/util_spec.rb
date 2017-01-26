require 'spec_helper'

describe GMO::PG::Util::OrderID do
  describe '::generate' do
    it 'returns random OrderID generated' do
      expect(GMO::PG::Util::OrderID.generate).to match /\A[a-zA-Z0-9\-]{27}\Z/
      expect(GMO::PG::Util::OrderID.generate(prefix: 'Order-')).to match /\AOrder-[a-zA-Z0-9\-]{21}\Z/
      expect(GMO::PG::Util::OrderID.generate(suffix: '-Order')).to match /\A[a-zA-Z0-9\-]{21}-Order\Z/
      expect(GMO::PG::Util::OrderID.generate(chars: [*('a'..'z')])).to match /\A[a-z]{27}\Z/
      expect(GMO::PG::Util::OrderID.generate(length: 10)).to match /\A[a-zA-Z0-9\-]{10}\Z/
    end
  end
end

describe GMO::PG::Util::MemberID do
  describe '::generate' do
    it 'returns random MemberID generated' do
      expect(GMO::PG::Util::MemberID.generate).to match /\A[a-zA-Z0-9\-@_.]{60}\Z/
      expect(GMO::PG::Util::MemberID.generate(prefix: 'Member-')).to match /\AMember-[a-zA-Z0-9\-@_.]{53}\Z/
      expect(GMO::PG::Util::MemberID.generate(suffix: '-Member')).to match /\A[a-zA-Z0-9\-@_.]{53}-Member\Z/
      expect(GMO::PG::Util::MemberID.generate(chars: [*('a'..'z')])).to match /\A[a-z]{60}\Z/
      expect(GMO::PG::Util::MemberID.generate(length: 10)).to match /\A[a-zA-Z0-9\-@_.]{10}\Z/
    end
  end
end

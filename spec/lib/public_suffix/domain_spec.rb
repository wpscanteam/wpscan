# frozen_string_literal: true

describe PublicSuffix::Domain do
  describe '#match' do
    it 'returns true' do
      expect(PublicSuffix.parse('g.com').match('g.com')).to eql true
    end

    it 'returns true' do
      expect(PublicSuffix.parse('s.g.com').match('*.g.com')).to eql true
    end

    it 'returns false' do
      expect(PublicSuffix.parse('a.b.g.com').match('*.g.com')).to eql false
    end

    it 'returns true' do
      expect(PublicSuffix.parse('a.b.g.com').match('*.b.g.com')).to eql true
    end

    it 'returns true' do
      expect(PublicSuffix.parse('a.b.g.com').match('**.g.com')).to eql true
    end

    it 'returns false' do
      expect(PublicSuffix.parse('a.b.y.g.com').match('**.b.g.com')).to eql false
    end

    it 'returns false' do
      expect(PublicSuffix.parse('w.g.com').match('*.g2.com')).to eql false
    end

    it 'returns true' do
      expect(PublicSuffix.parse('a.b.g.com').match('a.b.g.com')).to eql true
    end

    it 'returns false' do
      expect(PublicSuffix.parse('a.b.g.com').match('a.y.g.com')).to eql false
    end

    it 'returns true' do
      expect(PublicSuffix.parse('a.b.c.d.g.com').match('**.c.d.g.com')).to eql true
    end

    it 'returns true' do
      expect(PublicSuffix.parse('a.b.c.d.g.com').match('*.b.c.d.g.com')).to eql true
    end
  end
end

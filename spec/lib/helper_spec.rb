# frozen_string_literal: true

describe '#classify_slug' do
  {
    'slug' => :Slug,
    'slug-usual' => :SlugUsual,
    '12-slug' => :D_12Slug,
    'slug.s' => :SlugS,
    'slug yolo $' => :SlugYolo,
    'slug $ ab.cd/12' => :SlugAbCd12,
    'カスタムテーマ' => :HexSlug_e382abe382b9e382bfe383a0e38386e383bce3839e
  }.each do |slug, expected_symbol|
    context "when #{slug}" do
      it "returns #{expected_symbol}" do
        expect(classify_slug(slug)).to eql expected_symbol
      end
    end
  end
end

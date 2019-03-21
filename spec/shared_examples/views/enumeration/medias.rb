# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::Medias' do
  let(:view)  { 'medias' }
  let(:media) { WPScan::Model::Media }

  describe 'medias' do
    context 'when no medias found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(medias: [])
      end
    end

    context 'when medias found' do
      let(:m1)     { media.new(target_url + '?attachment_id=1', found_by: 'Attachment Brute Forcing') }
      let(:m2)     { media.new(target_url + '?attachment_id=5', found_by: 'Attachment Brute Forcing') }
      let(:medias) { [m1, m2] }
      let(:expected_view) { File.join(view, 'medias') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(medias: medias)
      end
    end
  end
end

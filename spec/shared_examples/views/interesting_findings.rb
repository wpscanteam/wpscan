# frozen_string_literal: true

shared_examples 'App::Views::InterestingFindings' do
  let(:controller)       { WPScan::Controller::InterestingFindings.new }
  let(:tpl_vars)         { { url: target_url } }
  let(:interesting_file) { WPScan::Model::InterestingFinding }

  describe 'findings' do
    let(:view) { 'findings' }
    let(:opts) { { confidence: 10, found_by: 'Spec' } }

    context 'when empty results' do
      let(:expected_view) { 'empty' }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(findings: [])
      end
    end

    it 'outputs the expected string' do
      findings = WPScan::Finders::Findings.new

      findings <<
        interesting_file.new('F1', opts.merge(to_s: 'F1_to_s', found_by: 'Test (Passive)')) <<
        interesting_file.new('F2', opts.merge(references: { url: 'R1' }, interesting_entries: %w[IE1])) <<
        interesting_file.new('F2', opts.merge(found_by: 'Spec2')) <<
        interesting_file.new('F3',
                             opts.merge(references: { url: %w[R1 R2] }, interesting_entries: %w[IE1 IE2])) <<
        interesting_file.new('F3', opts.merge(found_by: 'Spec2', confidence: 100)) <<
        interesting_file.new('F3', opts.merge(found_by: 'Spec3')) <<
        interesting_file.new('F4', opts.merge(confidence: 0)) <<
        interesting_file.new('F4', opts.merge(confidence: 0, found_by: 'Spec2'))

      @tpl_vars = tpl_vars.merge(findings: findings)
    end
  end
end

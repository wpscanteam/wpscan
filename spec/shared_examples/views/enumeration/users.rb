# frozen_string_literal: true

shared_examples 'App::Views::Enumeration::Users' do
  let(:view)  { 'users' }
  let(:user)  { WPScan::Model::User }

  describe 'users' do
    context 'when no users found' do
      let(:expected_view) { File.join(view, 'none_found') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(users: [])
      end
    end

    context 'when users found' do
      let(:expected_view) { File.join(view, 'users') }

      xit 'outputs the expected string'
    end
  end
end

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
      let(:u1)     { user.new('admin', found_by: 'Author Id Brute Forcing (Aggressive Detection)') }
      let(:u2)     { user.new('editor', found_by: 'Author Posts (Passive Detection)') }
      let(:users)  { [u1, u2] }
      let(:expected_view) { File.join(view, 'users') }

      it 'outputs the expected string' do
        @tpl_vars = tpl_vars.merge(users: users)
      end
    end
  end
end

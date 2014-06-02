# encoding: UTF-8

shared_examples 'WpUsers::BruteForcable' do

  describe '#brute_force' do
    let(:range)           { (1..10) }
    let(:wordlist)        { 'somefile.txt'}
    let(:brute_force_opt) { {} }

    it 'calls #brute_force on each wp_user' do
      range.each do |id|
        wp_user = WpUser.new(uri, id: id)
        expect(wp_user).to receive(:brute_force).with(wordlist, brute_force_opt)

        wp_users << wp_user
      end

      wp_users.brute_force(wordlist, brute_force_opt)
    end
  end

end

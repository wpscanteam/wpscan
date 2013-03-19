# encoding: UTF-8

class WpUsers < WpItems
  module Output

    # TODO : create a generic method to output tabs
    def output(left_margin = '')
      max_id_length = self.sort { |a, b| a.id.to_s.length <=> b.id.to_s.length }.last.id.to_s.length
      max_login_length = self.sort { |a, b| a.login.length <=> b.login.length }.last.login.length
      max_display_name_length = self.sort { |a, b| a.display_name.length <=> b.display_name.length }.last.display_name.length

      inner_space         = 2
      id_length           = (max_id_length + inner_space * 2) /2 *2
      login_length        = max_login_length + inner_space * 2
      display_name_length = max_display_name_length + inner_space * 2

      puts left_margin + '+' * (id_length + login_length + display_name_length + 4)
      puts left_margin + '|' + 'id'.center(id_length) + '|' + 'login'.center(login_length) + '|' + 'display name'.center(display_name_length) + '|'
      puts left_margin + '|' + '+' * (id_length + login_length + display_name_length + 2) + '|'

      self.each do |u|
        puts left_margin + '|' + u.id.to_s.center(id_length) + '|' +  u.login.center(login_length) + '|' + u.display_name.center(display_name_length) + '|'
      end

      puts left_margin + '+' * (id_length + login_length + display_name_length + 4)
    end

  end
end

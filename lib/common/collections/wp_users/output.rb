# encoding: UTF-8

class WpUsers < WpItems
  module Output

    # @param [ Hash ] options
    # @option options[ Boolean ] :show_password Output the password column
    #
    # @return [ void ]
    def output(options = {})
      rows     = []
      headings = ['Id', 'Login', 'Name']
      headings << 'Password' if options[:show_password]

      self.each do |wp_user|
        row = [wp_user.id, wp_user.login, wp_user.display_name]
        row << wp_user.password if options[:show_password]
        rows << row
      end

      table = Terminal::Table.new(headings: headings,
                                  rows: rows,
                                  style: { margin_left: options[:margin_left] || '' }).to_s
      # variable needed for output
      puts table
    end

  end
end

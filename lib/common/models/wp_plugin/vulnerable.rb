# encoding: UTF-8

class WpPlugin < WpItem

  def vulns_file
    unless @vulns_file
      @vulns_file = PLUGINS_VULNS_FILE
    end
    @vulns_file
  end

  def vulns_xpath
    "//plugin[@name='#{@name}']/vulnerability"
  end

  module Vulnerable

  end

end

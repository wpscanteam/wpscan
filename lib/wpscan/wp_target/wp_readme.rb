# encoding: UTF-8

class WpTarget < WebSite
  module WpReadme

    # Checks to see if the readme.html file exists
    #
    # This file comes by default in a wordpress installation,
    # and if deleted is reinstated with an upgrade.
    #
    # @return [ Boolean ]
    def has_readme?
      response = Browser.get(readme_url)

      unless response.code == 404
        return response.body =~ %r{wordpress}i ? true : false
      end
      false
    end

    # @return [ String ] The readme URL
    def readme_url
      @uri.merge('readme.html').to_s
    end

  end
end

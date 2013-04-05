# encoding: UTF-8

module WpReadme

  # Checks to see if the readme.html file exists
  #
  # This file comes by default in a wordpress installation,
  # and if deleted is reinstated with an upgrade.
  def has_readme?
    response = Browser.instance.get(readme_url())

    unless response.code == 404
      response.body =~ %r{wordpress}i
    end
  end

  def readme_url
    @uri.merge('readme.html').to_s
  end
end

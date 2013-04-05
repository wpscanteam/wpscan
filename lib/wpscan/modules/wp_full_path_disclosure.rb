# encoding: UTF-8

module WpFullPathDisclosure

  # Check for Full Path Disclosure (FPD)
  def has_full_path_disclosure?
    response = Browser.instance.get(full_path_disclosure_url())
    response.body[%r{Fatal error}i]
  end

  def full_path_disclosure_url
    @uri.merge('wp-includes/rss-functions.php').to_s
  end
end

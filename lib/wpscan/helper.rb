# frozen_string_literal: true

def read_json_file(file)
  JSON.parse(File.read(file))
rescue StandardError => e
  raise "JSON parsing error in #{file} #{e}"
end

# Sanitize and classify a slug
# @note As a class can not start with a digit or underscore, a D_ is
#       put as a prefix in such case. Ugly but well :x
#       Not only used to classify slugs though, but Dynamic Finder names as well
#
# @return [ Symbol ]
def classify_slug(slug)
  classified = slug.to_s.gsub(/[^a-z\d\-]/i, '-').gsub(/-{1,}/, '_').camelize.to_s
  classified = "D_#{classified}" if /\d/.match?(classified[0])

  classified.to_sym
end

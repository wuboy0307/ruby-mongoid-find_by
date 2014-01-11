source "https://rubygems.org"
gemspec

group :development do
  gem "rake"

  if ENV["MONGOID_VERSION"]
    gem "mongoid", "~> #{ENV["MONGOID_VERSION"]}"
  end
end

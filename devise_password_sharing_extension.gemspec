# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'devise_password_sharing_extension/version'

Gem::Specification.new do |s|
  s.name         = "devise_password_sharing_extension"
  s.version      = DevisePasswordSharingExtension::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Russ Smith"]
  s.email        = ["russ@bashme.org"]
  s.homepage     = "https://github.com/russ/devise_password_sharing_extension"
  s.summary      = "A devise extension to curb password sharing."
  s.description  = "A devise extension to curb password sharing."
  s.files        = Dir["{app,lib}/**/*"] + %w[LICENSE README.rdoc]
  s.require_path = "lib"
  s.rdoc_options = ["--main", "README.rdoc", "--charset=UTF-8"]

  s.required_ruby_version     = '>= 1.8.6'
  s.required_rubygems_version = '>= 1.3.6'

  {
    'rails'  => '>= 4.0.0',
    'devise' => '>= 3.0.0',
    'geoip' => '~> 1.2.0'
  }.each do |lib, version|
    s.add_runtime_dependency(lib, *version)
  end
end

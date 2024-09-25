# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/connector/version"

Gem::Specification.new do |s|
  s.version = Decidim::Connector.version
  s.authors = ["Antti Hukkanen"]
  s.email = ["antti.hukkanen@mainiotech.fi"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-connector"
  s.required_ruby_version = ">= 3.1"
  s.metadata["rubygems_mfa_required"] = "true"

  s.name = "decidim-connector"
  s.summary = "A decidim connector module"
  s.description = "API connector for Decidim.."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Connector.decidim_version
end

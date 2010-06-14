require 'rubygems'
require 'rake/gempackagetask'

PLUGIN = "merb_relaxdb"
GEM_NAME = "merb_relaxdb"
GEM_VERSION = "1.11"
AUTHOR = "Paul Carey"
EMAIL = "paul.p.carey@gmail.com"
HOMEPAGE = "http://github.com/paulcarey/merb_relaxdb/"
SUMMARY = "Merb plugin that provides integration with CouchDB"

spec = Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.textile", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  # s.add_dependency('relaxdb', '>= 0.1.0') # causes rake install to fail
  # s.add_dependency('paulcarey-relaxdb', '>= 0.1.0') # allows rake install to succeed
  
  s.require_path = 'lib'
  s.autorequire = PLUGIN
  s.files = %w(LICENSE README.textile Rakefile Generators) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install => [:package] do
  sh %{gem install --no-rdoc --no-ri --local pkg/#{GEM_NAME}-#{GEM_VERSION}}
end
# task :install do
#   Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION, :local => true)
# end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

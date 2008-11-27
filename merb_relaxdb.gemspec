Gem::Specification.new do |s|
  s.name = "merb_relaxdb"
  s.version = "1.0"
  s.date = "2008-11-27"
  s.summary = "Merb plugin that provides integration with CouchDB"
  s.email = "paul.p.carey@gmail.com"
  s.homepage = "http://github.com/paulcarey/merb_relaxdb/"
  s.has_rdoc = false
  s.authors = ["Paul Carey"]
  s.files = ["LICENSE",
   "Generators",
   "README.textile",
   "Rakefile",
   "lib/generators",
   "lib/generators/model.rb",
   "lib/generators/templates",
   "lib/generators/templates/model",
   "lib/generators/templates/model/app",
   "lib/generators/templates/model/app/models",
   "lib/generators/templates/model/app/models/%file_name%.rb",
   "lib/merb_relaxdb",
   "lib/merb_relaxdb/connection.rb",
   "lib/merb_relaxdb/couchdb.yml.sample",
   "lib/merb_relaxdb/merbtasks.rb",
   "lib/merb_relaxdb/rdb_salted_user.rb",
   "lib/merb_relaxdb.rb",
   "spec/merb_relaxdb_spec.rb",
   "spec/spec_helper.rb"]
  s.bindir = "bin"
  s.autorequire = "merb_relaxdb"
  s.add_dependency "merb-core", ">= 1.0" # removed ", runtime" as was failing locally
  s.require_paths = ["lib"]
  s.required_rubygems_version = ">= 0"
end

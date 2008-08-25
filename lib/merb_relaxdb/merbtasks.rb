desc "Create CouchDB environment from scratch"
task :relaxdb => ["relaxdb:db", "relaxdb:views", "relaxdb:data", "relaxdb:sample"]

namespace :relaxdb do

  desc "Create CouchDB database"
  task :db => [:check_env, :merb_env] do
    RelaxDB.delete_db(RelaxDB.db.name) rescue "ok"
    RelaxDB.use_db(RelaxDB.db.name)
  end

  desc "Create CouchDB views"
  task :views => [:check_env, :merb_env] do
    Dir['couchdb/views/**/*.js'].each do |filename|
      RelaxDB::ViewUploader.upload(filename)
    end
  end
  
  desc "Create CouchDB reference data"
  task :data => [:check_env, :merb_env] do
    Dir['couchdb/data/reference/**/*.rb'].each do |filename|
      require filename
    end
  end

  desc "Create CouchDB sample data"
  task :sample => [:check_env, :merb_env] do
    Dir['couchdb/data/sample/**/*.rb'].each do |filename|
      require filename
    end
  end

  task :check_env do
    unless ENV['MERB_ENV']
      puts "MERB_ENV must be specified. Example: rake relaxdb MERB_ENV=development"
      exit(1)
    end
  end

end

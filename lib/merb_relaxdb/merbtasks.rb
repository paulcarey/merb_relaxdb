desc "Create CouchDB environment from scratch"
task :relaxdb => ["relaxdb:db", "relaxdb:views", "relaxdb:data", "relaxdb:sample"]

namespace :relaxdb do

  desc "Create CouchDB database"
  task :db => [:check_env] do
    puts "Creating db #{RelaxDB.db.name}"
    
    RelaxDB.delete_db(RelaxDB.db.name) rescue "ok"
    RelaxDB.use_db(RelaxDB.db.name)
  end

  desc "Create CouchDB views auto generated on model load"
  task :autoviews => [:check_env] do
    puts "Creating auto generated views"
    RelaxDB.use_db RelaxDB.db.name    
    RelaxDB.create_views
    Rake::Task["merb_env"].invoke
  end
  
  desc "Create CouchDB views from hand coded JavaScript"
  task :hand_coded_views => [:check_env] do
    puts "Creating hand coded views"
    
    Dir['couchdb/views/**/*.js'].each do |filename|
      RelaxDB::ViewUploader.upload(filename)
    end
  end
  
  desc "Create hand coded and auto generated views"
  task :views => [:autoviews, :hand_coded_views]
  
  desc "Create CouchDB reference data"
  task :data => [:check_env, :merb_env] do
    puts "Creating ref data"
    
    Dir['couchdb/data/reference/**/*.rb'].each do |filename|
      require filename
    end
  end

  desc "Create CouchDB sample data"
  task :sample => [:check_env, :merb_env] do
    create_sample_data
  end
  
  desc "Create base CouchDB environment from scratch (no sample data)"
  task :basedb => ["relaxdb:db", "relaxdb:views", "relaxdb:data"]  

  task :check_env do
    unless ENV['MERB_ENV']
      puts "MERB_ENV must be specified. Example: rake relaxdb MERB_ENV=development"
      exit(1)
    end
  end

  def create_sample_data
    Dir['couchdb/data/sample/**/*.rb'].each do |filename|
      require filename
    end
  end

end

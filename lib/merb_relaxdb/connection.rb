require 'rubygems'
require 'relaxdb'

module Merb
  module RelaxDB
    
    class << self
      
      def connect
        set_database
        begin
          ::RelaxDB.db.get
          Merb.logger.info "RelaxDB connected to CouchDB #{::RelaxDB.db.url}"
        rescue
          puts "RelaxDB could not connect to CouchDB at #{::RelaxDB.db.url} Exiting..."
          Merb.logger.error "RelaxDB could not connect to CouchDB at #{::RelaxDB.db.url} Exiting..."
          exit(1)
        end
      end
      
      def set_database
        config_file = Merb.root / "config" / "couchdb.yml"
        full_config = Erubis.load_yaml_file(config_file)
        config = full_config[Merb.environment.to_sym]
        ::RelaxDB.configure(config)
      end
                  
    end
    
  end
end

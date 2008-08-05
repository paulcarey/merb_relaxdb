require 'rubygems'
require 'relaxdb'

module Merb
  module RelaxDB
    
    class << self
      
      def connect
        begin
          set_database
          ::RelaxDB.db.get
          Merb.logger.info "RelaxDB connected to CouchDB #{::RelaxDB.db.url}"
        rescue
          Merb.logger.error "RelaxDB could not connect to CouchDB at #{::RelaxDB.db.url} Exiting..."
          exit(1)
        end
      end
      
      def set_database
        config_file = Merb.root / "config" / "couchdb.yml"
        full_config = Erubis.load_yaml_file(config_file)
        config = full_config[Merb.environment.to_sym]
        config[:logger] = Merb.logger
        ::RelaxDB.configure(config)
      end
                  
    end
    
  end
end

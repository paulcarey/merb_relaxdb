module Merb
  module RelaxDB
    
    class << self
      
      def connect
        begin
          set_database
          ::RelaxDB.db.get
          Merb.logger.info "RelaxDB connected to CouchDB #{::RelaxDB.db.uri}"
        rescue => e
          uri = ::RelaxDB.db ? ::RelaxDB.db.uri : "<initialisation error>"
          Merb.logger.fatal "RelaxDB could not connect to CouchDB at #{uri} \n\tRoot cause:#{e}\n#{e.backtrace.join("\n")}"
          exit(1)
        end
      end
      
      def set_database
        config_file = Merb.root / "config" / "couchdb.yml"
        full_config = Erubis.load_yaml_file(config_file)
        config = full_config[Merb.environment.to_sym]
        config[:logger] = Merb.logger
        ::RelaxDB.configure(config)
        ::RelaxDB.use_db(config[:db])
      end
                  
    end
    
  end
end

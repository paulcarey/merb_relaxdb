module Merb
  module RelaxDB
    
    class << self
      
      def config_file() Merb.dir_for(:config) / "couchdb.yml" end
      def sample_dest() Merb.dir_for(:config) / "couchdb.yml.sample" end
      def sample_source() File.dirname(__FILE__) / "couchdb.yml.sample" end
      
      def connect
        begin
          configure_db
          ::RelaxDB.db.get
          Merb.logger.info "RelaxDB connected to CouchDB #{::RelaxDB.db.uri}"
        rescue => e
          uri = ::RelaxDB.db ? ::RelaxDB.db.uri : "<initialisation error>"
          Merb.logger.fatal "RelaxDB could not connect to CouchDB at #{uri} \n\tRoot cause:#{e}\n#{e.backtrace.join("\n")}"
          exit(1)
        end
      end
      
      def configure_db
        if File.exists?(config_file)        
          full_config = Erubis.load_yaml_file(config_file)
          config = full_config[Merb.environment.to_sym]
          config[:logger] = Merb.logger
          ::RelaxDB.configure(config)
          ::RelaxDB.use_db(config[:db])
        else
          copy_sample_config
          Merb.logger.error! "No couchdb.yml file found in #{Merb.root}/config."
          Merb.logger.error! "A sample file was created called couchdb.yml.sample for you to copy and edit."
          exit(1)
        end          
      end

      def copy_sample_config
        FileUtils.cp sample_source, sample_dest unless File.exists?(sample_dest)
      end
                  
    end
    
  end
end

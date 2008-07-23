require 'rubygems'
require 'relaxdb'

module Merb
  module RelaxDB
    
    class << self
      
      def connect
        set_database
        begin
          ::RelaxDB::Database.std_db.get
          Merb.logger.info "RelaxDB connected to CouchDB #{config_to_url}"
        rescue
          Merb.logger.error "RelaxDB could not connect to CouchDB at #{config_to_url}"
          exit(1)
        end
      end
      
      def set_database
        config_file = Merb.root / "config" / "couchdb.yml"
        full_config = Erubis.load_yaml_file(config_file)
        @config = full_config[Merb.environment.to_sym]
        ::RelaxDB::Database.set_std_db(@config)
      end
      
      def config_to_url
        "http://#{@config[:host]}:#{@config[:port]}/#{@config[:db]}"
      end
            
    end
    
  end
end

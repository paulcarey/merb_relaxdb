# make sure we're running inside Merb
if defined?(Merb::Plugins)
  
  # As of Merb 1.1 the RelaxDB dependency should be expressed in the app's Gemfile
  # dependency "relaxdb"

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_relaxdb] = {
    :chickens => false
  }
  
  Merb::BootLoader.before_app_loads do
    require "yaml"
    require "merb_relaxdb/connection.rb"  
    Merb::RelaxDB.connect
  end
  
  Merb::BootLoader.after_app_loads do
  end
  
  Merb::Plugins.add_rakefiles "merb_relaxdb/merbtasks"
      
end

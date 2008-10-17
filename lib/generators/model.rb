Merb::Generators::ModelGenerator.template :model_relaxdb, :orm => :relaxdb do |template|
  template.source = File.dirname(__FILE__) / "templates/model/app/models/%file_name%.rb"
  template.destination = "app/models" / base_path / "#{file_name}.rb"
end

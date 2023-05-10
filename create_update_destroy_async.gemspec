require_relative "lib/create_update_destroy_async/version"

Gem::Specification.new do |spec|
  spec.name        = "create_update_destroy_async"
  spec.version     = CreateUpdateDestroyAsync::VERSION
  spec.authors     = ["Igor Kasyanchuk", "Liubomyr Manastyretskyi"]
  spec.email       = ["igorkasyanchuk@gmail.com", "manastyretskyi@gmail.com"]
  spec.homepage    = "https://github.com/railsjazz/create_update_destroy_async"
  spec.summary     = "Summary of CreateUpdateDestroyAsync."
  spec.description = "Description of CreateUpdateDestroyAsync."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails"
  spec.add_dependency "activejob"
  spec.add_development_dependency "pry"
end

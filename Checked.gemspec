# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "Checked/version"

Gem::Specification.new do |s|
  s.name        = "Checked"
  s.version     = Checked::VERSION
  s.authors     = ["da99"]
  s.email       = ["i-hate-spam-45671204@mailinator.com"]
  s.homepage    = ""
  s.summary     = %q{Check your types and more.}
  s.description = %q{
    Various DSLs to clean, question (Ask), and validate (Demand) your objects,
  their classes (data types), and their properties.
  }

  s.rubyforge_project = "Checked"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bacon'
  s.add_development_dependency 'Bacon_Colored'
end

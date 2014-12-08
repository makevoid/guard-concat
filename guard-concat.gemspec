require_relative "lib/guard/concat/version"

Gem::Specification.new do |s|
  s.name         = "guard-concat"
  s.author       = "Francesco 'makevoid' Canessa"
  s.email        = "makevoid@gmail.com"
  s.summary      = "Guard gem for concatenating (js/css) files"
  s.homepage     = "http://github.com/makevoid/guard-concat"
  s.version      = Guard::ConcatVersion::VERSION
  s.platform     = Gem::Platform::RUBY

  s.description  = <<-DESC
    Guard::Concat automatically concatenates files in one when watched files are modified.
  DESC

  s.add_dependency "guard", ">= 2.0"

  s.files        = %w(Readme.md LICENSE)
  s.files       += Dir["{lib}/**/*"]
end

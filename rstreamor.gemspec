# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rstreamor/version'

Gem::Specification.new do |spec|
  spec.name = 'rstreamor'
  spec.version = Rstreamor::VERSION
  spec.authors = ['Erwin Schens']
  spec.email = ['erwinschens@uni-koblenz.de']

  spec.summary = %q{Stream files using HTTP range requests.}
  spec.description = %q{
                        Rstreamor gives you the power to stream your files using the HTTP range requests defined in the HTTP/1.1.
                        Range requests are an optional feature of HTTP,
                        designed so that recipients not implementing this feature
                        (or not supporting it for the target resource) can respond as if
                        it is a normal GET request without impacting interoperability.
                         Partial responses are indicated by a distinct status code to not be mistaken for full responses by caches that might not implement the feature.
                      }
  spec.homepage = 'https://github.com/ndea/rstreamor'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
end

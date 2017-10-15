# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nifcloud/version"

Gem::Specification.new do |spec|
  spec.name = "nifcloud"
  spec.version = Nifcloud::VERSION
  spec.authors = ["Kazuki Iwata"]
  spec.email = ["kazu.0516.k0n0f@gmail.com"]

  spec.summary = %q{Unofficial NIFCLOUD SDK for Ruby}
  spec.description = %q{The Unofficial NIFCLOUD SDK for Ruby}
  spec.homepage = "https://github.com/kzmake/nifcloud"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'

  spec.add_runtime_dependency 'xml-simple'
  spec.add_runtime_dependency 'httpclient'
end

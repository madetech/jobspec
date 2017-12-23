LIB = File.expand_path('../lib',  __FILE__)
require File.join(LIB, 'job_spec/version')

Gem::Specification.new do |spec|
  spec.name          = 'job_spec'
  spec.version       = JobSpec::VERSION
  spec.authors       = ['Luke Morton']
  spec.email         = ['luke@madetech.com']

  spec.summary       = %q{Define job specs in ruby and publish to markdown}
  spec.homepage      = 'https://github.com/madetech/job_spec'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(example|spec)/}) }
  spec.executables   = ['jobspec']
  spec.require_paths = ['lib']

  spec.add_dependency 'bundler'
  spec.add_dependency 'thor'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end

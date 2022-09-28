
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/mutiny/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-mutiny'
  spec.version       = Rubocop::Mutiny::VERSION
  spec.authors       = ['Nikhil Mathew']
  spec.email         = ['nikhilmat@gmail.com']

  spec.summary       = 'Rubocop configuration for Mutiny Ruby applications.'
  spec.homepage      = 'https://github.com/nikhilmat/rubocop-mutiny'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop', '~> 1.36'
  spec.add_dependency 'rubocop-rails', '~> 2.16.1'
  spec.add_dependency 'rubocop-rspec', '~> 2.13.2'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.7'
end

require File.expand_path('../lib/kot/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'kot'
  s.version     = Kot::VERSION
  s.summary     = 'Kot is a basic toolkit for getting started with computerised adaptive testing (CAT).'
  s.description = <<-EOF
  Kot is a basic toolkit for getting started with computerised adaptive testing (CAT). It includes a module to calculate item response theory (IRT) statistics for dichotomous items with 1-4PL characteristic curves (ICCs), a Hill Climbing ability (theta) estimator, a Randomesque selector and a Test class to make tying all this together easier.
EOF
  s.authors     = ['Adam Watkins']
  s.files       = Dir['lib/**/*.rb', 'lib/kot.rb']
  s.license     = 'GPL-3.0+'
  s.homepage    = 'https://github.com/stupidpupil/kot'

end

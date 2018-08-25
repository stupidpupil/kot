# Kot

[![Build Status](https://travis-ci.org/stupidpupil/kot.svg?branch=master)](https://travis-ci.org/stupidpupil/kot)
[![Code Climate](https://codeclimate.com/github/stupidpupil/kot/badges/gpa.svg)](https://codeclimate.com/github/stupidpupil/kot)
[![Docs](http://inch-ci.org/github/stupidpupil/kot.svg?branch=master&style=shields)](http://www.rubydoc.info/github/stupidpupil/kot)
[![Gem](https://img.shields.io/gem/v/kot.svg?maxAge=2592000)](https://rubygems.org/gems/kot)

Kot is a basic toolkit for getting started with computerised adaptive testing (CAT) in Ruby.

It includes:
  - a module to calculate item response theory (IRT) statistics for dichotomous items with 1-4PL characteristic curves (ICCs), 
  - a Hill Climbing ability (theta) estimator, 
  - a Randomesque selector and 
  - a Test class to make tying all this together easier.
  
## Thanks to
douglasrizzo's [catsim](https://github.com/douglasrizzo/catsim) and its excellent documentation, 
without which I wouldn't have been able to cobble this together.
 
## License
This gem is licensed under the [GNU GPL v3.0 or later](https://choosealicense.com/licenses/gpl-3.0/).

module Kot

  # An example of an Item class. You probably don't want to inherit from this, 
  # but instead to include {ItemResponseTheory} in a class of your own that 
  # provides {#a}, {#b}, {#c} and {#d}.
  #
  # This class is useful for simulating different CAT setups and is used
  # for some of the tests of this library.
  class Item4PL
    include Kot::ItemResponseTheory

    attr_reader :a, :b, :c, :d

    # @!attribute [r] a
    #   Discrimination ability of the item.
    #   This describe the maximum slope of the item's ICC, at the point given by {#b},
    #   and so how sharply the item distinguishes between those with ability below and above that point.
    #
    #   Usually set to 1.0 for 1PL models.
    #   @return [Float] Discrimination

    # @!attribute [r] b
    #   Difficulty of the item.
    #   This describes the midpoint of the item's ICC, where p(b)=0.5, 
    #   and so the point at which half of those with a _theta_ equal to _b_ will answer
    #   the item correctly and half will answer it incorrectly.
    #   @return [Float] Difficulty

    # @!attribute [r] c
    #   Likelihood of guesing the item.
    #   This describes the lower asymptote of the item's ICC,
    #   and so the lowest probability of answering correctly regardless of ability.
    #
    #   Usually set to 0.0 for 1-2PL models.
    #   @return [Float] Guessing

    # @!attribute [r] d
    #   Maximum likelihood of answering correctly.
    #   This describes the upper asymptote of the item's ICC,
    #   and so the highest probability of answering correctly regardless of ability.
    #
    #   Usually set to 1.0 for 1-3PL models.
    #   @return [Float] Insurmountable difficulty

    def self.[](*arr)
      arr.map { |a| Item4PL.new(a) }
    end

    # @see https://stackoverflow.com/questions/5825680/code-to-generate-gaussian-normally-distributed-random-numbers-in-ruby
    def self.gaussian(mean = 0.0, stddev = 1.0, rand = lambda{ Kernel.rand } )
      theta = 2 * Math::PI * rand.call
      rho = Math.sqrt(-2 * Math.log(1 - rand.call))
      scale = stddev * rho
      mean + scale * Math.cos(theta)
    end

    def self.generate(n = nil)
      return Item4PL.new(b:gaussian()) if n.nil?
      Array.new(n) { generate }
    end

    def initialize(a: 1.0, b: 0.0, c: 0.0, d: 1.0)
      @a = a
      @b = b
      @c = c
      @d = d
    end

    def to_s
      "<Item4PL a:#{a} b:#{b} c:#{c} d#{d} >"
    end
  end
end

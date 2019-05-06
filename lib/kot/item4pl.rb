module Kot

  # An example of an Item class. You probably don't want to inherit from this, 
  # but instead to include {ItemResponseTheory} in a class of your own that 
  # provides {#a}, {#b}, {#c} and {#d}. See those attribute definitions for
  # more information about what each parameter means in the context of
  # correct/incorrect tests of ability.
  #
  # This class is useful for simulating different CAT setups and is used
  # for some of the specification tests of this library.
  class Item4PL
    include Kot::ItemResponseTheory

    attr_reader :a, :b, :c, :d

    # @!attribute [r] a
    #   Discrimination ability of the item.
    #   This describe the maximum slope of the item's ICC, at the point given by {#b},
    #   and so how sharply the item distinguishes between those with ability below and above that point.
    #
    #   An item with an _a_ of zero would have an entirely flat ICC (and so be completely useless),
    #   while an item with an infinitely high _a_ would perfectly discriminate such that anyone with an ability
    #   of *less* *than* _b_ would have _c_ probability of getting the answer right and anyone with an ability
    #   *greater* *than* _b_ would have _d_ probability of getting the answer right.
    #
    #   Usually set to 1.0 for 1PL models.
    #   @return [Float] Discrimination

    # @!attribute [r] b
    #   Difficulty of the item.
    #   This describes the midpoint of the item's ICC, where P(_b_)=0.5, 
    #   and so the point at which half of those with a _theta_ equal to _b_ will answer
    #   the item correctly and half will answer it incorrectly.
    #
    #   _b_ is the parameter required by any model, and across the bank of items usually
    #    will range over the distribution of test-takers' ability.
    #   (Often the distribution of ability is conceived as N(0,1).)
    #
    #   @return [Float] Difficulty

    # @!attribute [r] c
    #   Minimum likelihood of guessing the item.
    #   This describes the lower asymptote of the item's ICC,
    #   and so the lowest probability of answering correctly regardless of ability.
    #
    #   It can often be thought of as the probability of guessing the correct answer.
    #   For example, a multiple choice test item with 5 possible answers,
    #   one of which is correct, might have a _c_ of 1/5 or 0.2 .
    #
    #   Usually set to 0.0 for 1-2PL models.
    #   @return [Float] Guessing

    # @!attribute [r] d
    #   Maximum likelihood of answering correctly.
    #   This describes the upper asymptote of the item's ICC,
    #   and so the highest probability of answering correctly regardless of ability.
    #
    #   This parameter is more common in contexts outside of testing ability
    #   such as cognitive and clinical measures.
    #
    #   Usually set to 1.0 for 1-3PL models.
    #   @return [Float] Insurmountable difficulty


    # @param arr [Array<Hash>] an array of hashes describing Item4PL parameters
    # @return [Array<Item4PL>] an array of Item4PLs
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

    # @return [Item4PL] a 1PL Item4PL with a {#b} chosen randomly from N(0,1)
    # @return [Array<Item4PL>] an array of 1PL Item4PLs with {#b}s chosen randomly from N(0,1)
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

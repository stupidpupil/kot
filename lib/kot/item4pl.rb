module Kot

  class Item4PL
    include Kot::ItemResponseTheory

    attr_reader :a, :b, :c, :d

    # @!attribute [r] a
    #   @return [Float] discrimination/maximum slope

    # @!attribute [r] b
    #   @return [Float] difficulty/midpoint

    # @!attribute [r] c
    #   @return [Float] guessing/lower asymptote

    # @!attribute [r] d
    #   @return [Float] insurmountable difficulty/upper asymptote

    def self.[](*arr)
      arr.map {|a| Item4PL.new(a)}
    end

    # https://stackoverflow.com/questions/5825680/code-to-generate-gaussian-normally-distributed-random-numbers-in-ruby
    def self.gaussian(mean=0.0, stddev=1.0, rand= lambda{Kernel.rand} )
      theta = 2 * Math::PI * rand.call
      rho = Math.sqrt(-2 * Math.log(1 - rand.call))
      scale = stddev * rho
      x = mean + scale * Math.cos(theta)
      return x
    end

    def self.generate(n=nil)
      return Item4PL.new(b:gaussian()) if n.nil?

      return Array.new(n) { generate() }
    end

    def initialize(a:1.0, b:0.0, c:0.0, d:1.0)
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
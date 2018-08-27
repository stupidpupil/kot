module Kot

  # Include this module into a class to give various IRT statistics for individual items.
  # Including classes are expected to respond to #a, #b, #c and #d ; see the example {Item4PL} class for more information.
  #
  # Class methods for this module provide IRT statistics for a set of items,
  # given an individual's estimated theta (and sometimes their responses to those items).
  module ItemResponseTheory

    # @param est_theta [Float] an estimate of an individual's ability
    # @param responses [Array<TrueClass, FalseClass>] the responses given by an individual to _items_
    # @param items [Array<ItemResponseTheory>] items that an individual has responded to
    # @return [Float]
    def self.log_likelihood(est_theta, responses, items)
      ps = items.map { |i| i.icc(est_theta) }
      ls = ps.each_with_index.map { |e, i| responses[i] ? Math.log(e) : Math.log(1.0 - e) } 
      # TODO: Polychotomous
      ls.inject(:+)
    end

    # @param est_theta [Float] an estimate of an individual's ability
    # @param items [Array<ItemResponseTheory>] items that an individual has responded to
    # @return [Float]
    def self.test_info(est_theta, items)
      items.map { |i| i.inf(est_theta) }.inject(:+)
    end

    # @param est_theta [Float] an estimate of an individual's ability
    # @param items [Array<ItemResponseTheory>] items that an individual has responded to
    # @return [Float]
    def self.var(est_theta, items)
      1.0 / test_info(est_theta, items)
    end

    # @param est_theta [Float] an estimate of an individual's ability
    # @param items [Array<ItemResponseTheory>] items that an individual has responded to
    # @return [Float] standard error of estimation
    def self.see(est_theta, items)
      Math.sqrt(var(est_theta, items))
    end

    # Item characteristic curve
    # @return [Float] the probability of someone with ability _theta_ of answering this item correctly
    def icc(theta)
      icc_component = Math.exp(-a * (theta - b))
      c + ((d - c) / (1.0 + icc_component))
    end

    # Item information function
    # @return [Float] a measure of the information that would be provided by a response to this item given a prior _theta_
    def inf(theta)
      vp = icc(theta)

      top = (a ** 2) * ((vp - c) ** 2) * ((d - vp) ** 2)
      bottom = ((d - c) ** 2) * vp * (1.0 - vp)

      top / bottom
    end

  end
end

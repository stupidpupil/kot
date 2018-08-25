module Kot

  # Include this module into a class to give various IRT statistics for individual items.
  # Classes are expected to respond to #a, #b, #c and #d ; see the example {Item4PL} class for more information.
  module ItemResponseTheory

    def self.log_likelihood(est_theta, responses, items)
      ps = items.map { |i| i.icc(est_theta) }
      ls = ps.each_with_index.map { |e, i| responses[i] ? Math.log(e) : Math.log(1.0 - e) } 
      # TODO: Polychotomous
      ls.inject(:+)
    end

    def self.test_info(est_theta, items)
      items.map { |i| i.inf(est_theta) }.inject(:+)
    end

    def self.var(est_theta, items)
      1.0 / test_info(est_theta, items)
    end

    def self.see(est_theta, items)
      Math.sqrt(var(est_theta, items))
    end

    def icc_component(theta)
      Math.exp(-a * (theta - b))
    end

    # Item characteristic curve
    def icc(theta)
      c + ((d - c) / (1.0 + icc_component(theta)))
    end

    # Information value of an item
    def inf(theta)
      vp = icc(theta)

      top = (a ** 2) * ((vp - c) ** 2) * ((d - vp) ** 2)
      bottom = ((d - c) ** 2) * vp * (1.0 - vp)

      top / bottom
    end

  end
end

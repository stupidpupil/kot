module Kot

  class RandomesqueSelector

    def initialize(bin_size = 5)
      @bin_size = bin_size
    end

    def select(est_theta, possible_items)
      possible_items.sort_by { |i| - i.inf(est_theta) }.
        slice(0, @bin_size).sample
    end

  end
end

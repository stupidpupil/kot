module Kot


  class Test

    attr_reader :est_theta

    def initialize(item_bank, est_theta = 0.0, selector = RandomesqueSelector.new, estimator = HillClimbingEstimator.new)
      @item_bank = item_bank
      @est_theta = est_theta
      @selector = selector
      @estimator = estimator

      @responses = []
      @asked_items = []
    end


    def see
      return Float::INFINITY if @asked_items.empty?
      ItemResponseTheory.see(@est_theta, @asked_items)
    end

    def update_est_theta
      @est_theta = @estimator.estimate(est_theta: @est_theta, responses:@responses, items:@asked_items, all_items:@item_bank)
    end

    def next_item
      possible_items = @item_bank - @asked_items
      @selector.select(@est_theta, possible_items)
    end

    def respond(response, item)
      @responses << response
      @asked_items << item
      update_est_theta
    end

  end

end
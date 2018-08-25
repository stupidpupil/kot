module Kot

  class HillClimbingEstimator



    # "The variable stepsize changed the 0 estimate by half the distance to the appropriate ... value in the item pool."
    def dodd(est_theta:0.0, items:[], last_response:[])
      max_b = items.map(&:b).max
      min_b = items.map(&:b).min

      last_response ? est_theta + ((max_b - est_theta) / 2.0) : est_theta - ((est_theta - min_b) / 2.0)
    end


    def estimate_iteration(best_theta, max_ll, lower_bound, upper_bound, responses, items)

        step_size = (upper_bound - lower_bound) /  10
        intervals = (lower_bound...upper_bound).step(step_size.abs)

        intervals.each do |ii|

          ll = ItemResponseTheory.log_likelihood(ii, responses, items)

          if ll > max_ll
            max_ll = ll

            #TODO - precision-based early exit
            best_theta = ii
          else
            lower_bound = best_theta - step_size.abs
            upper_bound = ii
            break
          end

        end

        return best_theta, max_ll, lower_bound, upper_bound
    end

    def estimate(responses:[], items:[], all_items:[], est_theta:0.0)
      if responses.uniq.count == 1
        raise ArgumentError.new("Responses are all #{responses.first} but missing all_items argument") if all_items.empty?
        return dodd(est_theta:est_theta, items:all_items, last_response:responses.last)
      end

      lower_bound = items.map(&:b).min
      upper_bound = items.map(&:b).max

      return lower_bound if upper_bound == lower_bound

      best_theta = - Float::INFINITY
      max_ll = - Float::INFINITY

      old_best_theta = best_theta

      10.times do
        best_theta, max_ll, lower_bound, upper_bound = 
          estimate_iteration(best_theta, max_ll, lower_bound, upper_bound, responses, items)
      end

      return best_theta
    end

  end

end
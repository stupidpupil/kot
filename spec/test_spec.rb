describe Kot::Test do

  describe 'when I create a test with 100 possible generated items and test 100 equal-ability individuals with 20 items ' do
    item_bank = Item4PL.generate(100)

    outside_of_two_see = 0
    outside_of_three_see = 0
    sees = []
    thetas = []

    real_icc = (rand()*3)-1.5

    100.times do |j|
      t = Kot::Test.new(item_bank)

      10.times do |i|
        item = t.next_item
        resp = (item.icc(real_icc) >= rand())
        t.respond(resp, item)
      end

      outside_of_two_see += 1 if (t.est_theta - real_icc).abs > (2*t.see)
      outside_of_three_see += 1 if (t.est_theta - real_icc).abs > (3*t.see)

      sees << t.see
      thetas << t.est_theta
    end


    it "must tend to get close to the individuals' real ICC" do
      (thetas.inject(:+)/thetas.count).should.be.close real_icc, 0.25
      outside_of_two_see.should.be.close 5, 5 #95%?
      outside_of_three_see.should.be.close 0, 5
    end

  end

end
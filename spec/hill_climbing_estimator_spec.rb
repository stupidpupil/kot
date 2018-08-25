describe Kot::HillClimbingEstimator do

  describe 'when given items [b:0.5, b:0.5] and responses [true, false]' do

    it 'should give an estimated theta of 0.5' do
      Kot::HillClimbingEstimator.new.estimate(
        items:Item4PL[{b:0.5}, {b:0.5}], 
        responses:[true, false]
      ).should.equal 0.5
    end

  end

  describe 'when given items [b:0.2, b:0.5, b:0.5, b:0.8] and responses [true, true, false, false]' do

    it 'should give an estimated theta of 0.5' do
      Kot::HillClimbingEstimator.new.estimate(
        items:Item4PL[{b:0.2}, {b:0.5}, {b:0.5}, {b:0.8}], 
        responses:[true, true, false, false]
      ).should.equal 0.5
    end
  end


  describe 'when given items [b:y-x, b:y, b:y, b:y+x] and responses [true, true, false, false]' do

    it 'should give an estimated theta of very close to y' do

      y = (rand()*4)-2
      x = (rand()*2)

      Kot::HillClimbingEstimator.new.estimate(
        items:Item4PL[{b:y-x}, {b:y}, {b:y}, {b:y+x}], 
        responses:[true, true, false, false]
      ).should.be.close y, 0.01
    end
  end

  describe 'when given items [b:y-x, b:y+x] and responses [true, false]' do

    it 'should give an estimated theta of very close to y' do

      y = (rand()*4)-2
      x = (rand()*2)

      Kot::HillClimbingEstimator.new.estimate(
        items:Item4PL[{b:y-x}, {b:y+x}], 
        responses:[true, false]
      ).should.be.close y, 0.01
    end
  end

  describe 'when given all items [b:0.5] and responses [true]' do

    # Assumes an prior estimated theta of 0.0 and uses Dodd's method
    it 'should give an estimated theta of 0.25' do
      Kot::HillClimbingEstimator.new.estimate(
        all_items:Item4PL[{b:0.5}],
        responses:[true]
      ).should.equal 0.25
    end

  end


end
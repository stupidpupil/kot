describe Kot::RandomesqueSelector do

  describe 'when given a well-distributed item bank' do
    item_bank = Kot::Item4PL.generate(100)
    s = Kot::RandomesqueSelector.new()

    it 'and a theta of 0 pick an item with a b near 0' do
      s.select(0.0, item_bank).b.should.be.close 0.0, 0.25
    end

    it 'and a theta of -1.0 pick an item with a b near -1.0' do
      s.select(-1.0, item_bank).b.should.be.close -1.0, 0.25
    end

    it 'and a theta of x pick an item with a b near x' do
      x = (rand*3)-1.5
      s.select(x, item_bank).b.should.be.close x, 0.25
    end

  end

end

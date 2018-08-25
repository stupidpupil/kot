
describe Kot::ItemResponseTheory do
  describe 'when I create an Item with a:0.0' do
    @item = Kot::Item4PL.new(a:0.0)

    it 'must have a uniform ICC' do
      @item.icc(-2).should.equal 0.5
      @item.icc(-1).should.equal 0.5
      @item.icc(0).should.equal 0.5
      @item.icc(+1).should.equal 0.5
      @item.icc(+2).should.equal 0.5
    end

  end  


  describe 'when I create an Item with a:INFINITY and b:0.0' do
    @item = Kot::Item4PL.new(a:Float::INFINITY, b:0.0)

    it 'must have a sharp ICC' do
      @item.icc(-2).should.equal 0.0
      @item.icc(-1).should.equal 0.0
      @item.icc(+1).should.equal 1.0
      @item.icc(+2).should.equal 1.0
    end

  end  

  describe 'when I create an Item with a:1 and b:0.0' do
    @item = Kot::Item4PL.new(a:1.0, b:0.0)

    it 'must have the right ICC' do
      @item.icc(-2).should.be.close 0.0, 0.2
      @item.icc(0).should.equal 0.5
      @item.icc(+2).should.be.close 1.0, 0.2
    end
  end  

  describe 'when I create an Item with a:1, b:0.0, c:0.4, d:0.6' do
    @item = Kot::Item4PL.new(a:1.0, b:0.0, c:0.4, d:0.6)

    it 'must have the right ICC' do
      @item.icc(-2).should.be.close 0.4, 0.05
      @item.icc(0).should.equal 0.5
      @item.icc(+2).should.be.close 0.6, 0.05
    end
  end  

end
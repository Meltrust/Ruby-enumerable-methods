require './enumerables.rb'

describe Enumerable do
  # main testing variables
  let(:arr1) { %w[dog bear cat] }
  let(:arr2) { [true, nil, 90] }
  let(:arr3) { [1, 2, 3, 4, 5] }
  let(:arr4) { [true, false, nil] }

  describe '#my_each' do
    it 'every element of an array is passed to a block by this method' do
      expect(arr1.each { |a| }).to eql(%w[dog bear cat])
    end
  end

  describe '#my_each_with_index' do
    it 'every element of an array is passed to a block with its index by this method' do
      expect(arr1.my_each_with_index { |a, i| }).to eql(%w[dog bear cat])
    end
  end

  describe '#my_select' do
    it 'returns an array with all the elements that are true to the given block condition' do
      expect(arr3.my_select { |i| i % 3 == 0 }).to eql([3])
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements are true to the block given' do
      expect(arr1.my_all? { |word| word.length >= 3 }).to be true
    end
  end

  describe '#my_any?' do
    it 'returns true if any element is true to the block given' do
      expect(arr3.my_any? { |number| number == 5 }).to be true
    end
  end

  describe '#my_none?' do
    it 'returns true if no element to the block given is true' do
      expect(arr3.my_none? { |number| number == 7 }).to be true
    end
  end

  describe '#my_count' do
    it 'returns the number of items of the array' do
      expect(arr3.my_count).to eql(5)
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of passing a block to a given array' do
      expect(arr3.my_map { |number| number * 3 }).to eql([3, 6, 9, 12, 15])
    end
  end

  describe '#my_inject' do
    it 'returns a combination of all the elements with a binary operation specified by a symbol' do
      expect(arr3.my_inject(:*)).to eql(120)
    end
  end
end

require './enumerables.rb'

describe Enumerable do
  # main testing variables
  let(:arr1) { %w[dog bear cat] }
  let(:arr2) { [true, nil, 90] }
  let(:arr3) { [1, 2, 3, 4, 5] }
  let(:arr4) { [true, false, nil] }

  describe '#my_each' do
    it 'every element of an array is passed to a block by this method' do
      expect(arr1.my_each { |a| }).to eql(%w[dog bear cat])
    end

    it 'returns enumerator if no block given' do
      expect(arr4.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'every element of an array is passed to a block with its index by this method' do
      expect(arr1.my_each_with_index { |a, i| }).to eql(%w[dog bear cat])
    end

    it 'returns enumerator if no block given' do
      expect(arr4.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array with all the elements that are true to the given block condition' do
      expect(arr3.my_select { |i| i % 3 == 0 }).to eql([3])
    end

    it 'returns enumerator if no block given' do
      expect(arr2.each).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements are true to the block given' do
      expect(arr1.my_all? { |word| word.length >= 3 }).to be true
    end

    it 'returns true if no block is given and none of the elements are false or nil' do
      expect(arr3.my_all?).to be true
    end

    it 'returns true if a pattern is supplied and whether patter === element for every collection member' do
      expect(arr1.my_all?(/t/)).to be false
    end
  end

  describe '#my_any?' do
    it 'returns true if any element is true to the block given' do
      expect(arr3.my_any? { |number| number == 5 }).to be true
    end

    it 'returns true if a block is not given and at least one elements is not false or nil' do
      expect(arr2.my_any?(Integer)).to be true
    end

    it 'returns true if a pattern is supplied and whether patter === element for any collection member' do
      expect(arr1.my_any?(/t/)).to be true
    end
  end

  describe '#my_none?' do
    it 'returns true if no element to the block given is true' do
      expect(arr3.my_none? { |number| number == 7 }).to be true
    end

    it 'returns true if no block is given and none of the elements are true' do
      expect(arr1.my_none?).to be false
    end

    it 'returns true if a pattern is supplied and whether patter === element for none of the collection members' do
      expect(arr2.my_none?(/h/)).to be true
    end
  end

  describe '#my_count' do
    it 'returns the number of items of the array' do
      expect(arr3.my_count).to eql(5)
    end

    it 'returns the number of items that are equal to item is a argument is given' do
      expect(arr3.my_count(2)).to eql(1)
    end

    it 'returns the number of elements yielding a true value if a block is given' do
      expect(arr3.my_count { |num| num < 6 }).to eql(5)
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of passing a block to a given array' do
      expect(arr3.my_map { |number| number * 3 }).to eql([3, 6, 9, 12, 15])
    end

    it 'returns enumerator if no block given' do
      expect(arr4.my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'returns a combination of all the elements with a binary operation specified by a symbol' do
      expect(arr3.my_inject(:*)).to eql(120)
    end

    it 'returns the result of an accumulator value if you specify a block with a accumulator' do
      expect(arr3.my_inject { |memo, number| memo + number }).to eql(15)
    end

    it 'returns the cummulative value of a operation given in a block starting with a value passed as an argument' do
      expect(arr3.my_inject(10) { |memo, number| memo + number }).to eql(25)
    end

    it 'returns the cummulative value of a operation of a symbol given, starting with a value passed as argument' do
      expect(arr3.my_inject(3, :*)).to eql(360)
    end

    it 'returns a error if no argument or block is given' do
      expect { arr3.my_inject }.to raise_exception('no block given')
    end
  end
end

# frozen_string_literal: true

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
end

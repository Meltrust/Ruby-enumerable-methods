# frozen_string_literal: true

require './enumerables.rb'

RSpec.describe Enumerable do
  let(:arr1) { %w[dog bear cat] }
  let(:arr2) { [true, nil, 90] }
  let(:arr3) { [1, 2, 3, 4, 5] }
  let(:arr4) { [true, false, nil] }

  describe '#my_each' do
    it 'every element of an array is passed to a block by this method' do
      expect(arr1.each { |a| a }).to eql(%w[dog bear cat])
    end
  end
end

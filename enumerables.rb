# frozen_string_literal: true

# Adding methods to the enumerable module
module Enumerable
  # my_each method
  def my_each
    return to_enum(:my_each) unless block_given?

    idx = 0

    while idx < size
      yield self[idx]

      idx += 1
    end
  end

  # my_each_index method

  def my_each_index
    to_enum(:my_each) unless block_given?

    each_idx = 0

    while each_idx < size
      yield(self[each_idx], each_idx)

      each_idx += 1
    end
  end

  # my_select method
  def my_select
    to_enum(:my_each) unless block_given?
  end
end

# testing my_each
puts 'Testing my each against [1, 2, 3]'
[1, 2, 3].my_each do |n|
  puts n
end
puts "\n"

# testing my_each_index
puts 'Testing my each against %w[cat dog shark]'
%w[cat dog shark].my_each_index do |idx, each_idx|
  puts "item: #{idx} index: #{each_idx}"
end
puts "\n"

# testing my_select
puts 'Testing my select against [1, 2, 3, 4, 5]=> select even numbers'

[1, 2, 3, 4, 5].select do |num|
  puts num if num.even?
end

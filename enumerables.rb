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
    self
  end

  # my_each_with_index method

  def my_each_with_index
    return to_enum(:my_each_index) unless block_given?

    each_idx = 0

    while each_idx < size
      yield(self[each_idx], each_idx)

      each_idx += 1
    end
  end

  # my_select method
  def my_select
    return to_enum(:my_select) unless block_given?

    select_result = [] if self.class == Array
    select_result = {} if self.class == Hash

    my_each do |x|
      select_result.push(x) if yield(x)
    end
  end

  # my_all method
  def my_all?(par = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given? then my_each { |tf| return false unless yield(tf) }
    elsif par.is_a?(Regexp) then my_each { |tf| return false unless par === tf } # rubocop:disable Style/CaseEquality
    else my_each { |tf| return false if tf == false || tf.nil? }
    end
    true
  end
end
# testing my_each
puts 'Testing my each against [1, 2, 3]'
[1, 2, 3].my_each do |n|
  puts n
end

# testing my_each_index
puts 'Testing my each against %w[cat dog shark]'
%w[cat dog shark].my_each_with_index do |idx, each_idx|
  p "item: #{idx} index: #{each_idx}"
end

# testing my_select
puts 'Testing my select against [1, 2, 3, 4, 5]=> select even numbers'
[1, 2, 3, 4, 5].my_select do |num|
  puts num if num.even?
end

# testing my_all
puts 'Testing my all? against %w[antd befsd catd] all elements >= lenght 4?'
puts(%w[antd befsd catd].my_all? { |word| word.length >= 4 })

puts 'Testing my all? against %w[antbea beatr bea] includes pattern /bea/ ?'
puts(%w[antea batr bea].my_all?(/bea/))

puts 'Testing my all? against [3, 3, nil, "4", 2] no element is false or nil?'
puts([3, 3, false, '4', 2].my_all?)

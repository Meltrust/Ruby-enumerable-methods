# frozen_string_literal: true

require './enumerables.rb'

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

# testing my_any
puts 'Testing my any? against %w[antd befsd catd] any element >= lenght 4?'
puts(%w[antd befsd catd].my_any? { |word| word.length >= 4 })

puts 'Testing my any? against %w[antbea beatr bea] any element includes pattern /bea/ ?'
puts(%w[antea batr bea].my_any?(/bea/))

puts 'Testing my any? against [3, 3, nil, "4", 2] any element is not false or nil?'
puts([3, 3, false, '4', 2].my_any?)

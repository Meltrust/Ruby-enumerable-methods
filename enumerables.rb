# frozen_string_literal: true

# Adding methods to the enumerable module
module Enumerable
  # my_each method
  def my_each
    return to_enum(:my_each) unless block_given?

    idx = 0

    while idx < size
      yield to_a[idx]

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

    select_result = []

    each do |tf|
      select_result.push(tf) if yield(tf)
    end
    select_result
  end

  # my_all method
  def my_all?(par = nil)
    if block_given? then my_each { |tf| return false unless yield(tf) }
    elsif par.is_a?(Regexp) then my_each { |tf| return false unless par === tf }
    else my_each { |tf| return false if tf == false || tf.nil? }
    end
    true
  end

  # my_any method
  def my_any?(par = nil)
    if block_given? then my_each { |tf| return true if yield(tf) || tf.nil? }
    elsif par.is_a?(Regexp) then my_each { |tf| return true if par === tf }
    else my_each { |tf| return true unless tf == false || tf.nil? }
    end
    false
  end

  # my_none method
  def my_none?(par = nil)
    if block_given? then my_each { |tf| return false if yield(tf) }
    elsif par.is_a?(Regexp) then my_each { |tf| return false if par === tf }
    else my_each { |tf| return false unless tf == false || tf.nil? }
    end
    true
  end

  # my_count method
  def my_count(*arg)
    counter = 0
    if block_given? then my_each { |tf| counter += 1 if yield(tf) }
    elsif !block_given? && arg.length == 1 then my_each { |tf| counter += 1 if tf == arg[0] }
    else counter = size
    end
    counter
  end

  # my_map method
  def my_map(proc = nil)
    return to_enum :my_map if !block_given? && proc.nil?

    new_arr = []

    if !block_given? then each { |tf| new_arr.push(proc.call(tf)) }

    else each { |tf| new_arr.push(yield(tf)) }
    end

    new_arr
  end

  # my_inject method
  def my_inject(idx = 0)
    # p idx
    # p size
    # p self[idx]
    acum = to_a[idx]
    if block_given?

      each do
        # index = idx# puts "size = #{size}"
        puts ''
        puts "idx = #{idx}"
        puts ''
        puts "acum = #{acum}"

        break if idx == size - 1

        x = yield(acum, to_a[idx + 1]) and print "used first if=> #{acum} and #{to_a[idx]} " unless idx == size - 1

        acum = x
        idx += 1
        puts "yield result => x = #{x}"

        # puts "acum =  #{x}"
        # p acum
        # acum = acum
        puts "value after acummulating = #{acum}"
        # idx += 1
        puts ''
        # value = acum
      end
    end
    acum
  end
end

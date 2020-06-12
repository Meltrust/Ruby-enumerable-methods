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

  # my_any method
  def my_any?(par = nil) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if block_given? then my_each { |tf| return true if yield(tf) || tf.nil? }
    elsif par.is_a?(Regexp) then my_each { |tf| return true if par === tf } # rubocop:disable Style/CaseEquality
    else my_each { |tf| return true unless tf == false || tf.nil? }
    end
    false
  end
end

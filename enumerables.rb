# Adding methods to the enumerable module
module Enumerable # rubocop:disable Metrics/ModuleLength
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
      yield(to_a[each_idx], each_idx)

      each_idx += 1
    end
    self
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

  def my_all?(par = nil) # rubocop:disable Metrics/PerceivedComplexity
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

  # my_none method
  def my_none?(par = nil) # rubocop:disable Metrics/PerceivedComplexity
    if block_given? then my_each { |tf| return false if yield(tf) }
    elsif par.is_a?(Regexp) then my_each { |tf| return false if par === tf } # rubocop:disable Style/CaseEquality
    else my_each { |tf| return false unless tf == false || tf.nil? }
    end
    true
  end

  # my_count method
  def my_count(*arg)
    counter = 0
    if block_given? then my_each { |tf| counter += 1 if yield(tf) }
    elsif !block_given? && arg.length == 1
      my_each { |tf| counter += 1 if tf == arg[0] }
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
  def my_inject(*arg) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize
    idx = 0
    sym = nil
    if block_given? && (arg.empty? || arg.length == 1)
      acum = arg.empty? ? to_a[idx] : arg[0]
      each do
        break if idx == (size - 1) && arg.empty?

        if arg.empty?
          (x = yield(acum, to_a[idx + 1]))
        else x = yield(acum, to_a[idx])
        end
        acum = x
        idx += 1
      end
    elsif arg.length == 1 && (arg[0].is_a? Symbol)
      idx = 0
      sym = arg[0]
      acum = to_a[idx]
      each do
        break if idx == size - 1

        unless idx == size - 1 then (x = acum.send(sym, to_a[idx + 1]))
        end
        acum = x
        idx += 1
      end
    elsif arg.length == 2 && !block_given?
      sym = arg[1]
      acum = arg[0]
      each do
        (x = acum.send(sym, to_a[idx]))
        acum = x
        idx += 1
      end
    elsif !block_given? && arg.empty?
      raise(LocalJumpError, 'no block given')
    end
    acum
  end
end

def multiply_els(mult)
  mult.my_inject { |memo, n| memo * n }
end

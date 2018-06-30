require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    raise "Out of bounds" if @store[num].nil? || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num%20] << num unless @store[num%20].include?(num)
  end

  def remove(num)
    @store[num%20].delete(num) if @store[num%20].include?(num)
  end

  def include?(num)
    @store[num%20].each {|el| return true if el==num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  
  def insert(num)
    return false if include?(num)
    if num_buckets == @count
      resize!
    end
    @store[num%num_buckets] << num
    @count +=1
    true
  end

  def remove(num)
    if @store[num%num_buckets].include?(num)
      @store[num%num_buckets].delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    @store[num%num_buckets].each {|el| return true if el==num}
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |el|
       new_store[el % (num_buckets*2)] << el
     end
   end
   @store = new_store
  end
end

require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    resize! if @count == num_buckets
    self[el] << el
    @count += 1
  end

  def remove(el)
    @count -= 1
    self[el].delete(el)
  end

  def include?(el)
    self[el].include?(el)
  end

  private

  def [](el)
    # optional but useful; return the bucket corresponding to `el`
    # this is our arnold method
    @store[el.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % new_store.length] << el
      end
    end
    @store = new_store
  end
end

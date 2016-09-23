require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)

    @store[bucket].include?(key)
  end

  def set(key, val)
    bucket = bucket(key)

    if @store[bucket].include?(key)
      list = @store[bucket]

      list.each do |link|
        link.val = val if link.key == key
      end
    else
      resize! if @count == num_buckets

      @store[bucket].insert(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket = bucket(key)

    @store[bucket].get(key)
  end

  def delete(key)
    bucket = bucket(key)

    @store[bucket].remove(key)
    @count -= 1
  end

  def each(&prc)
    @store.each do |list|
      list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |list|
      list.each do |link|
        new_store[link.key.hash % (num_buckets * 2)].insert(link.key, link.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    key.hash % num_buckets
  end
end

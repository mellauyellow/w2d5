class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= capacity || i.abs > @count
    i >= 0 ? @store[i] : @store[@count + i]
  end

  def []=(i, val)
    return nil if i >= capacity || i.abs > @count
    i >= 0 ? @store[i] = val : @store[@count + i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    0.upto(@store.length - 1) do |idx|
      return true if self[idx] == val
    end

    false
  end

  def push(val)
    resize! if @count == capacity
    @store[count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    (@count - 1).downto(0) do |idx|
      @store[idx + 1] = @store[idx]
    end
    @store[0] = val
    @count += 1
  end

  def pop
    return nil if @count == 0
    temp = self[@count - 1]
    self[@count - 1] = nil
    @count -= 1
    temp
  end

  def shift
    return nil if @count == 0
    temp = @store[0]
    1.upto(@count - 1) do |idx|
      self[idx - 1] = self[idx]
    end
    self[@count - 1] = nil
    @count -= 1
    temp
  end

  def first
    self[0]
  end

  def last
    self[@count - 1]
  end

  def each(&prc)
    0.upto(@count - 1) do |idx|
      prc.call(self[idx])
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @count == other.length
    0.upto(@count - 1) do |idx|
      return false unless self[idx] == other[idx]
    end

    true
  end

  def length
    @store.length
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private


  def resize!
    new_store = StaticArray.new(capacity * 2)

    0.upto(@store.length - 1) do |idx|
      new_store[idx] = @store[idx]
    end

    @store = new_store
  end

end

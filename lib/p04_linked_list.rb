class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :sentinel_cabesa, :sentinel_cola

  def initialize
    @sentinel_cabesa = Link.new
    @sentinel_cola = Link.new
    @sentinel_cabesa.prev = @sentinel_cola
    @sentinel_cabesa.next = @sentinel_cola
    @sentinel_cola.prev = @sentinel_cabesa
    @sentinel_cola.next = @sentinel_cabesa
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel_cabesa.next
  end

  def last
    @sentinel_cola.prev
  end

  def empty?
    @sentinel_cabesa.next == @sentinel_cola
  end

  def get(key)
    each do |enlazar|
      return enlazar.val if enlazar.key == key
    end
    nil
  end

  def include?(key)
    each do |enlazar|
      return true if enlazar.key == key
    end
    false
  end

  def insert(key, val)
    new_enlazar = Link.new(key, val)
    new_enlazar.next = @sentinel_cola
    new_enlazar.prev = @sentinel_cola.prev
    new_enlazar.prev.next = new_enlazar
    @sentinel_cola.prev = new_enlazar
    new_enlazar
  end

  def remove(key)
    each do |enlazar|
      if enlazar.key == key
        prev_link = enlazar.prev
        next_link = enlazar.next
        prev_link.next = next_link
        next_link.prev = prev_link
      end
    end
  end

  def each(current_enlazar = @sentinel_cabesa.next, &prc)
    return if current_enlazar == @sentinel_cola
    prc.call(current_enlazar)
    each(current_enlazar.next, &prc)
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

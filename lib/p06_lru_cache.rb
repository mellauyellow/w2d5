require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link_called = @map[key]
      val = link_called.val
      update_link!(link_called)
    else
      val = calc!(key)
      eject! if count == @max
      @map[key] = @store.insert(key, val)
    end
    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    #rewire to last position
    second_to_last = @store.sentinel_cola.prev
    second_to_last.next = link
    link.prev = second_to_last
    link.next = @store.sentinel_cola
    @store.sentinel_cola.prev = link

    #dewire from original position
    previous_enlazar = link.prev
    next_enlazar = link.next
    previous_enlazar.next = next_enlazar
    next_enlazar.prev = previous_enlazar
  end

  def eject!
    node_to_kill = @store.sentinel_cabesa.next
    @store.remove(node_to_kill)
    @map.delete(node_to_kill.key)
  end
end

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    final_bitwise = 0
    self.each_with_index do |el, idx|
      bitwise = el.hash * (idx + 1)
      final_bitwise = final_bitwise ^ bitwise
    end

    final_bitwise.hash
  end
end

class String
  def hash
    final_bitwise = 0
    self.each_char.with_index do |char, idx|
      bitwise = char.ord * (idx + 1)
      final_bitwise = final_bitwise ^ bitwise
    end

    final_bitwise.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end

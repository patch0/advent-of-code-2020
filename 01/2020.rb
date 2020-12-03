class TwentyTwenty

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def run
    ans = if bottom_half.size < top_half.size
      find_pairs bottom_half, top_half
    else
      find_pairs top_half, bottom_half
    end
    pp ans.map{|i| i * (2020 - i)}
  end

  def ints
    @ints ||= input.map(&:to_i)
  end

  def sorted_ints
    @sorted_ints ||= ints.sort
  end

  def top_half
    ints.select{|i| i > 1010 }
  end

  def bottom_half
    ints - top_half
  end

  def find_pairs(needles, haystack)
    needles.select do |i|
      haystack.include?(2020 - i)
    end
  end
end



if __FILE__ == $0
  TwentyTwenty.new($stdin.readlines).run
end

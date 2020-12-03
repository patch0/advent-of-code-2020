class TwentyTwenty

  attr_reader :input, :offset

  def initialize(input, offset: 0)
    @input = input
    @offset = offset
  end

  def run
    find_pairs bottom_half, input
  end

  def ints
    @ints ||= input.map(&:to_i).reject{|i| i > 2020}
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
    needles.find do |i|
      haystack.include?(2020 - offset - i)
    end
  end
end


class TwentyTwentyB < TwentyTwenty
  def run
    ints.map do |initial|
      new_input = (ints - [initial])
      ans = TwentyTwenty.new(new_input, offset: initial).run
      return ans * initial * (2020 - initial - ans) if ans
    end.compact
  end
end


if __FILE__ == $0
  pp TwentyTwentyB.new($stdin.readlines).run
end

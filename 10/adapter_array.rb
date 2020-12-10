# frozen_string_literal: true

class AdapterArray
  def initialize(input)
    @input = input.map(&:to_i)
  end

  def run
    joltage = 0
    diffs = Hash.new { |h, k| h[k] = 0 }
    @input.sort.each do |adapter|
      diffs[adapter - joltage] += 1
      joltage = adapter
    end
    diffs[3] += 1

    diffs[3] * diffs[1]
  end
end

pp AdapterArray.new($stdin.readlines).run if $PROGRAM_NAME == __FILE__

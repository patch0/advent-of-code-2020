# frozen_string_literal: true

class AdapterCombos
  def initialize(input)
    @adapters = input.map(&:to_i).sort
  end

  def run
    @adapters.unshift(0)
    # pp count_paths(0)

    @adapters.push(@adapters.max + 3)
    count_sequences
  end

  def compatible_adapters
    @compatible_adapters ||= @adapters.map do |adapter|
      [adapter, @adapters.select { |a| (1..3).include?(a - adapter) }]
    end.to_h
  end

  def count_sequences
    diffs = @adapters[1..].map.with_index { |n, i| n - @adapters[i] }

    counts = [0, 0, 0, 0, 0]
    while ind = diffs.find_index(3)
      counts[ind] ||= 0
      counts[ind] += 1
      diffs.shift(ind + 1)
    end

    7**counts[4] * 2**counts[1..3].sum
  end

  # Brute force!
  def count_paths(adapter)
    return 1 if compatible_adapters[adapter].empty?

    compatible_adapters[adapter].sum do |a|
      count_paths(a)
    end
  end
end

pp AdapterCombos.new($stdin.readlines).run if $PROGRAM_NAME == __FILE__

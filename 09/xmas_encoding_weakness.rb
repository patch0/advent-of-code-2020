class XmasEncordingWeakness
  def initialize(input, target)
    @input = input.map(&:chomp).map(&:to_i)
    @target = target.to_i
  end

  def run
    sequence = []
    until @input.empty?
      sum = sequence.sum
      return sequence.min + sequence.max if sum == @target

      if sum < @target
        sequence << @input.shift
      else
        sequence.shift
      end
    end
  end
end

target = ARGV.first

pp XmasEncordingWeakness.new($stdin.readlines, target).run if $0 == __FILE__

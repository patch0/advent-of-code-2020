class XmasEncording

  def initialize(input, preamble_length)
    @input = input.map(&:chomp).map(&:to_i)
    @preamble_length = preamble_length.to_i
  end

  def run
    preamble = @input.shift(@preamble_length)

    while value = @input.shift
      if preamble.permutation(2).map(&:sum).uniq.include?(value)
        preamble.shift
        preamble.push value
        next
      end

      return value
    end
  end
end

preamble_length = ARGV.first

pp XmasEncording.new($stdin.readlines, preamble_length).run if $0 == __FILE__


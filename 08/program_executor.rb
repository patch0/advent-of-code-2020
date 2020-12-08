class ProgramExecutor
  def initialize(input)
    @input = input.map(&:chomp)
  end

  def run
    pos = 0
    acc = 0
    seen = []
    until seen.include?(pos)
      op, arg = @input[pos].split
      arg = arg.to_i
      seen << pos

      case op
      when 'nop'
        pos += 1
      when 'acc'
        pos += 1
        acc += arg
      when 'jmp'
        pos += arg
      end
    end

    acc
  end
end

pp ProgramExecutor.new($stdin.readlines).run if $0 == __FILE__

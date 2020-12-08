class ProgramFixer
  def initialize(input)
    @input = input.map(&:chomp)
  end

  def run
    swap_pos = -1
    while swap_pos < @input.length
      swap_pos += 1
      line = @input[swap_pos]
      next if line.start_with?('acc ')

      new_line = if line.start_with?('jmp')
                   line.sub('jmp', 'nop')
                 else
                   line.sub!('jmp', 'nop')
                 end

      @input[swap_pos] = new_line
      acc = run_once(@input)

      return acc unless acc.nil?

      @input[swap_pos] = line
    end
  end

  def run_once(input)
    pos = 0
    acc = 0
    seen = []
    until seen.include?(pos)

      break if input[pos].nil?

      op, arg = input[pos].split
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

    return nil if pos < input.length

    acc
  end
end

pp ProgramFixer.new($stdin.readlines).run if $0 == __FILE__

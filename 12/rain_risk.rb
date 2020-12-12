class RainRisk
  def initialize(input)
    @input = input.map(&:chomp)
  end

  def run
    pos = [0, 0]
    bearing = 90
    @input.each do |line|
      action = line[0]
      value = line[1..].to_i
      pos, bearing = operate(pos, bearing, action, value)
    end
    pos.map(&:abs).sum
  end

  def operate(pos, bearing, action, value)
    if action == 'F'
      action = case bearing % 360
               when 0
                 'N'
               when 270
                 'W'
               when 180
                 'S'
               else
                 'E'
               end
    end

    case action
    when 'N'
      [[pos[0], pos[1] + value], bearing]
    when 'E'
      [[pos[0] + value, pos[1]], bearing]
    when 'S'
      [[pos[0], pos[1] - value], bearing]
    when 'W'
      [[pos[0] - value, pos[1]], bearing]
    when 'L'
      [pos, bearing - value]
    when 'R'
      [pos, bearing + value]
    end
  end
end

pp RainRisk.new($stdin.readlines).run if __FILE__ == $0

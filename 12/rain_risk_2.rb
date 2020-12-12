class RainRisk2
  def initialize(input)
    @input = input.map(&:chomp)
  end

  def run
    pos = [0, 0]
    waypoint = [10, 1]

    @input.each do |line|
      action = line[0]
      value = line[1..].to_i
      case action
      when 'F'
        pos = [pos[0] + value * waypoint[0], pos[1] + value * waypoint[1]]
      when 'L', 'R'
        waypoint = rotate(waypoint, action, value)
      else
        waypoint = move(waypoint, action, value)
      end
    end
    pos.map(&:abs).sum
  end

  def move(pos, action, value)
    case action
    when 'N'
      [pos[0], pos[1] + value]
    when 'E'
      [pos[0] + value, pos[1]]
    when 'S'
      [pos[0], pos[1] - value]
    when 'W'
      [pos[0] - value, pos[1]]
    end
  end

  def rotate(pos, action, degrees)
    x = (action == 'L' ? -1 : 1)

    while degrees > 0
      degrees -= 90
      pos = [x * pos[1], -x * pos[0]]
    end

    pos
  end
end

pp RainRisk2.new($stdin.readlines).run if __FILE__ == $0

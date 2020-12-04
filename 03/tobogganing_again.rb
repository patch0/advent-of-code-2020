# frozen_string_literal: true

class TobogganTrajectory
  attr_reader :right, :down, :text_map, :map, :x, :y, :trees

  def initialize(right, down, text_map)
    @right = right
    @down = down
    @text_map = text_map
    @x = 0
    @y = 0
    @map = map_section
    @trees = 0
  end

  def run
    until finished?
      add_map_section if x >= map.first.size
      @trees += 1 if map[y][x] == '#'
      @x += right
      @y += down
    end

    trees
  end

  def finished?
    y >= text_map.size
  end

  def add_map_section
    @map = map.map { |m| m * 2 }
  end

  def map_section
    @map_section ||= text_map.map { |l| l.strip.chars }
  end
end

SLOPES = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
].freeze

if __FILE__ == $PROGRAM_NAME
  input = $stdin.readlines
  ans = SLOPES.map do |right, down|
    TobogganTrajectory.new(right, down, input).run
  end
  pp ans.inject(1) { |s, m| s * m }
end

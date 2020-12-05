module BinaryPartition
  refine Range do
    def top_half
      (min + size / 2)..max
    end

    def bottom_half
       min...(min + size / 2)
    end
  end
end


class BoardingPass

  using BinaryPartition
  include Comparable

  MAX_ROW=128
  MAX_COL=8

  attr_reader :instructions

  def initialize(input)
    @instructions = input.chars
    @row_range = 0...MAX_ROW
    @seat_range = 0...MAX_COL
    parse
  end

  def parse
    while instruction = instructions.shift
      case instruction
      when 'F'
        @row_range = @row_range.bottom_half
      when 'B'
        @row_range = @row_range.top_half
      when 'L'
        @seat_range = @seat_range.bottom_half
      when 'R'
        @seat_range = @seat_range.top_half
      end
    end
  end

  def row
    raise RangeError, 'Row range not resolved' unless @row_range.size == 1
    @row_range.first
  end

  def seat
    raise RangeError, 'Col range not resolved' unless @seat_range.size == 1
    @seat_range.first
  end

  def seat_id
    row * 8 + seat
  end

  def to_s
    "Row #{row}, Seat #{seat}, ID #{seat_id}"
  end

  def <=>(other)
    seat_id <=> other.seat_id
  end
end

if $0 == __FILE__
  bps = $stdin.readlines.map do |pass|
    BoardingPass.new(pass.chomp)
  end

  pp max = bps.max
  pp min = bps.min

  range = (min.seat_id..max.seat_id)

  pp range.to_a - bps.map{|b| b.seat_id}
end


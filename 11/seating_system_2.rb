# frozen_string_literal: true

class SeatingSystem2
  UNOCCUPIED = 'L'
  OCCUPIED = '#'
  FLOOR = '.'

  def initialize(input)
    @input = input.map(&:chomp).map(&:chars)
    @neighbours = find_neighbours(@input)
    @n_rows = @input.size
    @n_cols = @input.first.size
  end

  def find_neighbours(seat_map)
    seat_map.map.with_index do |row, x|
      (0...row.size).map do |y|
        (-1..1).map do |x_dir|
          (-1..1).map do |y_dir|
            next_seat(seat_map, x, y, x_dir, y_dir)
          end.compact
        end.flatten(1)
      end
    end
  end

  def next_seat(seat_map, x, y, x_dir, y_dir)
    return if x_dir.zero? && y_dir.zero?

    i = x
    j = y
    loop do
      i += x_dir
      j += y_dir
      return if i.negative? || j.negative?
      return if seat_map.dig(i, j).nil?

      break unless seat_map.dig(i, j) == FLOOR
    end

    [i, j]
  end

  def run
    state = @input

    loop do
      show_map(state)
      next_state = seat_everyone(state)

      break if next_state == state

      state = next_state
    end
    show_map(state)

    (0...@n_rows).sum do |x|
      (0...@n_cols).sum do |y|
        next 1 if state.dig(x, y) == OCCUPIED

        0
      end
    end
  end

  def show_map(state)
    puts "#{state.map(&:join).join("\n")}\n#{'-' * 80}"
  end

  def seat_everyone(state)
    state.map.with_index do |row, x|
      row.map.with_index do |seat, y|
        next seat if seat == FLOOR

        adjacent = count_filled_adjacent_seats(state, x, y)

        next OCCUPIED if seat == UNOCCUPIED && adjacent.zero?

        next UNOCCUPIED if seat == OCCUPIED && adjacent >= 5

        seat
      end
    end
  end

  def count_filled_adjacent_seats(state, x, y)
    @neighbours.dig(x, y).count { |i, j| state.dig(i, j) == OCCUPIED }
  end
end

pp SeatingSystem2.new($stdin.readlines).run if $PROGRAM_NAME == __FILE__

class SeatingSystem
  UNOCCUPIED = 'L'.freeze
  OCCUPIED = '#'.freeze
  FLOOR = '.'.freeze

  def initialize(input)
    @input = input.map(&:chomp).map(&:chars)
    @n_rows = @input.size
    @n_cols = @input.first.size
  end

  def run
    state = @input

    loop do
      next_state = seat_everyone(state)

      break if next_state == state

      state = next_state
    end
    show_map(state)

    (0...@n_rows).sum do |x|
      (0...@n_cols).sum do |y|
        next 1 if state[x][y] == OCCUPIED
        0
      end
    end
  end

  def show_map(state)
    puts state.map(&:join).join("\n") + "\n" + '-' * 80
  end

  def seat_everyone(state)
    state.map.with_index do |row, x|
      row.map.with_index do |seat, y|
        next seat if seat == FLOOR

        adjacent = count_filled_adjacent_seats(state, x, y)
        next OCCUPIED if seat == UNOCCUPIED && adjacent == 0

        next UNOCCUPIED if seat == OCCUPIED && adjacent >= 4

        seat
      end
    end
  end

  def count_filled_adjacent_seats(state, x, y)
    ((x - 1)..(x + 1)).sum do |i|
      next 0 if i < 0 || i >= @n_rows

      ((y - 1)..(y + 1)).sum do |j|
        next 0 if j < 0 || j >= @n_cols
        next 0 if x == i && y == j
        next 1 if state[i][j] == OCCUPIED

        0
      end
    end
  end
end

pp SeatingSystem.new($stdin.readlines).run if $0 == __FILE__

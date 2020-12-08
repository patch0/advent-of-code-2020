# frozen_string_literal: true

class LuggageRules2
  def initialize(input)
    @input = input
    @rules = []
  end

  def parse_rules
    @input.each do |line|
      words = line.split
      colour = "#{words.shift} #{words.shift}"

      words.shift(2)
      contains = []

      until words.empty?
        n = words.shift
        break if n == 'other'

        c = "#{words.shift} #{words.shift}"
        contains += [c] * n.to_i
        words.shift
      end
      @rules << [colour, contains]
    end
    @rules
  end

  def count_ways_for(colour)
    pp match_ways_for(colour)
  end

  def match_ways_for(colour)
    contains = @rules.select { |r| r.first == colour }.map(&:last).flatten
    contains.map { |c| [c, match_ways_for(c)] }.flatten
  end
end

if $PROGRAM_NAME == __FILE__
  l = LuggageRules2.new($stdin.readlines)
  l.parse_rules
  pp l.count_ways_for('shiny gold').flatten.count
end

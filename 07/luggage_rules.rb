# frozen_string_literal: true

class LuggageRules
  def initialize(input)
    @input = input
    @rules = []
  end

  RULE_REGEX = /^(\w+ \w+) bags contain (?:(?:\d+ (\w+ \w+) bags?, )*\d+ (\w+ \w+)|no other) bags?.$/.freeze

  def parse_rules
    @input.each do |line|
      words = line.split
      colour = "#{words.shift} #{words.shift}"

      words.shift(2)

      until words.empty?
        words.shift
        c = "#{words.shift} #{words.shift}"
        next if c == 'other bags.'

        @rules << [c, colour]
        words.shift
      end
    end
    pp @rules
  end

  def count_ways_for(colour)
    pp match_ways_for(colour)
  end

  def match_ways_for(colour)
    matches = @rules.select { |r| r.first == colour }.map(&:last)
    matches.map { |match| [match, match_ways_for(match)] }
  end
end

if $PROGRAM_NAME == __FILE__
  l = LuggageRules.new($stdin.readlines)
  l.parse_rules
  pp l.count_ways_for('shiny gold').flatten.uniq.count

end

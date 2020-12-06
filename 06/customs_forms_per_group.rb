
class CustomsDeclarationsGroups

  attr_reader :input

  def initialize(input)
    @input = input
    @count = 0
  end

  def run
    records = []
    input.each do |line|
      line = line.chomp

      if line.empty?
        @count += process_group(records)
        records = []
        next
      end

      records << line.chars.sort.uniq
    end
    @count += process_group(records)

    @count
  end

  def process_group(records)
    counts = records.flatten.tally

    return counts.values.select{|c| c == records.length}.count
  end

end

if $0 == __FILE__
  pp  CustomsDeclarationsGroups.new($stdin.readlines).run
end

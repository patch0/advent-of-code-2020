
class CustomsDeclarations

  attr_reader :input

  def initialize(input)
    @input = input
    @records = []
  end

  def run
    record = []
    input.each do |line|
      line = line.chomp

      if line.empty?
        @records << record
        record = []
        next
      end

      record += line.chars
    end
    @records << record
    @records = @records.map(&:uniq)
    @records.flatten.length
  end

end

if $0 == __FILE__
  pp  CustomsDeclarations.new($stdin.readlines).run
end

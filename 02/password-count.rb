class PasswordCount
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def run
    input.count do |l|
      policy_string, password = l.split(': ', 2)
      policy = Policy.new(policy_string)
      policy.valid_password?(password)
    end
  end
end


class Policy
  attr_reader :policy_string

  def initialize(policy_string)
    @policy_string = policy_string
  end

  def limits
    l = policy_string.split(' ').first
    Range.new(*l.split("-").map(&:to_i))
  end

  def char
    @char ||= policy_string.split(" ").last
  end

  def valid_password?(password)
    char_count = password.chars.count{|c| c == char}
    limits.cover?(char_count)
  end
end


if __FILE__ == $0
  pp PasswordCount.new($stdin.readlines).run
end

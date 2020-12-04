# frozen_string_literal: true

class PassportControl
  attr_reader :input

  FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid].freeze

  def initialize(input)
    @input = input
  end

  def run
    records.count { |r| valid?(r) }
  end

  def records
    records = []
    record = nil

    x = input.map { |l| r = l.strip.split(' '); r = nil if r.empty?; r }
    x.flatten.each do |f|
      record ||= []

      if f.nil?
        records << record
        record = nil
        next
      end

      record << f.split(':').first
    end

    records
  end

  def valid?(record)
    missing = FIELDS - record
    missing.empty? || missing == ['cid']
  end
end

pp PassportControl.new($stdin.readlines).run if __FILE__ == $PROGRAM_NAME

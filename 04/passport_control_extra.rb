# frozen_string_literal: true

class PassportControlExtra
  attr_reader :input

  FIELDS = %w[byr iyr eyr hgt hcl ecl pid cid].freeze
  EYE_COLOURS = %w[amb blu brn gry grn hzl oth].freeze

  VALIDATION_RULES = {
    byr: ->(v) { (1920..2002).cover?(v.to_i) },
    iyr: ->(v) { (2010..2020).cover?(v.to_i) },
    eyr: ->(v) { (2020..2030).cover?(v.to_i) },
    hgt: ->(v) { validate_height(v) },
    hcl: ->(v) { v =~ /^#[0-9a-f]{6,6}$/ },
    ecl: ->(v) { EYE_COLOURS.include?(v) },
    pid: ->(v) { v =~ /^\d{9}$/ },
    cid: ->(_v) { true }
  }.freeze

  def initialize(input)
    @input = input
  end

  def run
    records.count { |r| valid?(r) }
  end

  def records
    records = []
    record = nil

    x = input.map { |l| r = l.strip.split(' '); r = nil if r.empty?; r}
    x.flatten.each do |f|
      record ||= {}

      if f.nil?
        records << record
        record = nil
        next
      end

      key, value = f.split(':', 2)
      record[key] = value
    end

    records
  end

  def valid?(record)
    keys_valid?(record) &&
      values_valid?(record)
  end

  def keys_valid?(record)
    missing = FIELDS - record.keys
    missing.empty? || missing == ['cid']
  end

  def values_valid?(record)
    record.all? do |k, v|
      VALIDATION_RULES[k.to_sym].call(v)
    end
  end

  class << self
    def validate_height(height)
      match = /^(?<val>\d+)(?<units>cm|in)$/.match(height)
      return false if match.nil?

      if match[:units] == 'cm'
        (150..193).cover? match[:val].to_i
      else
        (59..76).cover? match[:val].to_i
      end
    end
  end
end

pp PassportControlExtra.new($stdin.readlines).run if __FILE__ == $PROGRAM_NAME

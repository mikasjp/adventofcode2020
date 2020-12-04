INPUT = File.read("input.txt").split("\n\n").map(&:strip).map(&:split).map {|x| x.map{|y| y.split(":")}}

obligatory_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].sort
VALIDATORS = {
    "byr" => Proc.new do |val|
        val.to_i.between?(1920, 2002)
    end,
    "iyr" => Proc.new do |val|
        val.to_i.between?(2010,2020)
    end,
    "eyr" => Proc.new do |val|
        val.to_i.between?(2020, 2030)
    end,
    "hgt" => Proc.new do |val|
        unit = val.split(//).last(2).join("")
        value = val.delete_suffix(unit).to_i
        res = false
        if unit == "cm"
            res = value.between?(150,193)
        elsif unit == "in"
            res = value.between?(59,76)
        else
            res = false
        end
        res
    end,
    "hcl" => Proc.new do |val|
        val.match?(/#[a-f0-9]{6}/)
    end,
    "ecl" => Proc.new do |val|
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(val)
    end,
    "pid" => Proc.new do |val|
        val.match?(/[0-9]{9}/)
    end,
    "cid" => Proc.new do |val|
        true
    end
}

valid_passports = INPUT
.select{|x|
    x
        .select{|y| !["cid"].include?(y.first)}
        .map{|y| y.first}
        .sort == obligatory_fields
}

# First part
puts valid_passports.count

# Second part
puts valid_passports
    .count{|x|
        x.map {|y|
            validator = VALIDATORS.fetch(y.first, Proc.new do |val| false end)
            validator.call(y.last)
        }.all?
    }

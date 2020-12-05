INPUT = File.read("input.txt").split("\n\n").map(&:strip).map(&:split).map {|x| x.map{|y| y.split(":")}}

obligatory_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].sort
VALIDATORS = {
    "byr" => lambda {|val|
        val.to_i.between?(1920, 2002)
    },
    "iyr" => lambda {|val|
        val.to_i.between?(2010,2020)
    },
    "eyr" => lambda {|val|
        val.to_i.between?(2020, 2030)
    },
    "hgt" => lambda {|val|
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
    },
    "hcl" => lambda {|val|
        val.match?(/^#[a-f0-9]{6}$/)
    },
    "ecl" => lambda {|val|
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(val)
    },
    "pid" => lambda {|val|
        val.match?(/^\d{9}$/)
    },
    "cid" => lambda {|val| true }
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
            validator = VALIDATORS.fetch(y.first, lambda {|val| false })
            validator.call(y.last)
        }.all?
    }

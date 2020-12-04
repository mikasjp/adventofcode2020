INPUT = File.read("input.txt").split("\n\n").map(&:strip)

obligatory_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].sort

# First part
puts INPUT
    .map(&:split)
    .count{|x|
        x
        .map{|y| y.split(":").first}
        .select{|y| !["cid"].include?(y)}
        .sort == obligatory_fields
    }

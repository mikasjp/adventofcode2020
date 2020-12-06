INPUT = File.read("input.txt").strip.split("\n\n").map{|x| x.strip.split("\n").map{|y| y.chars}}

# First part
puts INPUT
    .map{|x| x.flatten.uniq.count}
    .sum

# Second part
puts INPUT
    .map{|x| x.inject(("a".."z").to_a,:&).count}
    .sum

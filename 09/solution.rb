INPUT = File.readlines("input.txt").map(&:strip).map(&:to_i)

# First part
first_part = INPUT
    .each_with_index
    .drop(25)
    .select{|x,i|
            !INPUT[(i-2 5..i-1)]
                .combination(2)
                .map{|y| y.sum}
                .include?(x)
    }
    .first
    .first
puts first_part

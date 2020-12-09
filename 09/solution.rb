INPUT = File.readlines("input.txt").map(&:strip).map(&:to_i)

invalid, count = INPUT
.each_with_index
.drop(25)
.select{|x,i|
    !INPUT[(i-25..i-1)]
        .combination(2)
        .map{|y| y.sum}
        .include?(x)
}
.first

# First part
puts invalid

# Second part
puts (2..count)
    .map{|x| [x, (0..count-x)]}
    .map{|f,r|
        r.map{|i|
            res = INPUT.drop(i).take(f)
            [res.sum==invalid, res.min + res.max]
        }
        .select{|success,result| success}
    }
    .flatten
    .last

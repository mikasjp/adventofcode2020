input = File.readlines("input.txt").map(&:to_i)

# First part
puts input
    .map {|x|
        component = input.detect{ |i| x+i==2020 }
        component == nil ? nil : x*component
    }
    .detect{|x| !x.nil?}

# Second part
puts input
    .combination(3)
    .map {|x| x.sum()==2020 ? x.inject(1, :*): nil}
    .detect{|x| !x.nil?}
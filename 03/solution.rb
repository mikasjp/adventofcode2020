INPUT = File.readlines("input.txt").map(&:strip)

def slope_check(right, down)
    INPUT
        .each_with_index
        .select{|x,i| i % down == 0}
        .count {|x,i|
            index = i / down * right % x.length
            x[index] == "#"
        }
end

# First part
puts slope_check(3, 1)

# Second part
puts [[1,1], [3,1], [5,1], [7,1], [1,2]]
    .map{|x| slope_check *x}
    .inject(1, :*)
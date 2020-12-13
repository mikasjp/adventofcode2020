INPUT  = File.readlines("input.txt").map(&:strip).each_with_index.map{|x,i| i==0 ? x.to_i : x.split(",").map{|y| y=="x" ? "x" : y.to_i}}

puts INPUT
    .last
    .select{|x| x!="x"}
    .map{|x| [x, (INPUT.first / x + 1)*x-INPUT.first ]}
    .sort_by{|x,y| y}
    .map{|x,y| x*y}
    .first
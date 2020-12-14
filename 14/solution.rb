MASK, INPUT = [File.open("input.txt", &:readline).strip.split(" = ").last.chars.each_with_index.select{|x,i|x!="X"}.map{|x,i|[i,x]}.group_by{|i,x|x}.map{|k,v|[k,v.map{|y|y.first}]}.to_h, File.read("input.txt").scan(/^mem\[(\d+)\] = (\d+)$/).map{|x|x.map{|y|y.to_i}}]

# First part
or_mask = (0..35).map{|x|MASK["1"].include?(x) ? "1" : "0"}.join.to_i(2)
and_mask = (0..35).map{|x|MASK["0"].include?(x) ? "0" : "1"}.join.to_i(2)
puts INPUT
    .group_by{|x,y| x}
    .map{|k,v| v.last}
    .map{|x,y| (y | or_mask) & and_mask}
    .sum
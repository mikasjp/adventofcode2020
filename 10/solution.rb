INPUT = File.readlines("input.txt").map{|x| x.strip.to_i}.sort.reverse!

# First part
used_adapters = [0]
loop do
    current_adapter = used_adapters.last
    next_adapter = (INPUT-used_adapters)
        .select{|x| x.between? current_adapter+1, current_adapter+3}
        .min
    break if next_adapter.nil?
    used_adapters.append(next_adapter)
end

differences = used_adapters
    .append(used_adapters.max+3)
    .each_cons(2)
    .map{|x,y| y-x}
    .group_by{|x| x}
    .map{|k,v| [k, v.count]}
    .to_h

# First part
puts differences.fetch(1,0)*differences.fetch(3,0)

# Second part
a = { INPUT.first+3 => 1 }
INPUT
    .append(0)
    .each{|x| a[x] = (1..3).map{|y| a.fetch(x+y,0)}.sum }
puts a[0]

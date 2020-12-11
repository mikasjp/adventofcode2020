INPUT = File.readlines("input.txt")
    .each_with_index
    .map{|s,y| [s.strip.chars.each_with_index.select{|n,x| n!="."}.map{|n,x| [[x,y],n]}]}
    .flatten(2)
    .to_h

# First part
state = INPUT
loop do
    new_state = state.map{|k,v|
        x,y = k
        neighbors = (x-1..x+1)
        .map{|n| (y-1..y+1).map{|m| [n,m]}}
        .flatten(1).select{|n| n!=[x,y]}
        .count{|n,m| state.fetch([n,m],nil)=="#" }
        res = [k,v]
        if v=="L" && neighbors==0
            res = [k, "#"]
        end
        if v=="#" && neighbors>=4
            res = [k, "L"]
        end
        res
    }.to_h
    break if state.inspect.hash == new_state.inspect.hash
    state = new_state
end
puts state.count{|k,v| v=="#"}
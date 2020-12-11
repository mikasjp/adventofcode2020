INPUT = File.readlines("input.txt")
    .each_with_index
    .map{|s,y| [s.strip.chars.each_with_index.select{|n,x| n!="."}.map{|n,x| [[x,y],n]}]}
    .flatten(2)
    .to_h

def solve count_neighbors
    state = INPUT
    loop do
        new_state = state.map{|k,v|
            x,y = k
            neighbors = count_neighbors.call(x,y,state)
            res = [k,v]
            if v=="L" && neighbors==0
                res = [k, "#"]
            end
            if v=="#" && neighbors>=4
                res = [k, "L"]
            end
            res
        }.to_h
        break if state.hash == new_state.hash
        state = new_state
    end
    state.count{|k,v| v=="#"}
end
    
# First part
count_neighbors = lambda {|x,y,s|
    (x-1..x+1)
            .map{|n| (y-1..y+1).map{|m| [n,m]}}
            .flatten(1).select{|n| n!=[x,y]}
            .count{|n,m| s.fetch([n,m],nil)=="#" }
}
puts solve count_neighbors
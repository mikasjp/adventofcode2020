INPUT = File.readlines("input.txt")
    .each_with_index
    .map{|s,y| [s.strip.chars.each_with_index.select{|n,x| n!="."}.map{|n,x| [[x,y],n]}]}
    .flatten(2)
    .to_h

def solve count_neighbors, tolerance
    state = INPUT
    loop do
        new_state = state.map{|k,v|
            x,y = k
            neighbors = count_neighbors.call(x,y,state)
            res = [k,v]
            if v=="L" && neighbors==0
                res = [k, "#"]
            end
            if v=="#" && neighbors>=tolerance
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
puts solve count_neighbors, 4

# Second part
neighbors_map = INPUT
    .map{|k,v|
        x,y = k
        [k,
        (1..INPUT.count)
        .map{|d|
            [
                [d, "N", INPUT.fetch([x,y-d], nil), [x,y-d]],
                [d, "S", INPUT.fetch([x,y+d], nil), [x,y+d]],
                [d, "E", INPUT.fetch([x+d,y], nil), [x+d,y]],
                [d, "W", INPUT.fetch([x-d,y], nil), [x-d,y]],
                [d, "NE", INPUT.fetch([x+d,y-d], nil), [x+d,y-d]],
                [d, "SE", INPUT.fetch([x+d,y+d], nil), [x+d,y+d]],
                [d, "SW", INPUT.fetch([x-d,y+d], nil), [x-d,y+d]],
                [d, "NW", INPUT.fetch([x-d,y-d], nil), [x-d,y-d]]
            ].select{|q,w,e,c| !e.nil?}
        }
        .flatten(1)
        .group_by{|dist,dir,stat,coords| dir}
        .map{|k,v| v.first.last}
    ]
}.to_h

count_neighbors = lambda {|x,y,s|
    neighbors_map.fetch([x,y]).count{|q| s[q]=="#"}
}

puts solve count_neighbors, 5

INPUT = File.readlines("input.txt").map(&:strip)

# First part
mem = {}
or_mask = 0
and_mask = 1
INPUT
    .each{|x|
        if x.start_with? "mask"
            mask = x.split(" = ").last
            or_mask = mask.gsub("X","0").to_i(2)
            and_mask = mask.gsub("X","1").to_i(2)
        else
            addr, val = x.scan(/^mem\[(\d+)\] = (\d+)$/).flatten.map(&:to_i)
            mem[addr] = (val | or_mask) & and_mask
        end
    }
puts mem.sum{|k,v| v}

# Second part
mem = {}
masks = []
INPUT
    .each{|x|
        if x.start_with? "mask"
            mask = x.split(" = ").last.chars
            floating = mask.each_with_index.select{|x,i|x=="X"}.map{|x,i|i}.each_with_index.map{|x,i|[x,i]}.to_h
            floating_bits = (0..2**floating.count-1).map{|x|x.to_s(2).rjust(floating.count,"0").chars}
            masks = floating_bits
                .map{|bits|
                    new_mask = mask.each_with_index.map{|x,i| floating.fetch(i,nil) == nil ? x : bits[floating[i]] }.join.to_i(2)
                }
        else
            a, val = x.scan(/^mem\[(\d+)\] = (\d+)$/).flatten.map(&:to_i)
            masks.each{|x|
                mem[a | x]=val
            }
        end
    }
puts mem.sum{|k,v| v}

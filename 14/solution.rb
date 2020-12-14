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
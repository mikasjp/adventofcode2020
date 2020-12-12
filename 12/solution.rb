INPUT = File.readlines("input.txt").map{|x| x.strip.scan(/^([NSEWLRF])(\d+)$/).flatten(1)}.map{|x,y| [x,y.to_i]}

# First part
move = {
    "N" => lambda{|s,v| {"dir"=>s["dir"], "x"=>s["x"],"y"=>s["y"]+v}},
    "S" => lambda{|s,v| {"dir"=>s["dir"], "x"=>s["x"],"y"=>s["y"]-v}},
    "W" => lambda{|s,v| {"dir"=>s["dir"], "x"=>s["x"]-v,"y"=>s["y"]}},
    "E" => lambda{|s,v| {"dir"=>s["dir"], "x"=>s["x"]+v,"y"=>s["y"]}},
    "F" => lambda{|s,v| move[s["dir"]].call(s,v) }
}

puts INPUT
    .inject({"dir" => "E","x" => 0,"y" => 0}) {|s, c|
        if ["N","E","S","W","F"].include? c.first
            move[c.first].call(s,c.last)
        else
            dir_map = ["N","E","S","W"]
            {"dir" => dir_map[(dir_map.index(s["dir"]) + c.last/90*(c.first=="L"?-1:1)) % 4], "x"=>s["x"], "y"=>s["y"]}
        end
    }
    .select{|k,v| ["x","y"].include? k}
    .map{|k,v| v.abs}
    .sum
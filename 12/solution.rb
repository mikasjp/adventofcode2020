INPUT = File.readlines("input.txt").map{|x| x.strip.scan(/^([NSEWLRF])(\d+)$/).flatten(1)}.map{|x,y| [x,y.to_i]}

# First part
move = {
    "N" => lambda{|s,v,w| {"dir"=>s["dir"], "x"=>s["x"],"y"=>s["y"]+v, "wx"=>s["wx"],"wy"=>s["wy"]+w}},
    "S" => lambda{|s,v,w| {"dir"=>s["dir"], "x"=>s["x"],"y"=>s["y"]-v, "wx"=>s["wx"],"wy"=>s["wy"]-w}},
    "W" => lambda{|s,v,w| {"dir"=>s["dir"], "x"=>s["x"]-v,"y"=>s["y"], "wx"=>s["wx"]-w,"wy"=>s["wy"]}},
    "E" => lambda{|s,v,w| {"dir"=>s["dir"], "x"=>s["x"]+v,"y"=>s["y"], "wx"=>s["wx"]+w,"wy"=>s["wy"]}},
    "F" => lambda{|s,v,w| move[s["dir"]].call(s,v,0) }
}

puts INPUT
    .inject({"dir" => "E","x" => 0,"y" => 0, "wx" => 10, "wy" => 1}) {|s, c|
        if ["N","E","S","W","F"].include? c.first
            move[c.first].call(s,c.last,c.last)
        else
            dir_map = ["N","E","S","W"]
            {"dir" => dir_map[(dir_map.index(s["dir"]) + c.last/90*(c.first=="L"?-1:1)) % 4], "x"=>s["x"], "y"=>s["y"], "wx"=>s["wx"], "wy"=>s["wy"]}
        end
    }
    .select{|k,v| ["x","y"].include? k}
    .map{|k,v| v.abs}
    .sum

# Second part
rot = {
    ["R",90] => lambda{|x,y| [y, -x]},
    ["R",180] => lambda{|x,y| [-x,-y]},
    ["R",270] => lambda{|x,y| [-y,x]},
    ["L",90] => lambda{|x,y|rot[["R",270]].call(x,y)},
    ["L",180] => lambda{|x,y|rot[["R",180]].call(x,y)},
    ["L",270] => lambda{|x,y|rot[["R",90]].call(x,y)}
}

puts INPUT
    .inject({"dir" => "E","x" => 0,"y" => 0, "wx" => 10, "wy" => 1}) {|s, c|
        if ["N","E","S","W"].include? c.first
            move[c.first].call(s,0,c.last)
        elsif c.first == "F"
            {
                "dir" => s["dir"],
                "x"=>s["wx"]*c.last + s["x"],
                "y"=>s["wy"]*c.last + s["y"],
                "wx"=>s["wx"],
                "wy"=>s["wy"]
            }
        else
            x,y = rot[c].call(s["wx"], s["wy"])
            {
                "dir" => s["dir"],
                "x"=>s["x"],
                "y"=>s["y"],
                "wx"=>x,
                "wy"=>y
            }
        end
    }
    .select{|k,v| ["x","y"].include? k}
    .map{|k,v| v.abs}
    .sum

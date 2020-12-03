input = File.readlines("input.txt")
    .map(&:split)
    .map{|x|
        {
            "range" => x.first.split("-").map(&:to_i),
            "letter" => x[1][0],
            "password" => x.last
        }
    }

# First part
puts input
    .count {|x|
        x["password"]
            .count(x["letter"])
            .between?(x["range"].first, x["range"].last)
    }

# Second part
puts input
    .count {|x|
        [
            x["password"][x["range"].first-1],
            x["password"][x["range"].last-1]
        ]    
        .count { |y| y==x["letter"] } == 1
    }
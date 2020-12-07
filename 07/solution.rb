INPUT = File.readlines("input.txt")
    .map{|x|
        container = x.match(/^(\w+ \w+) bags/).captures.first
        contents = x.scan(/((\d+) (\w+ \w+) bags?)/).map{|y| {y.last => y[1].to_i} }.flatten.inject(&:merge)
        { container => contents}
    }.inject(&:merge)

def search(target)
    INPUT
        .select{|key, val| val != nil && val.keys.include?(target) }
        .map{|key,val| [key] | search(key)}
end

# First part
puts search("shiny gold")
    .flatten
    .uniq
    .count
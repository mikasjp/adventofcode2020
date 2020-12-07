INPUT = File.readlines("input.txt")
    .map{|x|
        container = x.match(/^(\w+ \w+) bags/).captures.first
        contents = x.scan(/((\d+) (\w+ \w+) bags?)/).map{|y| {y.last => y[1].to_i} }.flatten.inject(&:merge)
        { container => contents}
    }.inject(&:merge)

# First part
def search(target)
    INPUT
        .select{|key, val| val != nil && val.keys.include?(target) }
        .map{|key,val| [key] | search(key)}
end

puts search("shiny gold")
    .flatten
    .uniq
    .count

#Second part
def search2(target)
    INPUT
        .map{|key,val| val.nil? ? [key,{}] : [key,val]}
        .to_h
        .fetch(target)
        .map{|key,val| [key]*val}
        .flatten
        .map{|x| [x].append search2(x)}
        .flatten
end
puts search2("shiny gold")
    .count
require 'set'

INPUT = File.readlines("input.txt").map(&:strip)

passes = INPUT
    .map {|x|
        row = x.chars.take(7)
            .inject(0..127) {|r,h|
                a = h == "F" ? r.take(r.count/2) : r.drop(r.count/2)
                (a.min)..(a.max)
            }.first
        col = x.chars.drop(7).take(3)
            .inject(0..7) {|r,h|
                a = h == "L" ? r.take(r.count/2) : r.drop(r.count/2)
                (a.min)..(a.max)
            }.first
        [row, col]
    }

# First part
puts passes.map{|x| x.first * 8 + x.last}.max

# Second part
puts passes
    .group_by{|x| x.first}
    .map{|k,v| [k, v.map{|y| y.last}]}
    .to_h
    .select{|k,v| v.count==7}
    .map{|k,v| k * 8 + ((0..7).to_set-v.to_set).first}
    .first
    .inspect
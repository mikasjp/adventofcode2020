INPUT = File.readlines("input.txt").map(&:strip).map{|x| {"op"=>x.split.first,"val"=>x.split.last.to_i,"exec"=>false}}

# First part
ptr = 0
acc = 0
loop do
    if INPUT[ptr]["exec"]
        puts acc
        break
    end
    if ptr>=INPUT.length
        break
    end
    case INPUT[ptr]["op"]
    when "acc"
        INPUT[ptr]["exec"] = true
        acc+=INPUT[ptr]["val"]
        ptr+=1
        next
    when "jmp"
        INPUT[ptr]["exec"] = true
        ptr+=INPUT[ptr]["val"]
        next
    when "nop"
        INPUT[ptr]["exec"] = true
        ptr+=1
    end
end
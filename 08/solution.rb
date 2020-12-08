INPUT = File.readlines("input.txt").map(&:strip).map{|x| {"op"=>x.split.first,"val"=>x.split.last.to_i}}

def run code
    ptr = 0
    acc = 0
    exec = []
    loop do
        if exec.include?(ptr)
            break
        end
        if ptr>=code.length
            break
        end
        case code[ptr]["op"]
        when "acc"
            exec.push ptr
            acc+=code[ptr]["val"]
            ptr+=1
            next
        when "jmp"
            exec.push ptr
            ptr+=code[ptr]["val"]
            next
        when "nop"
            exec.push ptr
            ptr+=1
        end
    end
    [acc, exec.include?(ptr)]
end

# First part
puts run(INPUT).first

# Second part
def swap(i)
    INPUT.each_with_index.map{|x,j|
        if j==i
            x["op"] == "jmp" ? {"op"=>"nop","val"=>x["val"]} : {"op"=>"jmp","val"=>x["val"]}
        else
            x
        end
    }
end

INPUT.each_with_index{|l,i|
    next if l["op"]=="acc"
    swp = swap(i)
    acc, err = run swp
    if !err
        puts acc
        break
    end
}
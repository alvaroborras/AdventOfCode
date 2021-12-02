@time begin
    open("input.txt", "r") do f
        prev_val = UInt16(0);
        answer = 0;
        for line in eachline(f)    
            cur_val = parse(UInt16, line);
            if prev_val > 0 && cur_val > prev_val
                answer+=1;
            end
            prev_val = cur_val;
        end
        print("Answer: $(answer)")
    end
end

# Day 1, part 1
# Given a list of integers, count the number of times that the sequence increases
@time begin
    answer = 0;
    f = open("input.txt", "r");
    heights = parse.(Int16, readlines(f));
    for j = 2:length(heights)
        if heights[j] > heights[j - 1]
            answer += 1;
        end
    end
    close(f)
    println("Answer : $(answer)")
end

# Day 1, part 2
# Now, instead of looking at single elements, count the number of times that the 3-rolling sum increases
@time begin
    f = open("input.txt", "r");
    heights = parse.(Int16, readlines(f));
    ind = 1:3;
    answer = 0;
    prev_sum = sum(heights[ind]);
    for j = 2:length(heights)-2
        if sum(heights[ind .+ 1]) > prev_sum
            answer += 1;
        end
        
        ind = ind .+ 1;
        prev_sum = sum(heights[ind]);
    end
    println("Answer part 2: $(answer)")
end

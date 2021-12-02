# Day 2, part 1
# Parse a sequence of instructions to move (forward, down or up), and change the positions accordingly

open("input.txt", "r") do f
    hor = 0;
    vert = 0;
    for line in readlines(f)
        instructions = split(line);
        direction = instructions[1];
        steps = parse(Int16, instructions[2]);
        if direction == "forward"
            hor += steps;
        elseif direction == "up"
            vert -= steps;
        else
            vert += steps;
        end
    end
    print("Answer: $(hor * vert)")
end

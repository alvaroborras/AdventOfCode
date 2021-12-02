# Day 2, part 1
# Parse a sequence of instructions to move vertically and horitontally starting from the origin, 
# and change the positions with the following rules:
#   - 'forward X' increases horitzontal position by X steps
#   - 'up X' decreases vertical position by X steps
#   - 'down X' increases vertical position by X steps
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

# Day 2, part 2

# Now, a third variable is introduced, 'aim'.
# The instructions also are different:
#   - 'down X' increases the aim by X units
#   - 'up X' decreases the aim by X units
#   - 'forward X' increases the horitzontal position by X units and increases the depth by aim * X

@time begin
    open("input.txt", "r") do f
        hor = 0;
        vert = 0;
        aim = 0;
        for line in readlines(f)
            instructions = split(line);
            direction = instructions[1];
            steps = parse(Int16, instructions[2]);
            if direction == "forward"
                hor += steps;
                vert += aim * steps;
            elseif direction == "up"
                aim -= steps;
            else
                aim += steps;
            end
        end
        print("Answer: $(hor * vert)")
    end
end

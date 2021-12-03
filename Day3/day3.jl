# Day 3, part 1
# We are given a set of binary strings (of the same length), which encode information about an 'epsilon rate'
# and a 'gamma rate'. 

# To obtain the j-th bit in the binary form of the gamma rate, 
# we need to look at the most common bit at the j-th position for each string

# To obtain the j-th bit in the binary form of the epsilon rate,
# we need to look at the least common bit at the j-th position for each string

# Since there are only two options for each position (either 0 or 1), the epsilon rate is given by a bitwise NOT (gamma = ~epsilon)

f = open("input.txt", "r");
X = readlines(f);
close(f)
N = length(X);
L = length(X[1]);

gamma_rate = "";
epsilon_rate = "";
count0s = zeros(Int32, L);
for col = 1:L
    # count the number of occurrences of 0
    for row = 1:N
        count0s[col] += (X[row][col] == '0');
        if count0s[col] > N/2
            break
        end
    end
    gamma_rate = gamma_rate * ((count0s[col] > N/2) ? "0" : "1");
    epsilon_rate = epsilon_rate * ((count0s[col] < N/2) ? "0" : "1");
end
gamma_dec = (parse(Int32, gamma_rate, base=2));
epsilon_dec = (parse(Int32, epsilon_rate, base=2));
println("Gamma_rate: $gamma_rate (= $gamma_dec)")
println("epsilon_rate: $epsilon_rate (= $epsilon_dec)")
println("Answer: $(epsilon_dec * gamma_dec)")


# Day 3, part 2

# Now we are asked to compute two different quantities, 'oxygen generator rating' and 'CO2 scrubber rating'
# Consider first bit of the binary strings
#Keep only numbers selected by the bit criteria for the type of rating value for which you are searching. Discard numbers which do not match the bit criteria.
#    If you only have one number left, stop; this is the rating value for which you are searching.
#    Otherwise, repeat the process, considering the next bit to the right.

#The bit criteria depends on which type of rating value you want to find:
#    To find oxygen generator rating, determine the most common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 1 in the position being considered.
#    To find CO2 scrubber rating, determine the least common value (0 or 1) in the current bit position, and keep only numbers with that bit in that position. If 0 and 1 are equally common, keep values with a 0 in the position being considered.

@time begin 
    f = open("input.txt", "r");
    X = readlines(f);
    close(f)
    N = length(X);
    L = length(X[1]);
    Y = zeros(Int8, N, L);
    # Process data to integers instead of strings
    for row = 1:N
        for col = 1:L
            Y[row,col] = parse(Int, string(X[row][col]));
        end
    end

    # Oxygen rating
    candidates_ox = ones(Int8, N);
    valid_ox = 1:N;
    for col = 1:L 
        most_common_value_ox = 1*(sum( Y[ valid_ox, col ] ) >= length(valid_ox)/2); 
        for row = valid_ox
            if Y[row,col] != most_common_value_ox
                candidates_ox[row] = 0;
            end
        end
        valid_ox = findall(x -> x .== 1, candidates_ox);
        if length(valid_ox) == 1
            break
        end
    end
    ox_rating = parse(Int, join(Y[valid_ox, :]), base=2);

    # Co2 rating
    candidates_co2 = ones(Int8, N);
    valid_co2 = 1:N;

    for col = 1:L 
        most_common_value_co2 = 1*(sum( Y[ valid_co2, col ] ) < length(valid_co2)/2); 
        for row = valid_co2
            if Y[row,col] != most_common_value_co2
                candidates_co2[row] = 0;
            end
        end
        valid_co2 = findall(x -> x .== 1, candidates_co2);
        if length(valid_co2) == 1
            break
        end
    end
    co2_rating = parse(Int, join(Y[valid_co2, :]), base=2)

    println("Oxygen rating: $ox_rating, CO2 rating: $co2_rating")
    println("Answer: $(ox_rating * co2_rating)")
end

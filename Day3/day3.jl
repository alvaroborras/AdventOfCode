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
for col = 1:L
    # count the number of occurrences of 0
    count0s = 0; 
    
    for row = 1:N
        count0s += (X[row][col] == '0');
        if count0s > N/2
            break
        end
    end
    gamma_rate = gamma_rate * ((count0s > N/2) ? "0" : "1");
    epsilon_rate = epsilon_rate * ((count0s < N/2) ? "0" : "1");
end
gamma_dec = (parse(Int32, gamma_rate, base=2));
epsilon_dec = (parse(Int32, epsilon_rate, base=2));
println("Gamma_rate: $gamma_rate (= $gamma_dec)")
println("epsilon_rate: $epsilon_rate (= $epsilon_dec)")
println("Answer: $(epsilon_dec * gamma_dec)")

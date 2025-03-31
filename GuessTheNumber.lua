local currentNumber = math.random(100);
local guess
local count = 0
io.write("Guess the number (1-100)\n")
guess = io.read("n*")
count = count + 1

while guess ~= currentNumber do
    if guess > currentNumber then
        io.write("Too high!\n")
        guess = io.read("n*")
    elseif guess < currentNumber then
        io.write("Too low!\n")
        guess = io.read("n*")
    end
    count = count + 1
end

io.write("You got it!\n")
io.write("The number was " , currentNumber , "\n")
io.write("It took you " , count , " guesses\n")
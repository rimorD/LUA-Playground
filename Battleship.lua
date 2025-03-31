SHIPSIZES = {5, 4, 3, 3, 2, 2, 2}
function NEWGAME()
    -- Initialize board
    BOARD = {}
    PLAYERBOARD = {}
    GUESSES = 0
    SUNKSHIPS = 0
    for i=1, 10 do
        BOARD[i] = {}
        PLAYERBOARD[i] = {}
        for j=1, 10 do
            BOARD[i][j] = "-"
            PLAYERBOARD[i][j] = "-"
        end
    end
    -- Randomly arrange ships
    for index, size in ipairs(SHIPSIZES) do
        ARRANGESHIP(size, index)
    end

end

function ARRANGESHIP(size, shipNumber)
    local randomRow = math.random(1, 10);
    local randomCell
    local index = 0;
    repeat
        randomCell = math.random(1, 10);   
        index = index + 1
    until index > 10 or BOARD[randomRow][randomCell] == "-"
    local randomDirection = math.random(1, 2)
    
    -- right
    local occupiedSpaces = false
    if randomDirection == 1 then
        if randomCell > size then
            randomCell = size
        end
        for i = randomCell, randomCell + size - 1 do
            occupiedSpaces = BOARD[randomRow][i] ~= "-"
        end

        if occupiedSpaces then
            ARRANGESHIP(size, shipNumber)
        else
            for i = randomCell, randomCell + size - 1 do
                BOARD[randomRow][i] = shipNumber
            end
        end
    -- down
    else  
        if randomRow > size then
            randomRow = size
        end
        for i = randomRow, randomRow + size - 1 do
            occupiedSpaces = BOARD[i][randomCell] ~= "-"
        end

        if occupiedSpaces then
            ARRANGESHIP(size, shipNumber)
        else
            for i = randomRow, randomRow + size - 1 do
                BOARD[i][randomCell] = shipNumber
            end
        end
    end
end

function SELECTCELL()
    local row = READNUMBER("row")
    local cell = READNUMBER("cell")
    GUESSES = GUESSES + 1

    if BOARD[row][cell] == "X" or BOARD[row][cell] == "O" then
        io.write("Cell already selected!\n")
        return
    end

    if BOARD[row][cell] ~= "-" and BOARD[row][cell] ~= "O" then
        io.write("Hit!")
        local ship = BOARD[row][cell]
        PLAYERBOARD[row][cell] = "X"
        BOARD[row][cell] = "X"

        local sunkShip = true;
        for i=1, 10 do
            for j=1, 10 do
                if BOARD[i][j] == ship then
                    sunkShip = false
                    break
                end
            end
        end

        if sunkShip then
            io.write("Sunk!")
            SUNKSHIPS = SUNKSHIPS + 1
        end
    else 
        io.write("Miss!")
        PLAYERBOARD[row][cell] = "O"
    end
    io.write("\n")
    PRINTBOARD()
end

function READNUMBER(rowOrCell)
    io.write("Select a " , rowOrCell , " (1-10)")
    local guess = io.read("n*");
    while guess < 1 or guess > 10 do
        io.write("Invalid " , rowOrCell ," selected (1-10)")
        guess = io.read("n*");
    end

    return guess
end


function PRINTBOARD()
    for i=1, 10 do
        for j=1, 10 do
            io.write(PLAYERBOARD[i][j])
        end
        io.write("\n")
    end
end

function PLAY()
    NEWGAME()

    while SUNKSHIPS < #SHIPSIZES do
        SELECTCELL()
    end

    io.write("Game over!")
    io.write("It took you " , GUESSES , " guesses to sink all the ships!")
end

PLAY()
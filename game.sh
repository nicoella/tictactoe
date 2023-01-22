#!/bin/bash

# This is a command-line tic-tac-toe game.
# The code can also be found on my Github (https://github.com/nicoella/tictactoe).

# global variables
cur_player="X"
grid=(' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ')
cnt=0
winner="0"

# run game
while true
do
    row=0
    col=0
    error=false
    while true
    do
        #print screen
        printf "\033c"
        echo "TIC-TAC-TOE"
        echo ""
        echo "Current Player: "$cur_player
        echo ""
        echo "    A   B   C"
        echo "  |---|---|---|"
        echo "1 | ${grid[0]} | ${grid[1]} | ${grid[2]} |"
        echo "  |---|---|---|"
        echo "2 | ${grid[3]} | ${grid[4]} | ${grid[5]} |"
        echo "  |---|---|---|"
        echo "3 | ${grid[6]} | ${grid[7]} | ${grid[8]} |"
        echo "  |---|---|---|"
        echo ""

        #read input
        echo "Where would you like to place your piece?"
        if [[ $error == true ]];
        then
            echo "That was not valid input. Please try again."
        fi
        echo -n "ROW: "
        read rowval 
        echo -n "COL: "
        read colval

        # error trapping
        rowval=$(( $rowval-1 ))
        if [ $colval == 'A' ]; then
            colval=0
        fi
        if [ $colval == 'B' ]; then
            colval=1
        fi
        if [ $colval == 'C' ]; then
            colval=2
        fi

        if ([[ $rowval -eq 0 ]] || [[ $rowval -eq 1 ]] || [[ $rowval -eq 2 ]]) &&  ([[ $colval -eq 0 ]] || [[ $colval -eq 1 ]] || [[ $colval -eq 2 ]]) && [[ ${grid[(($rowval*3+colval))]} == ' ' ]];
        then
            row=$rowval
            col=$colval
            break
        fi

        error=true
    done

    # update position
    index=$(( $row*3+$col ))
    grid[$index]=$cur_player
    
    if [ $cur_player == "X" ]; 
    then
        cur_player="O"
    else
        cur_player="X"
    fi

    # check for a winner
    for ((row=0;row<3;row++));
    do
        same=true
        for ((col=1;col<3;col++));
        do
            if [[ ${grid[(($row*3+col-1))]} != ${grid[(($row*3+col))]} ]];
            then
                same=false
                break
            fi
        done

        if [ $same == true ] && [[ ${grid[(($row*3))]} != ' ' ]];
        then
            winner=${grid[(($row*3))]}
            break
        fi
    done

    for ((col=0;col<3;col++));
    do
        same=true
        for ((row=1;row<3;row++));
        do
            if [[ ${grid[((($row-1)*3+col))]} != ${grid[(($row*3+col))]} ]];
            then
                same=false
                break
            fi
        done

        if [ $same == true ] && [[ ${grid[$col]} != ' ' ]];
        then
            winner=${grid[col]}
            break
        fi
    done

    if [[ ${grid[0]} == ${grid[4]} ]] && [[ ${grid[0]} == ${grid[8]} ]];
    then
        winner=${grid[0]}
    fi
    if [[ ${grid[2]} == ${grid[4]} ]] && [[ ${grid[2]} == ${grid[6]} ]];
    then
        winner=${grid[2]}
    fi

    ((cnt=cnt+1))
    if [ $cnt -eq 9 ] || [ $winner != "0" ]; then
        break
    fi
done

# display win screen
printf "\033c"
echo "TIC-TAC-TOE"
echo ""
echo "    A   B   C"
echo "  |---|---|---|"
echo "1 | ${grid[0]} | ${grid[1]} | ${grid[2]} |"
echo "  |---|---|---|"
echo "2 | ${grid[3]} | ${grid[4]} | ${grid[5]} |"
echo "  |---|---|---|"
echo "3 | ${grid[6]} | ${grid[7]} | ${grid[8]} |"
echo "  |---|---|---|"
echo ""
if [ $winner == "0" ]; 
then
    echo "TIE!"
else
    echo "PLAYER $winner WON!"
fi



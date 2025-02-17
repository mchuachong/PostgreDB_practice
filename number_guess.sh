#!/bin/bash
LUCKY_NUMBER=$((1 + ($RANDOM % 1000)))
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#login
echo "Enter your username:"
read USERNAME
#fetch user data
USER_DATA=$($PSQL "SELECT best_game,games_played FROM usernames WHERE username='$USERNAME'")
#if not in db
if [[ -z $USER_DATA ]]
then
ADD_NEW_USER=$($PSQL "INSERT INTO usernames(username) VALUES('$USERNAME')")
echo "Welcome, $USERNAME! It looks like this is your first time here."
else
#if in db
#read data
echo $USER_DATA | while IFS="|" read BEST_GAME GAMES_PLAYED
do
echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
done
fi

#game_start
echo -e "\nGuess the secret number between 1 and 1000:\n"
#initialize guess count
COUNT=0
#echo $LUCKY_NUMBER
#game_logic
GUESS_FUNC(){
read GUESS
COUNT=$(($COUNT + 1))
#integer check
if [[ $GUESS =~ ^[0-9]+$ ]]
then
  #if higher
  if [[ $GUESS -gt $LUCKY_NUMBER ]]
  then
  echo "It's lower than that, guess again:"
  GUESS_FUNC
  else 
    if [[ $GUESS -lt $LUCKY_NUMBER ]]
    then
    echo "It's higher than that, guess again:"
    GUESS_FUNC
    else
    echo "You guessed it in $COUNT tries. The secret number was $LUCKY_NUMBER. Nice job!"
    #send data back to db
    GAMES_PLAYED=$(($GAMES_PLAYED + 1))
      #update high score
      if [[ $COUNT -le $BEST_GAME ]]
      then
      BEST_GAME=$COUNT
      fi
    UPDATE_BG=$($PSQL "UPDATE usernames SET best_game = $BEST_GAME where username = '$USERNAME'")
    UPDATE_GP=$($PSQL "UPDATE usernames SET games_played = $GAMES_PLAYED where username = '$USERNAME'")
    fi
  fi
else
echo "That is not an integer, guess again:"
GUESS_FUNC
fi
}


#fetch user data
BEST_GAME=$($PSQL "SELECT best_game FROM usernames WHERE username='$USERNAME'")
GAMES_PLAYED=$($PSQL "SELECT games_played FROM usernames WHERE username='$USERNAME'")
GUESS_FUNC


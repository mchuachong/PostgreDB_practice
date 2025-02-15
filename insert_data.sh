#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# clear DB
CLEAR=$($PSQL "TRUNCATE TABLE games, teams;")
RESETSEQ=$($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART WITH 1;")
#read
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WGOALS OGOALS; do
#echo $YEAR,$ROUND,$WINNER,$OPPONENT,$WGOALS,$OGOALS++
#Add Winning Team
#get id
if [[ $WINNER != 'winner' ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID ]]
      then
      #add team
      INSERT_WINNER_TEAM=$($PSQL "INSERT INTO teams (name) values ('$WINNER')")
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      echo added $WINNER to teams
    fi
fi
#Add Opponent Team
if [[ $OPPONENT != 'opponent' ]]
  then
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPP_ID ]]
      then
      #add team
      INSERT_OPPONENT_TEAM=$($PSQL "INSERT INTO teams (name) values ('$OPPONENT')")
      OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      echo added $OPPONENT to teams
    fi
fi

#Insert Data
INSERT_DATA=$($PSQL "INSERT INTO games (year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($YEAR,'$ROUND',$WINNER_ID,$OPP_ID,$WGOALS,$OGOALS)")
echo added game $YEAR $ROUND $WINNER_ID-$WINNER $OPP_ID-$OPPONENT SCORE:$WGOALS, $OGOALS
done
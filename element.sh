INPUT=$1
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
# if blank
if [[ -z $INPUT ]]
  then
  echo Please provide an element as an argument.
  else
  #check if ID,name or symbol
    #if id
    if [[ $INPUT =~ ^[0-9]+$ ]]
    then
    ELEMENT_ID=$INPUT
    #get the rest of the data
    ELEMENT_DATA=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius from elements join properties using (atomic_number) join types using (type_id) where atomic_number = '$ELEMENT_ID';")
    else
      if [[ $INPUT =~ ^[a-z||A-Z][a-z]?$ ]]
      then
      ELEMENT_SYMBOL=$INPUT
      #get the rest of the data
      ELEMENT_DATA=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius from elements join properties using (atomic_number) join types using (type_id) where symbol = initcap('$ELEMENT_SYMBOL');")     
      else
      ELEMENT_NAME=$INPUT
      #get the rest of the data
      ELEMENT_DATA=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius from elements join properties using (atomic_number) join types using (type_id) where name = initcap('$ELEMENT_NAME');")
      fi
    fi  
  # if not in db
  if [[ -z $ELEMENT_DATA ]]
  then
  echo "I could not find that element in the database."
  else
  #read data
  echo $ELEMENT_DATA | while IFS="|"  read ELEMENT_ID ELEMENT_NAME ELEMENT_SYMBOL ELEMENT_TYPE ELEMENT_MASS ELEMENT_MPC ELEMENT_BPC 
  do
  #output
  echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MPC celsius and a boiling point of $ELEMENT_BPC celsius."
  done
  fi
fi
#pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql
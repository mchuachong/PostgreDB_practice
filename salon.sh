#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU(){
#diplay services
echo -e "\nPlease Select a Service:\n"
SERVICES=$($PSQL "SELECT service_id,name FROM services")
echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
do
echo "$SERVICE_ID) $SERVICE_NAME"
done
read SERVICE_ID_SELECTED
#fetch service
SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
if [[ -z $SERVICE_SELECTED ]]
then
echo -e "\nWe're sorry, but that service does not exist\n"
MAIN_MENU 
else
echo -e "\nEnter your phone number:\n"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "Select name from customers where phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
  #add customer
  echo -e "\nNumber not found in database"
  echo "Enter your name:"
  read CUSTOMER_NAME
  INSERT_CUSTOMER=$($PSQL "INSERT INTO customers (name,phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
CUSTOMER_ID=$($PSQL "SELECT customer_id from customers where phone='$CUSTOMER_PHONE'")
echo -e "\n Hi $CUSTOMER_NAME!\n"
echo "What time would you like to book your appointment?"
read SERVICE_TIME
# add to appointment
ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
echo "I have put you down for a$SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
fi
}

MAIN_MENU
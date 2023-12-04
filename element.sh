PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

DATATYPE=

if [[ $1 =~ ^[0-9]+$ ]]
then
  DATATYPE="INT"
else
  DATATYPE="STRING"
fi

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
else
  if [[ $DATATYPE = "INT" ]]
  then
    if [[ ! -z $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1") ]]
    then
      echo $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1") | while IFS="|" read TYPEID ATO_NUM SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  elif [[ $DATATYPE = "STRING" ]]
  then
    if [[ ! -z $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'") ]]
    then
      echo $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'") | while IFS="|" read TYPEID ATO_NUM SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    elif [[ ! -z $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'") ]]
    then
      echo $($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'") | while IFS="|" read TYPEID ATO_NUM SYMBOL NAME MASS MELT BOIL TYPE
      do
        echo "The element with atomic number $ATO_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  fi
fi


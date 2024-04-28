#!/bin/sh
CONTAINER_NAME=$1
DB_PASSWORD="my_root_password"

if [ -z $CONTAINER_NAME ]
then
  CONTAINER_NAME="aion49-database"
fi

BKP_FOLDER="./DB_Backups"
if [ ! -d $BKP_FOLDER ]
then
  mkdir $BKP_FOLDER
fi

DATE_FOLDER="$BKP_FOLDER/$(date +%Y-%m-%d_%H-%M-%S)"
if [ ! -d $DATE_FOLDER ]
then
  mkdir $DATE_FOLDER
fi

for DATABASE_NAME in al_server_gs al_server_ls
do
EXPORT_FILE="$DATE_FOLDER/$DATABASE_NAME.sql"

echo ""
echo "---------------------------------------------------"
echo ""

echo "Backing up database '$DATABASE_NAME' from container '$CONTAINER_NAME'..."
docker exec -e MYSQL_PWD="$DB_PASSWORD" $CONTAINER_NAME /usr/bin/mysqldump -u root $DATABASE_NAME > $EXPORT_FILE
echo "Exporting $DATABASE_NAME.sql file from container..."
echo "Backed up database '$DATABASE_NAME' to $EXPORT_FILE"

done

echo ""
echo "---------------------------------------------------"
echo ""
echo "Done!"
echo ""

echo -n "Press [ENTER] to finish"
read exitvar

#!/bin/bash

############################################################
# Help                                                     #
############################################################
# Source progress bar
MIGRATION_CHARACTERS_FILE=('1_CREATE_CLEANUP_TABLES' '2_CREATE_MISSING_TABLES' '3_ALTER_TABLES' '4_CLEANUP_AND_CONVERT_SPELLS' '5_FINAL_CLEANUP')
MIGRATION_MOD=()
MIGRATION_AUTH_FILE=('6.AUTH_RENAME_COLUMNS' '7.AUTH_CLEAN_AND_CONVERTER')


IFS=':' read -r -a CHARACTERS_DBS_ARRAY <<< "$CHARACTERS_DBS"
IFS=':' read -r -a DUMP_CHARACTERS_FILES_PATH_ARRAY <<< "$DUMP_CHARACTERS_FILES_PATH"

RepeatChar(){
	for _ in {1..90}; do echo -n "$1"; done
	echo
}

Help()
{
   # Display Help
   echo "Restore & migrate TrinityCore DB to AzerothCore DB"
   echo
   echo "Syntax: scriptTemplate ([-d][MOD_NAME])...  [-a|-r|-m]"
   echo "options:"
   echo "a     Restore and migrate DB"
   echo "r     Restore original TrinityCore DB"
   echo "m     Migrate TrinityCore DB to AzerothCore DB"
   echo "d     Taking account of (known) mod used in TrinityCore DB to AzerothCore DB migration"
   echo "h     Show this message"
   echo
   echo "Exemple: ./migrate -d mod_transmog -d mod_other -a"
   #echo "c     Migrate only Characters table from TrinityCore DB to AzerothCore DB"
}

HelpModule()
{
  # Dipslay known modules for migration
  echo "Known modules:"
  echo "       MOD_TRANSMOG"
}

Restore()
{
  RepeatChar '-'
  echo "Restore ${AUTH_DB}"
  RepeatChar '-'
  /usr/bin/mysql\
  --user="${DB_USER}" \
  --password="${DB_PASS}" \
  --host="${DB_HOSTNAME}" \
  --port="${DB_PORT}" \
  -e "
  DROP DATABASE IF EXISTS ${AUTH_DB};
  CREATE DATABASE  ${AUTH_DB};
  "

  /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < "${DUMP_AUTH_FILE_PATH}"

  for db_index in "${!CHARACTERS_DBS_ARRAY[@]}"; do
    RepeatChar '-'
    echo "Restore ${CHARACTERS_DBS_ARRAY[$db_index]}"
    RepeatChar '-'

    /usr/bin/mysql\
    --user="${DB_USER}" \
    --password="${DB_PASS}" \
    --host="${DB_HOSTNAME}" \
    --port="${DB_PORT}" \
    -e "
    DROP DATABASE IF EXISTS ${CHARACTERS_DBS_ARRAY[$db_index]};
    CREATE DATABASE  ${CHARACTERS_DBS_ARRAY[$db_index]};
    "
    /usr/bin/mysql --database="${CHARACTERS_DBS_ARRAY[$db_index]}"\
    --user="${DB_USER}"\
    --password="${DB_PASS}"\
    --host="${DB_HOSTNAME}"\
    --port="${DB_PORT}"\
    < "${DUMP_CHARACTERS_FILES_PATH_ARRAY[$db_index]}"
  done
}

MigrateAuth()
{
  RepeatChar '-'
  echo "Migrate ${AUTH_DB}"
  RepeatChar '-'
  for file_name in "${MIGRATION_AUTH_FILE[@]}"
  do
    echo "Execute: $file_name"
    /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./"${file_name}".sql
  done
}

MigrateCharacters()
{
  for db_index in "${!CHARACTERS_DBS_ARRAY[@]}"; do
    RepeatChar '-'
    echo "Migrate ${CHARACTERS_DBS_ARRAY[$db_index]}"
    RepeatChar '-'
    for file_name in "${MIGRATION_CHARACTERS_FILE[@]}"
    do
      echo "Execute: $file_name"
      /usr/bin/mysql --database="${CHARACTERS_DBS_ARRAY[$db_index]}"\
      --user="${DB_USER}"\
      --password="${DB_PASS}"\
      --host="${DB_HOSTNAME}"\
      --port="${DB_PORT}"\
      < "${file_name}.sql"
    done
  done
}

MigrateCharactersMod()
{
  for db_index in "${!CHARACTERS_DBS_ARRAY[@]}"; do
    RepeatChar '-'
    echo "Migrate ${CHARACTERS_DBS_ARRAY[$db_index]}"
    RepeatChar '-'
    for file_name in "${MIGRATION_MOD[@]^^}"
    do
      echo "Execute: $file_name"
      /usr/bin/mysql --database="${CHARACTERS_DBS_ARRAY[$db_index]}"\
      --user="${DB_USER}"\
      --password="${DB_PASS}"\
      --host="${DB_HOSTNAME}"\
      --port="${DB_PORT}"\
      < "mod/${file_name}.sql"
    done
  done
}

############################################################
# Main program                                             #
############################################################
# Get the options
while getopts ":hrmad:" option; do
   case $option in
      d) # Enter mod name in capital letter (like following MOD_TRANSMOG)
	 MIGRATION_MOD+=("$OPTARG");;
      h) # display Help
         Help
	 HelpModule
         exit;;
      r) # Enter a name
        Restore
        exit;;
      m) # Enter a name
        MigrateCharacters
	MigrateCharactersMod
        MigrateAuth
        exit;;
      a) # Enter a name
        Restore
        MigrateCharacters
	MigrateCharactersMod
        MigrateAuth
        exit;;
     \?) # Invalid option
	echo "Invalid option."
        Help
        exit;;
   esac
done
# migrate dbs

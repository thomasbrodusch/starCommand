#!/bin/bash

## Config 
export CORE_PATH='./core'
export LARADOCK_GIT='https://github.com/laradock/laradock.git'
export APPLICATION_PATH='\.\.\/\.\.\/projects\/'
export PROJECTS_FOLDER_PATH='./projects'

printf "\n\n •••••• Star Command (dev environnement manager) ••••••\n"

### First Install ? ... REQUIRED ####
if [ ! -d $CORE_PATH/laradock ]; then
	printf "    ℹ️   Laradock is not installed. "
	echo " First launch, we need to perform some pre-configuration actions..."
    printf "	☁	️Downloading Laradock... 📦\n"
	
	# Fetch Laradock
	git clone $LARADOCK_GIT $CORE_PATH/laradock
	printf "	✔  Laradock installed with success \n"
else
	printf "	✔ Laradock already installed.  \n"
fi


# Copy environnement var
if [ ! -f $CORE_PATH/laradock/.env ]; then

	cp $CORE_PATH/laradock/env-example $CORE_PATH/laradock/.env
	# Replace by custom APPLICATION Path
	sed -i -e "s/APPLICATION=.*/APPLICATION=$APPLICATION_PATH/g" $CORE_PATH/laradock/.env
fi




##### App MENU ######

PS3=$'\n\n •••••• Star Command •••••• \n Please enter your choice: (press enter to see menu)'

options=("Manage web projects" "Start environnement" "List docker environnement up" "Quit")
printf '\n'
select opt in "${options[@]}"
do
    case $opt in
        
        "Manage web projects")

            # Launch Project Manager
			$CORE_PATH/project_manager.sh

            ;;
        "Start environnement")
	
            # Startup our Dockers machines
            cd $CORE_PATH/laradock
			docker-compose up -d nginx mysql

            ;;
        "List docker environnement up")

            # Startup our Dockers machines
			$CORE_PATH/docker_manager.sh

        ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

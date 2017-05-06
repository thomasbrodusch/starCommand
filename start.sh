#!/bin/bash

## Config 
export CORE_PATH='./core'
export LARADOCK_PATH='./core/laradock'
export LARADOCK_GIT='https://github.com/laradock/laradock.git'
export APPLICATION_PATH='\.\.\/\.\.\/projects\/'
export PROJECTS_FOLDER_PATH='./projects'

printf "\n\n •••••• Star Command (dev environnement manager) ••••••\n"

### First Install ? ... REQUIRED ####
if [ ! -d $LARADOCK_PATH ]; then
	printf "    ℹ️   Laradock is not installed. "
	echo " First launch, we need to perform some pre-configuration actions..."
    printf "	☁	️Downloading Laradock... 📦\n"
	
	# Fetch Laradock
	git clone $LARADOCK_GIT $LARADOCK_PATH
	printf "	✔  Laradock installed with success \n"

else
	printf "	✔ Laradock already installed.  \n"
fi


# Copy environnement var
if [ ! -f $LARADOCK_PATH/.env ]; then

	cp $LARADOCK_PATH/env-example $LARADOCK_PATH/.env
	# Replace by custom APPLICATION Path
	sed -i -e "s/APPLICATION=.*/APPLICATION=$APPLICATION_PATH/g" $LARADOCK_PATH/.env
fi




##### App MENU ######

PS3=$'\n\n •••••• Star Command •••••• \n Please enter your choice: (press enter to see menu)'

options=("> Start" "Manage web projects" "Manage Dockers Containers" "Quit")
printf '\n'
select opt in "${options[@]}"
do
    case $opt in
        "> Start")
    
            # Startup our Dockers machines
            cd $LARADOCK_PATH
            docker-compose up -d nginx mysql
            cd ../..

            ;;
        "Stop")
            cd $LARADOCK_PATH
            # Stop all Dockers machines
            docker-compose stop
            cd ../..

        ;;
        "Manage web projects")

            # Launch Project Manager
			$CORE_PATH/project_manager.sh

            ;;
        "Manage Dockers Containers")

            # Startup our Dockers machines
			$CORE_PATH/docker_manager.sh

        ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

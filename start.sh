#!/bin/bash

## Config 
export OSTYPE=$(uname)
export CORE_PATH='./core'
export LARADOCK_PATH='./core/laradock'
export LARADOCK_GIT='https://github.com/laradock/laradock.git'
export APPLICATION_PATH='\.\.\/\.\.\/projects\/'
export PROJECTS_FOLDER_PATH='./projects'
export STARCOMMAND_PATH=$(pwd)

printf "\n\n •••••• Star Command (dev environnement manager) ••••••\n"

### First Install ? ... REQUIRED ####
if [ ! -d $LARADOCK_PATH ]; then
	printf "\n    ℹ️   Laradock is not installed. "
	echo " First launch, we need to perform some pre-configuration actions:"
    printf "\n	📦    Downloading Laradock... \n"
	
	# Fetch Laradock
	#git clone $LARADOCK_GIT $LARADOCK_PATH
	printf "\n	✔  Laradock installed with success \n"

    # MacOS NTFS Shared folder fix — load files faster
    if [ $OSTYPE == "Darwin" ]; then
        $CORE_PATH/macOS_ntfs_fix.sh
    fi

else
	printf "\n	✔ Laradock already installed.  \n"
fi


# Copy environnement var
if [ ! -f $LARADOCK_PATH/.env ]; then

	cp $LARADOCK_PATH/env-example $LARADOCK_PATH/.env
	# Replace by custom APPLICATION Path
	sed -i -e "s/APPLICATION=.*/APPLICATION=$APPLICATION_PATH/g" $LARADOCK_PATH/.env
fi




##### App MENU ######

PS3=$'\n\n •••••• Star Command •••••• \n Please enter your choice: (press enter to see menu)'

options=("> Start" "> Stop" "Manage web projects" "Manage Dockers Containers" "Quit")
printf '\n'
select opt in "${options[@]}"
do
    case $opt in
        "> Start")
    
            # Startup our Dockers machines
            cd $LARADOCK_PATH
            docker-compose up -d nginx mysql 
            cd ../..
            printf "\n  ✔ All Laradock docker machines are started.  \n"

            ;;
        "Manage web projects")

            # Launch Project Manager
			$CORE_PATH/project_manager.sh

            ;;
        "Connect to Workspace (Composer, Gulp, Yarn, NPM, …)")
            cd $LARADOCK_PATH
            docker-compose exec workspace bash
            cd ../..

        ;;
        "Manage Dockers Containers")

            # Startup our Dockers machines
			$CORE_PATH/docker_manager.sh

        ;;
        "Quit")
            cd $LARADOCK_PATH
            # Stop all Dockers machines
            docker-compose stop
            cd ../..
            printf "\n  ✔ All Laradock docker machines are stopped.  \n"
            break
            ;;
        *) echo invalid option;;
    esac
done

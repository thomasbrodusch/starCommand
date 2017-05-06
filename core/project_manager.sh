#!/bin/bash

## Create projects/ folder
if [ ! -d $PROJECTS_FOLDER_PATH ]; then
	printf "    ℹ️   Projects/ folder not created. \n"
	mkdir $PROJECTS_FOLDER_PATH
	printf "	✔ 	️Projects/ folder created with success.\n\n"
fi


PS3=$'\n\n •••••• Star Command / 📦 Projects Manager •••••• \n Please enter your choice: (press enter to see menu)'
options=("Add a new project" "List linked projects" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Add a new project")
            printf '\n Type the name of  new project, and press [ ENTER ]: '
		    read newProject
	            
	    
	        if [ ! -d "$newProject" ]; then
	        	printf '\n Type Github/Bitbucket URL to your project repository, and press [ ENTER ]: '
	            read newProjectRepository

			    printf '\n Type custom local domain to acces to your project (exemple.dev), and press [ ENTER ]; '
			    read newProjectDevUrl
		    
				# Create new project folder 
				git clone $newProjectRepository $PROJECTS_FOLDER_PATH/$newProject
				printf '\n ✔ Project "$newProject" created with success '
				
				# Nginx config file
				cp $LARADOCK_PATH/nginx/sites/project-1.conf.example $LARADOCK_PATH/nginx/sites/$newProject.conf
				sed -i -e "s/server_name .*/server_name $newProjectDevUrl;/g" $LARADOCK_PATH/nginx/sites/$newProject.conf
				sed -i -e "s/root \/var\/www\/project.*/root \/var\/www\/$newProject\/public;/g" $LARADOCK_PATH/nginx/sites/$newProject.conf
				
				# Add custom domain to the hosts file:
				printf "\nEdit hosts file..."
				sudo -- sh -c -e "echo '127.0.0.1 $newProjectDevUrl' >> /etc/hosts";
		    else
	           	printf "\n Project '$newProject' already exist."
	        fi	
		    
	    ;;
        "List linked projects")
            printf '\n\nCurrents projects :'
            cd $PROJECTS_FOLDER_PATH
            printf '\n'
            for i in $(ls -d */); do echo ${i}; done
            cd ..
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

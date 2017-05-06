#!/bin/bash

PS3=$'\n\n •••••• Star Command / Docker Manager •••••• \n Please enter your choice: (press enter to see menu)'
options=("List docker environnement up" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        
        "List docker machines up")
            cd $LARADOCK_PATH
            # List started Dockers machines
			docker-compose ps
            cd ../..

        ;;
        "Close all docker machines")
            cd $LARADOCK_PATH
            # List started Dockers machines
            docker-compose ps
            cd ../..

        ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

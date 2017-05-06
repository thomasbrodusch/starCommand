#!/bin/bash

PS3=$'\n\n •••••• Star Command / Docker Manager •••••• \n Please enter your choice: (press enter to see menu)'
options=("List docker environnement up" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        
        "List docker environnement up")

            # List started Dockers machines
			docker ps

        ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

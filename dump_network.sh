#!/bin/bash

#creation répertoire
function init {
		mkdir ~/Documents/dump/
		echo "Directory /Documents/dump created"
}

#retourne la liste des réseaux enregistrés
function dump {
	if [ ! -d ~/Documents/dump/ ]; then
		init
	fi
	echo " "
	echo "List of networks:"
	cd /etc/NetworkManager/system-connections
	ls > ~/Documents/dump/list.txt 
	cat ~/Documents/dump/list.txt

}

#retourne le mot de passe du réseau souhaité
function getPassword {

	#echo "root privileges needed"
	echo "Password of which network ?"
	read name_network

	if [  "$name_network" == " " ];then
		echo "no network entered"
	else
		sudo cat /etc/NetworkManager/system-connections/"$name_network" | grep psk > ~/Documents/dump/passwd_"$name_network"
		echo ""
		echo "Password found:"
		cat ~/Documents/dump/passwd_"$name_network"
		echo ""
		echo "stored in: ~/Documents/dump/passwd_$name_network "
	fi
}

#retourne table de routage noyau
function route () {
	netstat -r
}

#fonction d'aide
function help {
	echo "		-------	Network password recover ------ "
	echo "  "
	echo "-d:  list recorded networks" 
	echo "-p:  get password " #$2 = name_network
	echo "-r:  show routing table"
	echo " 			made by sylvain"
}


#fonction principale
	if [ "$1" == "-d" ];then
		dump
	elif [ "$1" == "-r" ];then
		route
	elif [ -z "$1" ]; then
		help
		exit
	elif [  "$1" == "-h" ]; then
		help
		exit
	elif [ "$1" == "-p" ];then
		getPassword
	fi

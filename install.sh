#!/bin/bash

clear
echo ""
echo "                      ***//*                      "
sleep 0.05
echo "                    //////*//*                    "
sleep 0.05
echo "                  *////////////                   "
sleep 0.05
echo "      /*          **/////* ////*          //      "
sleep 0.05
echo "    *//           /***//   /////          *//*    "
sleep 0.05
echo "   ///           /*    *////////           *///   "
sleep 0.05
echo "  ///*/          *         /////*           *///  "
sleep 0.05
echo " *////// *//// **          /////*           *//// "
sleep 0.05
echo "  /*///*/*/////*   **//***///*////**///*    /////*"
sleep 0.05
echo "   /*/////*////**/*/////////////////////** /*/////"
sleep 0.05
echo ""
sleep 0.05
echo "+ -- -- -- -- -- --=[ TEAM SAVE's vimrc v0.1 ]"
echo ""


sleep 0.1
# We recommend to setting vimrc file on your own account.
echo -n "Check user ... "
if [ $EUID = 0 ];
then
	echo "";
	echo "  You are root. Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
else
	echo "[ok]"
fi

sleep 0.1
# Before make .vimrc, make sure you have a python-dev.
echo -n "Check python-dev installed ... "
dpkg -L python-dev >/dev/null 2>&1
if [ $(echo $?) -eq 0 ];
then
	echo [ok]
else
	echo ""
	echo "  You have to install python-dev."
	echo -n "  Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			sudo apt-get --assume-yes install python-dev >/dev/null 2>&1 &
			PID=$!
			echo -n "  Download python-dev ...  "
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done
			# Check wget return value
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Download python-dev(apt-get) failed."
				echo "  Abort."
				exit 1
			fi
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
fi

sleep 0.1
# Before make .vimrc, make sure you have a cmake.
echo -n "Check cmake installed ... "
if [ $(command -v cmake) ];
then
	echo [ok]
else
	echo ""
	echo "  Install cmake first."
	echo "  sudo apt-get install cmake"
	echo "  Abort."
	exit 1
fi

sleep 0.1
# Check git installed.
echo -n "Check git installed ... "
if [ $(command -v git) ];
then
	echo [ok]
else
	echo ""
	echo "  Install git first."
	echo "  sudo apt-get install git"
	echo "  Abort."
	exit 1
fi

sleep 0.1
# For python complete, we need jedi and pip.
echo -n "Check pip installed ... "
if [ $(command -v pip) ];
then
	echo [ok]
else
	echo ""
	echo "  Install pip first."
	echo "  Abort."
	exit 1
fi

sleep 0.1
echo -n "Check Jedi installed ... "
pip show jedi | grep jedi >/dev/null 2>&1
if [ $(echo $?) -eq 0 ];
then
	echo [ok]
else
	echo ""
	echo "  Install jedi."
	echo "  pip install jedi"
	echo "  Abort."
	exit 1
fi

sleep 0.1
# Before make .vimrc, make sure you have vim.
echo -n "Check vim installed ... "
if [ $(command -v vim) ];
then
	echo [ok]
else
	echo ""
	echo "  Install vim first."
	echo "  sudo apt-get install vim"
	echo "  Abort."
	exit 1
fi
#$(command -v vim >/dev/null 2>&1 || { echo >&2 "  Install vim first."; echo >&2 "  Abort."; exit 1; })

sleep 0.1
# Plugin 'YouCompleteMe' requires higher vim version than 7.3
VIMVERSION=$(vim --version | head -1 | grep --only-matching "[0-9]\.[0-9]")
echo -n "Check vim version ... "
if [ $(echo "$VIMVERSION > 7.3" | bc) -eq 1 ];
then
	echo "[ok]"
else
	echo "[err]"
	echo "  Your vim version is $VIMVERSION"
	echo "  The plugin 'YouCompleteMe' requires higher vim version than 7.3"
	echo "  Abort."
	exit 1
fi

sleep 0.1
# Plugin 'Ultisnips' requires vim which compiled with +conceal flag.
VIMFLAG=$(vim --version | grep --only-matching "[+-]conceal " | cut -c 1)
echo -n "Check vim compiled with +conceal flag ... "
if [ $VIMFLAG = '+' ];
then
	echo "[ok]"
else
	echo "[err]"
	echo "  The plugin 'Ultisnips' requires vim compiled with +conceal flag."
	echo "  Abort."
	exit 1
fi

sleep 0.1
# Python autocomplete engine 'Jedi' requires vim which compiled with +python flag.
VIMFLAG=$(vim --version | grep --only-matching "[+-]python " | cut -c 1)
echo -n "Check vim compiled with +python flag ... "
if [ $VIMFLAG = '+' ];
then
	echo "[ok]"
else
	echo "[err]"
	echo "  Python autocomplete engine 'Jedi' requires vim compiled with +python flag."
	echo "  Abort."
	exit 1
fi

sleep 0.1
# Check Molokai theme
echo -n "Check Molokai theme ... "
VIMVERSION=$(echo $VIMVERSION | cut -c 1,3) 
if [ -e /usr/share/vim/vim$VIMVERSION/colors/molokai.vim ];
then
	echo "[ok]"
else
	echo ""
	echo "  For access directory /usr/share/vim.. ,"
	echo -n "  We need root passwd. Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			PID=$(sudo wget -b -O /usr/share/vim/vim74/colors/molokai.vim https://raw.github.com/tomasr/molokai/master/colors/molokai.vim --no-check-certificate | head -1 | grep --only-matching [0-9]*)
			echo -n "  Download Molokai theme ...  "
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done
			# Check wget return value
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Download vundle(wget) failed."
				echo "  Abort."
				exit 1
			fi
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
fi

sleep 0.1
# To prevent lost old .vimrc file, ask to make backup file.
echo "Copy new .vimrc file ... "
if [ -e $HOME/.vimrc ];
then
	echo "  You already have your own .vimrc file : $HOME/.vimrc"
	echo "  Press b if you want to backup."
        echo -n "  Do you want to continue? [y/n/b] "
	read ANSWER
	case $ANSWER in
		y|Y)
			#$(test -w $HOME/.vimrc)
			#if [ $(echo $?) = 0 ];
			if [ -w $HOME/.vimrc ];
			then
				$(cp .vimrc $HOME/.vimrc)
				echo "  Copy vimrc to $HOME/.vimrc"
			else
				echo "  Cannot access $HOME/.vimrc"
				echo "  Abort."
				exit 1
			fi
			;;
		b|B)
			#$(test -w $HOME/.vimrc)
			#if [ $(echo $?) = 0 ];
			if [ -w $HOME/.vimrc ];
			then
				$(cp $HOME/.vimrc ./vimrc.bak)
				$(cp .vimrc $HOME/.vimrc)
				echo "  Create backup file $PWD/vimrc.bak"
				echo "  Copy vimrc to $HOME/.vimrc"
			else
				echo "  Cannot access $HOME/.vimrc"
				echo "  Abort."
				exit 1
			fi
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
else
	$(cp .vimrc $HOME/.vimrc)
	echo "  Copy vimrc to $HOME/.vimrc"
fi

sleep 0.1
echo -n "Check old config ... "
if [ -d "$HOME/.vim" ] && [ -d "$HOME/.vim/bundle" ];
then
	echo ""
	echo "  You already have your own vundle and plugins."
	echo -n "  Do you want to remove all(Clean Install)? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			$(rm -rf $HOME/.vim/bundle)
			$(mkdir -p $HOME/.vim/bundle)

			sleep 0.1
			# Downloads vundle
			echo -n "Download vundle ...  "
			git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim >/dev/null 2>&1 &
			PID=$!
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done
			# Check wget return value
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Download vundle(git) failed."
				echo "  Abort."
				exit 1
			fi
			;;
		*)
			;;
	esac
else
	echo "[ok]"
fi

sleep 0.1
echo -n "Check YouCompleteMe installed ... "
if [ -d "$HOME/.vim/bundle/YouCompleteMe" ];
then
	echo ""
	echo "  You already have your own YouCompleteMe."
	echo -n "  Do you want to remove old YouCompleteMe? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			$(rm -rf $HOME/.vim/bundle/YouCompleteMe)
			sleep 0.1
			# Downloads YouCompleteMe
			echo -n "Download plugin 'YouCompleteMe' ...  "
			git clone https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe >/dev/null 2>&1 &
			PID=$!
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done

			# Check wget return value
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Download YouCompleteMe(git) failed."
				echo "  Abort."
				exit 1
			fi

			sleep 0.1
			# Install YouCompleteMe
			echo -n "Install YouCompleteMe submodule ...  "
			git -C $HOME/.vim/bundle/YouCompleteMe submodule update --init --recursive >/dev/null 2>&1 &
			PID=$!
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Install YouCompleteMe submodule failed."
				echo "  Abort"
				exit 1
			fi

			sleep 0.1
			# Compile YouCompleteMe
			echo -n "Compile YouCompleteMe ...  "
			$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer >/dev/null 2>&1 &
			PID=$!
			while [ -d "/proc/$PID" ];
			do
				for s in / - \\ \|; do 
					printf "\b$s";
					sleep .1;
				done
			done
			if [ $? -eq 0 ];
			then
				printf "\b[ok]\n"
			else
				echo ""
				echo "  Compile YouCompleteMe failed."
				echo "  Abort"
				exit 1
			fi
			;;
		*)
			;;
	esac
else
	sleep 0.1
	# Downloads YouCompleteMe
	echo -n "Download plugin 'YouCompleteMe' ...  "
	git clone https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe >/dev/null 2>&1 &
	PID=$!
	while [ -d "/proc/$PID" ];
	do
		for s in / - \\ \|; do 
			printf "\b$s";
			sleep .1;
		done
	done

	# Check wget return value
	if [ $? -eq 0 ];
	then
		printf "\b[ok]\n"
	else
		echo ""
		echo "  Download YouCompleteMe(git) failed."
		echo "  Abort."
		exit 1
	fi

	sleep 0.1
	# Install YouCompleteMe
	echo -n "Install YouCompleteMe submodule ...  "
	git -C $HOME/.vim/bundle/YouCompleteMe submodule update --init --recursive >/dev/null 2>&1 &
	PID=$!
	while [ -d "/proc/$PID" ];
	do
		for s in / - \\ \|; do 
			printf "\b$s";
			sleep .1;
		done
	done
	if [ $? -eq 0 ];
	then
		printf "\b[ok]\n"
	else
		echo ""
		echo "  Install YouCompleteMe submodule failed."
		echo "  Abort"
		exit 1
	fi

	sleep 0.1
	# Compile YouCompleteMe
	echo -n "Compile YouCompleteMe ...  "
	$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer >/dev/null 2>&1 &
	PID=$!
	while [ -d "/proc/$PID" ];
	do
		for s in / - \\ \|; do 
			printf "\b$s";
			sleep .1;
		done
	done
	if [ $? -eq 0 ];
	then
		printf "\b[ok]\n"
	else
		echo ""
		echo "  Compile YouCompleteMe failed."
		echo "  Abort"
		exit 1
	fi
fi

sleep 0.1
echo "BundleInstall ... "
echo "  Now all downloads are finished. Stay here and check out"
echo "  all plugins are installed well. [Click any]"
read ANSWER
vim +BundleInstall +qall

echo "Install TEAM SAVE's vimrc v0.1 finished!"
echo ""

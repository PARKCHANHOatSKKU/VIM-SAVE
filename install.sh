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


# We recommend to setting vimrc file on your own account.
if [ $UID = 0 ];
then
	echo -n "  You are root. Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
fi

# Before make .vimrc, make sure you have vim.
$(command -v vim >/dev/null 2>&1 || { echo >&2 "  Install vim first."; echo >&2 "  Abort."; exit 1; })

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
# To prevent lost old .vimrc file, ask to make backup file.
if [ -e $HOME/.vimrc ];
then
	echo "  You already have your own .vimrc file : $HOME/.vimrc"
	echo "  Press b to backup. Do you want to continue? [y/n/b] "
else
	echo "not"
fi
echo $HOME

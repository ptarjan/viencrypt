#!/bin/sh
filename="passwords.gpg"
if [ $EDITOR ]
then
    editor=$EDITOR
elif [ -f /usr/bin/editor ]
then
    editor=/usr/bin/editor
else
    editor=vi
fi

if [ $# = 0 ] 
then
    echo "No filename specified. Using default $filename"
elif [ $# > 1 ]
then
    echo "$0 [filename.gpg]"
    exit 2
fi

tmp=`mktemp` || exit 1

# don't show typing
stty -echo
read -p "Password: " passw; echo
stty echo

if [ ! -f $filename ]
then 
    echo "$filename doesn't exist. Starting from empty file."
elif [ ! -w $filename ]
then
    echo "$filename isn't writable."
    exit 1
else
    # decrypt into the tmp file
    echo "$passw" | gpg -q -d --passphrase-fd 0 $filename > $tmp
    if [ $? != 0 ]; then
        # if gpg didn't work, exit
        rm $tmp
        exit $?;
    fi
fi

$editor $tmp
echo "$passw" | gpg -q -c --passphrase-fd 0 --output $filename $tmp
rm $tmp
if [ $? != 0 ]; then
    # if gpg didn't work, exit
    exit $?;
fi

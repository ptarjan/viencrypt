# A simple script for editing encrypted files

This script simply decrypts the file into a file readable only by you, you edit it in your favorite editor, and then it re-encrypts it and saves the file back where it came from.

I use this to keep track of my web passwords.

Usage : 

    $ ./encryptvi 
    No filename specified. Using default passwords.gpg
    passwords.gpg doesn't exist. Starting from empty file.
    Password: 
    <editor pops up and you edit your file. Once you exit it saves it encrypted>

or for any other file

    $ ./encryptvi my.love.notes
    Password:
    <editor pops up and you edit your file. Once you exit it saves it encrypted>
    
To change your editor (in bash) :

    $ export EDITOR=pico
    $ ./encryptvi
    <now pico pops up>

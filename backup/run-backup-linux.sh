#!/bin/bash

############################################################
# Help                                                     #
############################################################

function help()
{
  # Display Help
  echo "Usage: $0 [OPTION]... [PATH]..."
  echo "options:"
  echo "-e     Encrypt your data."
  echo "-d     Decrypt your data."
  echo
  echo "Example:"
  echo "$0 -e /tmp/datatobackup       Encryption data from path /tmp/datatobackup."
  echo "$0 -d /tmp/datatobackup       Decryption data from path /tmp/datatobackup."
  echo
}

#Parse options
while getopts 'd:e:h' option; do
  case $option in
    e) #Encrypt data
       eflag=1
       evalue=$OPTARG
       ;;
    d) #Decrypt data
       dflag=1
       dvalue=$OPTARG
       ;;
    h) #Show help
       help
       exit;;
  esac
done
shift $(($OPTIND -1))

############################################################
# Encrypt                                                  #
############################################################

function encrypt() {

  #Local variables
  local PATH_TO_EDATA=$evalue
  local BACKUP_NAME="Backup_$(date +'%Y-%m-%d')_$PATH_TO_EDATA"
  local PATH_TO_EDATA_ENCRYPT="$PATH_TO_EDATA.enc"

  #Check if the directory or file exists before encrypting
  if [[ -d $PATH_TO_EDATA || -f $PATH_TO_EDATA ]]; then

    #Compres files 
    echo "===== Data compression $PATH_TO_EDATA has started... "
    tar -czf $PATH_TO_EDATA.tar.gz $PATH_TO_EDATA

    #Encrypt files
    echo "===== Encryption $PATH_TO_EDATA has started... "
    read -s -p "Enter the password to encrypt your data: " PASSWORD
    openssl enc -in $PATH_TO_EDATA.tar.gz -out $PATH_TO_EDATA_ENCRYPT -e -aes256 -pass "pass:${PASSWORD}" -pbkdf2
    echo "===== Your data was encrypted. Path to file $(pwd)/$PATH_TO_EDATA_ENCRYPT"

    #Clean
    rm -f $PATH_TO_EDATA.tar.gz

  else
    echo "$PATH_TO_EDATA not found... Please try again!"
  fi
}

############################################################
# Decrypt                                                  #
############################################################

function decrypt() {

  #Local variables
  local PATH_TO_DDATA=$dvalue
  local PATH_TO_DDATA_DECRYPT="$PATH_TO_DDATA.tar.gz"

  #Check if the file exists before decrypting
  if [ -f $PATH_TO_DDATA ]; then

    #Decrypt files
    read -s -p "Enter the password to encrypt your data: " PASSWORD
    if openssl enc -in $PATH_TO_DDATA -out $PATH_TO_DDATA_DECRYPT -d -aes256 -pass "pass:${PASSWORD}" -pbkdf2 &>/dev/null; then

      echo "====== $PATH_TO_DDATA was decrypted. Path to file $(pwd)/$PATH_TO_DDATA_DECRYPT"
      echo "===== Data extract $PATH_TO_DDATA has started... "
      tar -xzf $PATH_TO_DDATA_DECRYPT
      echo "===== Done. "

      #Clean
      rm -f $PATH_TO_DDATA_DECRYPT
    else
      echo "Bad password... Please try again!"
      rm -f $PATH_TO_DDATA_DECRYPT
    fi
    
    
  else
    echo "$PATH_TO_DDATA not found... Please try again!"
  fi
}

############################################################
# Execute script                                           #
############################################################

if [ ! -z "$dflag" ]; then
    decrypt
elif [ ! -z "$eflag" ]; then   
    encrypt
fi

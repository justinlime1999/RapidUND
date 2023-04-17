#!/bin/sh

sudo systemctl stop und

#Genesis
mkdir -p $HOME/tmp && cd $HOME/tmp
wget https://github.com/unification-com/mainchain/releases/download/1.5.1/und_v1.5.1_linux_x86_64.tar.gz
tar -zxvf und_v1.5.1_linux_x86_64.tar.gz
mkdir -p $HOME/.und_mainchain/cosmovisor/genesis/bin
mv und $HOME/.und_mainchain/cosmovisor/genesis/bin
rm -rf $HOME/tmp

#Current
mkdir -p $HOME/tmp && cd $HOME/tmp
wget https://github.com/unification-com/mainchain/releases/download/v1.6.3/und_v1.6.3_linux_x86_64.tar.gz
tar -zxvf und_v1.6.3_linux_x86_64.tar.gz
mkdir -p $HOME/.und_mainchain/cosmovisor/upgrades/1-init_ibc/bin
mv und $HOME/.und_mainchain/cosmovisor/upgrades/1-init_ibc/bin
rm -rf $HOME/tmp

#Upgrade
mkdir -p $HOME/tmp && cd $HOME/tmp
wget https://github.com/unification-com/mainchain/releases/download/v1.7.0/und_v1.7.0_linux_x86_64.tar.gz
tar -zxvf und_v1.7.0_linux_x86_64.tar.gz
mkdir -p $HOME/.und_mainchain/cosmovisor/upgrades/2-grog/bin
mv und $HOME/.und_mainchain/cosmovisor/upgrades/2-grog/bin
rm -rf $HOME/tmp

rm -rf $HOME/.und_mainchain/cosmovisor/current
ln -s $HOME/.und_mainchain/cosmovisor/upgrades/1-init_ibc/bin $HOME/.und_mainchain/cosmovisor/current

echo "Genesis:"
$HOME/.und_mainchain/cosmovisor/genesis/bin/und version --log_level=""

echo "Current:"
$HOME/.und_mainchain/current/und version --log_level=""

echo "Upgrade:"
$HOME/.und_mainchain/cosmovisor/upgrades/2-grog/bin/und version --log_level=""

sudo systemctl restart und
sleep 10
sudo journalctl -u und -f -o cat





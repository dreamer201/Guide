## Preperation

1. Get a VPS from a provider like DigitalOcean, Vultr, Linode, etc. 
   - Recommended VPS size at least 1gb RAM 
   - **It must be Ubuntu 16.04 (Xenial)**
2. Make sure you have a transaction of exactly 1000 POLIS in your desktop cold wallet.

## Cold Wallet Setup Part 1

1. Open your wallet on your desktop.

   Click Settings -> Options -> Wallet
   Check "Enable coin control features"
   Check "Show Masternodes Tab"
   Press Ok (you will need to restart the wallet)
   
   
2. Go to the tab at the bottom that says "Tools"
3. Go to the tab at the top that says "Console"
4. Run the following command: `masternode genkey`
5. You should see a long key that looks like:
```
73HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg
```
6. This is your `private key`, keep it safe, do not share with anyone.




## VPS Setup

1. Log into your VPS
   - Windows users [follow this guide](https://www.digitalocean.com/community/tutorials/how-to-log-into-your-droplet-with-putty-for-windows-users) to log into your VPS.
2. Copy command into the VPS command line and hit enter:
```
wget https://github.com/digitalmine/Guide/blob/master/install_masternode.sh && chmod +x install_masternode.sh && ./install_masternode.sh
```
3. When prompted, enter your private key from before.
4. You will be asked for your VPS IP and a few other questions.
5. The installation should finish successfully. 



## Cold Wallet Setup Part 2

1. Open your wallet on your desktop.
2. Go to the tab at the bottom that says "Tools"
3. Go to the tab at the top that says "Console"
4. Run the following command: `masternode outputs`
5. You should see output like the following if you have a transaction with exactly 1000 POLIS:
```
{
    "12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx": "0"
}
```
6. The value on the left is your `txid` and the right is the `vout`
7. Go the the tab at the bottom that says "Settings"
8. Click "Open Masternode Configuration File"
9. Add a line to the bottom of the file using the VPS IP (with port 24126), `private key`, `txid` and `vout`:
```
mn1 1.2.3.4:24126 7xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 0 
```
10. Save the file, exit your wallet and reopen your wallet.
11. Go to the tab at the bottom that says "Tools"
12. Go to the tab at the top that says "Console"
13. Run the command:
```
masternode start-alias mn1
```

Congratulations, your setup should now be complete! [Ask for help in discord](https://discord.gg/zQcPK9G) if you need.

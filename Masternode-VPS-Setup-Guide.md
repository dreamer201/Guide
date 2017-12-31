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
   
   ![Alt text](https://github.com/digitalmine/Guide/blob/master/poliswalletsettings.png "Wallet Settings")

   
   
   
2. Go to the "Tools" -> "Debug console"
3. Run the following command: `masternode genkey`
4. You should see a long key that looks like:
```
3HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg
```
5. This is your `private key`, keep it safe, do not share with anyone.




## VPS Setup

This installation takes on a bit different approach. Instead of using `systemd` it relies on `monit`

1. Log into your VPS (Windows users [follow this guide](https://www.digitalocean.com/community/tutorials/how-to-log-into-your-droplet-with-putty-for-windows-users) to log into your VPS.)

    1A. Add new user whose name is masternode and add him/her to sudoers.
        You'll be ask for a new password for this user and you have to type
        it in twice. Keep the password safe as you'll need it to operate MN.
        `adduser masternode && adduser masternode sudo`
        
        1B. Log in as a user masternode
     
     `# su masternode`
     
     1C. Change to masternode's home directory
     
     `$ cd ~/`
     
2. Copy/paste command into the VPS and hit enter: (For this step you will need your `private key` 
   generated at step 5 above and your VPS IP address)
```
$ wget https://raw.githubusercontent.com/digitalmine/Guide/master/install_masternode.sh && chmod +x install_masternode.sh && ./install_masternode.sh
```
3. When prompted, enter your private key from before.
4. You will be asked for your VPS IP and a few other questions.
5. The installation process should follow on. You may need to input sudo password for user `masternode`
   now and then, or hit enter when prompted.
6. When it's finished you have to configure monit. Type in:

`$ sudo nano /etc/monit/monitrc`

and the VERY BOTTOM of this file paste this:

```
### added on setup for polisd
set httpd port 2812
use address localhost # only accept connection from localhost 
allow localhost # allow localhost to connect to the server
###
### polisd process control
check process polisd with pidfile /home/masternode/.poliscore/polisd.pid
start program = "/home/masternode/polis_node.sh start" with timeout 60 seconds
stop program = "/home/masternode/polis_node.sh stop"
```

safe and exit the file (`ctrl+o`, then hit enter and then `ctrl+x`)

Now load new configuration for monit:

`$ sudo monit reload`

and enable monitoring service

`$ sudo monit start polisd`

Now your `polisd` should be monitored by `monit`. Type in the following to check it:

`$ sudo monit status`

The whole thing will keep the `polisd` running. If you really want to stop `polisd` then use `$ sudo monit stop polisd`.

7.Use `$ polis-cli getinfo` to check and wait til it's synced

  (look for blocks number and compare with block explorer http://explorer.polispay.org/insight/ )


## Cold Wallet Setup Part 2 

1. On your local machine open your `masternode.conf` file.
   Depending on your operating system you will find it in:
   * Windows: `%APPDATA%\polisCore\`
   * Mac OS: `~/Library/Application Support/polisCore/`
   * Unix/Linux: `~/.poliscore/`
   
   Leave the file open
2. Go to "Tools" -> "Debug console"
3. Run the following command: `masternode outputs`
4. You should see output like the following if you have a transaction with exactly 1000 POLIS:
```
{
    "12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx": "0"
}
```
5. The value on the left is your `txid` and the right is the `vout`
6. Add a line to the bottom of the already opened `masternode.conf` file using the IP of your
VPS (with port 24126), `private key`, `txid` and `vout`:
```
mn1 1.2.3.4:24126 3xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 0 
```
7. Save the file, exit your wallet and reopen your wallet.
8. Go to the "Masternodes" tab
9. Click "Start All"
10. You will see "WATCHDOG_EXPIRED". Just wait few minutes

Congratulations, your setup should now be complete! If you did like it, you can buy me
a cup of coffee PBNTK2AApqLETnSkL4pNq1XaMjJnTySt8j

Cheers !

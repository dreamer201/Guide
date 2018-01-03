# How to update your VPS from v 1.1.0 to 1.2.0


1. `cd ~/ && sudo monit status polisd`
   If you followed earlier my Setup Guide you should get:
   
   
   ![Alt text](https://github.com/digitalmine/Guide/blob/master/Screenshot_2018-01-03_08-18-48.png)
   
2. Now stop your MN `sudo monit stop polisd`
3. Download new version
   `wget https://github.com/polispay/polis/releases/download/v1.2.0/poliscore-1.2.0-linux.zip`
4. Unpack it `unzip ~/poliscore-1.2.0-linux.zip`
5. Copy new polisd and polis-cli to /usr/bin
   `sudo cp ~/poliscore-1.2.0-linux/usr/local/bin/polis{d,-cli} /usr/bin`
6. Run your MN `sudo monit start polisd`

    That's all. Cheers !
    
    Tip jar PBNTK2AApqLETnSkL4pNq1XaMjJnTySt8j
    


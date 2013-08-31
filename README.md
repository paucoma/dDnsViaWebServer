## Dynamic DNS via web server, vbScript and Task Scheduler

A couple scripts in php and vbScript along with a couple setup instructions
to setup an automatic dynamic domain name server updating system.

This project contains:
- php code 
- vbScript code
- setup Instructions and references

## Requirements
- Webserver that runs php
- API key that can access dns-* methods
- host name for the domain name
- windows OS that can run Visual Basic Scripts
- Task Scheduler on Windows OS

## Code Example

Once setup the vbScript makes an HTTP request to

http://mydomain.com/myscript.php?host=<hostname to update>&passwd=<authentification>&ip=<ip address to update from>


## Motivation

Originally the Dynamic DNS updating was performed by DynDNS service which was free of charge.
Since they moved onto a payment model the account associated to the address being updated was deleted.
This motivated the creation of a self maintained Dynamic DNS service using web hosting at dreamhost that was being paid for anyway.

## Installation

- Create an **API Key** with Function Access ** dns-(asterix) ** this includes All dns functions
+ dns-add_record
+ dns-list_records
+ dns-remove_record

- Add a **custom DNS record** with the hostname that you wish
+ Type: **A**
+ Value: any IP address as we will update this

- Install and configure the php script on your webserver. Following instructions at [Dreamhost Wiki](http://wiki.dreamhost.com/Dynamic_DNS)
- ssh into your webspace
- goto a web accessible directory and download the php script dyndns.php
- change the access rights and modify the script to include your
+ '$DH_API_KEY', setting the value to the API key given
+ '$HOSTS' to limit it to only the dns entries you wish to allow modification to
+ '$PASSWD' to protect this page

- Download and configure the vbscript to the computer in the network you want to update the host domain name from

- Setup a repetitive task with the windows task scheduler to call this script.

All done.

## API Reference

* [Dreamhost Wiki on Dynamic DNS](http://wiki.dreamhost.com/Dynamic_DNS)
* [How to Schedule Tasks in Windows XP](http://support.microsoft.com/kb/308569)
* [Http GET in vbScript](http://stackoverflow.com/questions/204759/http-get-in-vbs)

## Tests

* Server Side setup only test
* With the API Key, the hostname reserved and the php script downloaded and configured you can manually test the update.
* Open a webbrowser and open the following url

* http://mydomain.com/dyndns.php?host=<hostname to update>&passwd=<authentification>&ip=<ip address to update from>
* You should see the result.

## Contributors

Any suggestions to improvements are welcome. I must say this is just a quick mock up but works fine.

## License

The php script is found through dreamhost wiki [here](http://smoser.brickies.net/git/?p=dreamhost-tools.git;a=blob;f=dh-dyndns.php). I only have a copy of it here for backup purposes and for completeness of the required scripts.
Fell free to use the script as you wish.

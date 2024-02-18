title:🕵️ Awesome Steganography
date: 2024-02-16 00:30
tags: projects
summary: Awesome tools for Steganography
---
Awesome Tools for Steganography 🕵️
---
_Para o tutorial em português clique [aqui 🇧🇷](https://github.com/cristiancmoises/awesome-steganography/blob/main/Leia-me.md)_
# Table Of Contents
![st](/images/st.png)

* [`Introduction`](##Steganography?)
* [`Hidden with GUI`](#Stegoshare)
* [`Hidden with TCP`](#Steganoroute)
* [`Low file size`](#Snow)
* [`Popular Tool`](#Steghide)
  
## Steganography?
> Steganography is the art and science of writing hidden messages in such a way that no-one apart from the sender and intended recipient even realizes there is a hidden message.By contrast, cryptography obscures the meaning of a message, but it does not conceal the fact that there is a message. Today, the term steganography includes the concealment of digital information within computer files. For example, the sender might start with an ordinary-looking image file, then adjust the color of every 100th pixel to correspond to a letter in the alphabet—a change so subtle that someone who isn't actively looking for it is unlikely to notice it.
The larger the cover message is (in data content terms—number of bits) relative to the hidden message, the easier it is to hide the letter.
Stated somewhat more formally, the objective for making steganographic encoding difficult to detect is to ensure that the changes to the carrier (the original signal) due to the injection of the payload (the signal to covertly embed) are visually (and ideally, statistically) negligible; that is to say, the changes are indistinguishable from the noise floor of the carrier.
For this reason, digital pictures (which contain large amounts of data) are used to hide messages on the Internet and on other communication media. For example: a 24-bit bitmap will have 8 bits representing each of the three color values (red, green, and blue) at each pixel. If we consider just the blue there will be 28 different values of blue. The difference between 11111111 and 11111110 in the value for blue intensity is likely to be undetectable by the human eye. Therefore, the least significant bit can be used (more or less undetectably) for something else other than color information. If we do it with the green and the red as well we can get one letter of ASCII text for every three pixels. 

# Stegoshare:
![stegoshare](/images/stegoshare.png)

The program uses 3 least significant bits (LSB) for red and blue channels and 2 LSB for the green channel. Using lossless compression (PNG), StegoShare provides about 40% capacity (in the 250Mb images you can hide 100Mb file). 
Visually images looks that there are no any files embedded, human eye cannot detect the difference. 
128-bit encryption makes detecting hidden file more difficult.
## Features
> Simple and easy to use
> Works on any platform that runs Java                                                             
### Running:
    apt install wget openjdk-8-jdk openjdk-8-jre
    wget http://downloads.sourceforge.net/stegoshare/StegoShare.jar
    java -jar StegoShare.jar
### On Gentoo:
    emerge openjdk
    emerge jre
    wget http://downloads.sourceforge.net/stegoshare/StegoShare.jar
    java -jar StegoShare.jar

# Steganoroute:
![stegnoroute](/images/stegroute.png)

Is a tool to send steganographed text messages to another computer over the network. The receiver must make a traceroute to the sender using the mtr program (and pressing d once to switch the display mode to the continuous graph). 
This tool, the sender, creates several fake hops and makes them answer the ICMP packets (or not) to write the letters one by one on the mtr client screen.
## Features                                                                                           
> It can print upper and lower-case letters.                                                      
> It can print in normal or color-inverse mode.                                                    
> It can loop forever.                                                                              
> It should work on your own localhost computer, on your LAN and over the Internet.                
> Is uses the Sinclair ZX Spectrum (1982) font.                                                    
> You can select the TTL value on demand and therefore 'move' the text up and down the mtr graph.  
#### Warning! _You can filter the IP address that should receive the traceroute. If you don't filter it, every traceroute coming out of the server will mysteriously add fake hops to any destination!You can feel the sensation of being MITMed by the top intelligence organizations in the world by using the conspiracy mode!

##  Running:
    apt install git mtr python3 python-scapy
    git clone https://github.com/stratosphereips/steganoroute.git
    cd ./steganoroute
    iptables -I INPUT -p icmp --icmp-type 8 -j DROP
    python3 ./steganoroute.py -i lo -m "MATRIX has You!" -l
    mtr -t yourlocalLANip
_*MTR command used to list the message_
### On Gentoo:
    emerge mtr 
    emerge python 
    emerge scapy
    git clone https://github.com/stratosphereips/steganoroute.git
    cd ./steganoroute
    iptables -I INPUT -p icmp --icmp-type 8 -j DROP
    python3 ./steganoroute.py -i lo -m "MATRIX has You!" -l
    mtr -t yourlocalLANip
_*MTR command used to list the message_

# Snow: 
![Snow](/images/snow.png)

A lightweight tool that uses whitespace and tabs to hide information inside text files. Unlike other steganographic tools, snow does not rely on binary formats to encode secret data. This can be incredibly useful in cases where it is not possible to share large binary files.
## Features
> Produces small files
> Output text can be used on any program that accepts plain text                                  
### Running:
    apt install stegsnow
    stegsnow -C -m "Encrypted Message Here" -p "angrypassword" infile outfile 
    stegsnow -C -p "angrypassword" outfile
### On Gentoo:
    wget https://darkside.com.au/snow/snow.zip
    unzip snow.zip
    cd snow 
    make
    cp snow /bin/
    snow -C -m "Encrypted Message Here" -p "angrypassword" infile outfile
    snow -C -p "angrypassword" outfile

# Steghide   
![steghide](/images/steghide.png)
One of the most popular steganographic tools today. 
It is a simple command line program that encodes text inside images. Steghide works by creating a random list of bits inside your dummy file and inserts your secret data in between those bits.
## Features     
> Quick and easy to use                          
> Uses checksums to verify the integrity of data 
### Running:  
    apt install steghide
    cd steghide
    steghide embed -ef topsecretfile.txt -cf photo.jpg -sf photoX.jpg
    steghide extract –sf photoX.jpg
### On Gentoo:
    wget https://ufpr.dl.sourceforge.net/project/steghide/steghide/0.5.1/steghide-0.5.1.zip
    cd steghide
    ./configure 
    make
    make check
    make install 
    steghide embed -ef topsecretfile.txt -cf photo.jpg -sf photoX.jpg
    steghide extract –sf photoX.jpg

![stego](/images/steg.gif)

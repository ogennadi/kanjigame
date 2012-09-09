Kanji Game
==========
This game is like Boggle but with Japanese Kanji. You can see it in action at http://koggle.net .

Installation
------------
This is a Rails app so you need Ruby 1.9+ and PostgreSQL to run it.

- Clone the source and enter the directory
  
    git clone git://github.com/ogennadi/kanjigame.git
    cd kanjigame

- Download and uncompress the Japanese dictionary (~9M) into the root directory
  
    curl -O ftp://ftp.monash.edu.au/pub/nihongo/JMdict.gz
    gunzip JMdict.gz
  
- Setup the database and fill it with words. N.B. on my Core i3 laptop with 4GB RAM, it took about 30 minutes to fully load the data.

    rake db:setup
    rake game:slurpdict  # this is the long part
    rake game:slurpn5

- Generate the game static files. This takes about 15 mins
 
    rake game:generate 

- Now start your Web server and play!

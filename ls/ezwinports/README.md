ezwinports all in one

[http://www.nextpoint.se/?p=699]

Ezwinports project brings us native ports of some standard Unix applicatons. It attempts to continue where GnuWin32 (or is the name GnuWin?) has left. GnuWin has not been updated for over 3 years now, so it seems like it is not maintained any more. Ezwinports attempts to keep at least some of them updated. It seem to be a work of mainly one person, so I have to say it is quite impressive how many applications are included and maintained. Kudos to maintainer(s).

Since ezwinports contains many updated applications from Gnuwin32, I decided to download them all. But since there are so many, one can¡¯t go browse to Sourceforge and download each and every manually, by clicking on link, downloading them, unzipping and so on. It would take forever. Actually there is no need to have them all at once, but even if you are getting just few you still have to do quite some manual work. Furthermore, at some point you will probably like to get one or another more, so it is equally good just to get them all for once.

Instead you can use wget to download them in bulk and a simple batch file to decompress them all to installation folder. If you don¡¯t have wget, get it from ezwinports. Install it somewhere by simply unzipping it.

To be able to download ezwinports apps, we need a list of valid URLs for each of them. I don¡¯t think there is one, but I really don¡¯t know. I have simply copied webpage in my browser and pasted the content into Emacs. Then witg few regexps I got blurb of names to transform into a list of downloadable links to pass to wget. Actually it took only few minutes to get everything sorted out. I am quite surprised since I really hate working with regexps and trying to avoid them as much as I can.

For those of you who prefer to spend your time on something more fun tha regular expressions, here is list of downloadable links.

Pass it to wget with ¨Ccontent-disposition and ¨Ctrust-server-names to get your downloaded files with their real names, otherwise all files will be named ¡°download.1¡±, ¡°download.2¡± ¡­ and so on.

Here is my comandline:

wget --content-disposition --trust-server-names -i ezwinports.txt
(I saved my list to ezwinports.txt).

Once wget is done you will have to install them. Installation means just to unzip them into some folder and add that folder to your system PATH. I have 7zip installed on my computer so I have written simple batch script to loop though all files and decompress them to a folder (I put everything into c://gnu):
    
    for %i in (*.zip) do 7z x %i -oc://gnu -aoa
    
Finally add bin folder to your PATH, I suggest before gnuwin32 binaries if you have those in your path too. Presumably this will work nicely with older Gnuwin32 binaries.

By the way, what about updating? Well I have not got there yet. I guess one could get Sourceforge page with list of files, parse html file and compare names from that list with new ones. If there are new version fire up wget, get new one and decompress file to its place. An Emacs script seems perfect for that job .
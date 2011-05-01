StarLoader
==========


What's this?

This is a dylib loader for the OpenStar Project.
It includes an hooking library, and it's pretty fast.

How to Use:

You can find an example of this in our TweetPwn repository.

Benefits:

* It's really fast!
* Modular
* Easy to use!
* ThinLoader can exclude unsupported apps like Skype.
* Allows full objc hooking
* Allows hooking of dynamically linked C functions.

Installing a precompiled version
=================================

Download http://d.pr/kHD4 and install StarLoader_INSTALLER.pkg.
Enjoy.

Building
==========
To build StarLoader, simply move into its directory and run these commands:

	make
	make install

After this, the loader is already injected so there's no need to log out and log in anymore.

Enjoy.


Credits
=======

* qwertyoruiop: actual implementation of the code
* gianguido: some makefile and scripts modding. great work!
* squiffypwn, nerd, jannf et. al: moral support on IRC =P (thanks guys!)
* liamchat: for annoying me. (added by ComingWinter)

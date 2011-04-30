FILES=Loader.m libStar.m
NAME=Loader.dylib
CC=g++
FLAGS=-o $(NAME) -dynamiclib -arch i386 -arch x86_64 -fobjc-gc -framework Foundation -lobjc -fno-exceptions
main:
	@echo "Compiling and linking..."
	@$(CC) $(FLAGS) $(FILES)
install:
	@mkdir ~/.MacOSX &>/dev/null || :
	@cp Loader.dylib ~/.MacOSX
	@cp environment.plist ~/.MacOSX
	@launchctl setenv DYLD_INSERT_LIBRARIES $(HOME)/.MacOSX/Loader.dylib
	@echo "Done and injected the loader."
all: main install

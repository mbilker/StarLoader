FILES=Loader.m libStar.m
NAME=Loader.dylib
CC=g++
FLAGS=-o $(NAME) -dynamiclib -arch i386 -arch x86_64 -fobjc-gc -framework Foundation -lobjc -fno-exceptions
main:
	@echo "Compiling and linking Loader..."
	@$(CC) $(FLAGS) $(FILES)
	@cd ThinLoader; make
install:
	@mkdir ~/.MacOSX &>/dev/null || :
	@cp Loader.dylib ~/.MacOSX
	@cp ThinLoader/ThinLoader.dylib ~/.MacOSX
	@./envgen.sh
	@launchctl setenv DYLD_INSERT_LIBRARIES $(HOME)/.MacOSX/ThinLoader.dylib
	@echo "Done and injected the loader."
all: main install

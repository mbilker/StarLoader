FILE=Loader.m
NAME=Loader.dylib
CC=g++
FLAGS=-o $(NAME) -dynamiclib -arch i386 -arch x86_64 -fobjc-gc -framework Foundation -lobjc -fno-exceptions
main:
	#@echo "Parsing code..."
	#@./LogosToStar.sh $(FILE) >fix.m
	@echo "Compiling and linking..."
	@$(CC) $(FLAGS) fix.m
clean:
	@echo "Cleaning up..."
	@rm -rf fix.m star.h
install:
	@mkdir ~/.MacOSX &>/dev/null
	@cp Loader.dylib ~/.MacOSX
	@cp environment.plist ~/.MacOSX
	@echo "Done. Logout and enjoy!"

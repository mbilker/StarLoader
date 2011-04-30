FILES=ThinLoader.m
NAME=ThinLoader.dylib
CC=g++
FLAGS=-o $(NAME) -dynamiclib -arch i386 -arch x86_64
main:
	@echo "Compiling and linking ThinLoader..."
	@$(CC) $(FLAGS) $(FILES)
install:
	@cp ThinLoader.dylib ~/.MacOSX

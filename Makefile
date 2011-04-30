FILE=Loader.m
NAME=Loader.dylib
CC=g++
FLAGS=-o $(NAME) -dynamiclib -arch i386 -arch x86_64 -fobjc-gc -framework Foundation -lobjc -fno-exceptions
all:
	@echo "Parsing code..."
	@./LogosToStar.sh $(FILE) >fix.m
	@echo "Compiling and linking..."
	@$(CC) $(FLAGS) $(FILE)
	@echo "Cleaning up..."
	@rm -rf fix.m star.h

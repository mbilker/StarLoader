#include <errno.h>
#include <sys/stat.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdlib.h>
#include <stdio.h>    
#include <pwd.h>
#include <unistd.h>
#include <dlfcn.h>
__attribute__((constructor))
void thinload(){
char* path=malloc(1024);
char* sym=malloc(1024);
int size = 1024;
if (_NSGetExecutablePath(path, &size) != 0)
{
return;
}
{
if(readlink(path, sym, 1024)==-1){
if(errno!=EINVAL){
perror("readlink");
} else {
strcpy(sym, path);
}
}
char* slashname=(sym)+strlen(sym)-6;
printf("Exec: %s\n", slashname);
if(strcmp(slashname, "/Skype")==0){
free(path);
free(sym);
printf("STAR: Aww, skype. Disabling Loader.\n");
return;
} 
}
free(path);
free(sym);
{
printf("STAR: ThinLoader: Loading Loader\n");
char* lib="/.MacOSX/Loader.dylib";
struct passwd* pwd = getpwuid(getuid());
char* path=malloc(strlen(pwd->pw_dir)+strlen(lib));
strcpy(path, pwd->pw_dir);
strcat(path, lib);
printf("STAR: Loading %s\n", path);
if(!dlopen(path, RTLD_NOW)) perror("dlopen");
free(path);
}
}

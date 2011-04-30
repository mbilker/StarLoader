#import <Foundation/Foundation.h>

#import <objc/runtime.h>
@interface Star : NSObject {
}
+(IMP)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl;
+(void)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andOrig:(IMP*)orig;
+(id)hookIvar:(NSString*)name inInstance:(id)inst;
+(BOOL)addSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andType:(NSString*)type;
@end

#define MSHookMessageEx(class, selector, repl, orig) [Star hookSelector:selector inClass:class withImp:repl andOrig:orig]
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
@implementation Star
+(id)hookIvar:(NSString*)name inInstance:(id)inst 
{
Ivar ivar=object_getInstanceVariable(inst, [name UTF8String], NULL);
return object_getIvar(inst, ivar);
}
+(BOOL)addSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andType:(NSString*)type 
{
        return class_addMethod(cls, selector, impl, [type UTF8String]);
}               
+(IMP)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl
{
        Method hookd=class_getInstanceMethod(cls, selector);
	IMP old=method_getImplementation(hookd);
        const char* types=method_getTypeEncoding(hookd);
        method_setImplementation(hookd, impl);
	return old;
}
+(void)hookSelector:(SEL)selector inClass:(Class)cls withImp:(IMP)impl andOrig:(IMP*)orig
{
*orig = [self hookSelector:selector inClass:cls withImp:impl];
}
@end
#line 1 "Loader.m"

#include <sys/types.h>
#include <dirent.h>
#include <stdlib.h>
#include <stdio.h>    
#include <pwd.h>
#include <unistd.h>
#include <dlfcn.h>
#include <Foundation/Foundation.h>
static id bundle;
__attribute__((constructor)) void __starinit()
{
id pool=[objc_getClass("NSAutoreleasePool") new];
bundle=[[objc_getClass("NSBundle") mainBundle] bundleIdentifier];
if(bundle){
NSLog(@"STAR: Application has started! [%@]", bundle);
struct passwd* pwd = getpwuid(getuid());
char* path=malloc(strlen(pwd->pw_dir)+7);
memcpy(path, pwd->pw_dir, strlen(pwd->pw_dir));
strcat(path, "/.Star/");
NSLog(@"STAR: Star Directory is: %s", path);
DIR *dp;
struct dirent *ep;     
dp = opendir (path);
if (dp != NULL)
{
while (ep = readdir (dp))
{
int len=strlen(ep->d_name);
char* fpath=malloc(strlen(path)+len);
strcpy(fpath, path);
strcat(fpath, ep->d_name);
char* ptr=(ep->d_name)+len-5;
if(access(fpath, X_OK)==0&&strcmp(ptr, "dylib")==0){
char* plist_path=malloc(strlen(fpath));
strcpy(plist_path, fpath);
char* ext=(plist_path)+strlen(plist_path)-5;
strcpy(ext, "plist");
id pasth=[NSString stringWithUTF8String:plist_path];
free(plist_path);
NSArray* listOfValid=[NSArray arrayWithContentsOfFile:pasth];
BOOL load=YES;
if(listOfValid) {
for(NSString* valid in listOfValid) {
load=NO;
if([valid isKindOfClass:[NSString class]]){
if(CFBundleGetBundleWithIdentifier((CFStringRef)valid)!=NULL)
{
NSLog(@"STAR: Match for %@ [%@]", valid, bundle);
load=YES;
break;
}
}
}
}
if(load){
if(!dlopen(fpath, RTLD_LAZY)) perror("dlopen");
NSLog(@"Loaded: %s [%s]", ep->d_name, ptr);
free(fpath);
}}
}
(void) closedir (dp);
}
free(path);
}
[pool drain];
}



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

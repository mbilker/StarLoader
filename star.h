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

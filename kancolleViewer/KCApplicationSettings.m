//
//  KCApplicationSettings.m
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import "KCApplicationSettings.h"
#import <objc/runtime.h>

void addIntegerSetterMethod(id objc_self,SEL objc_cmd, NSInteger integer);
void addBoolSetterMethod(id objc_self,SEL objc_cmd, BOOL boolValue);
void addDoubleSetterMethod(id objc_self,SEL objc_cmd, double doubleValue);
void addObjectSetterMethod(id objc_self,SEL objc_cmd, id obj);
NSInteger addIntegerGetterMethod(id objc_self,SEL objc_cmd);
BOOL addBoolGetterMethod(id objc_self,SEL objc_cmd);
double addDoubleGetterMethod(id objc_self,SEL objc_cmd);
id addObjectGetterMethod(id objc_self,SEL objc_cmd);

@implementation KCApplicationSettings

IMPLEMENT_SHARED_INSTANCE(KCApplicationSettings)

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selName=  NSStringFromSelector(sel);
    struct objc_method_description des = protocol_getMethodDescription(@protocol(KCApplicationSettingsProtocol), sel, YES, YES);
    if (des.name == NULL) {
        return NO;
    }
    NSString * types = [NSString stringWithUTF8String:des.types];
    
    if ([selName hasPrefix:@"set"]) {
        NSString *type = [[types componentsSeparatedByString:@":"] lastObject];
        type = [type stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        const char *encodeCode = [type UTF8String];
        const char typeEncoding = *encodeCode;
        
        IMP imp = NULL;
        //判断类型
        switch (typeEncoding) {
            case 'i': // int
            case 's': // short
            case 'l': // long
            case 'q': // long long
            case 'I': // unsigned int
            case 'S': // unsigned short
            case 'L': // unsigned long
            case 'Q': // unsigned long long
                imp = (IMP)addIntegerSetterMethod;
                break;
            case 'f': // float
            case 'd': // double
                imp = (IMP)addDoubleSetterMethod;
                break;
            case 'B': // BOOL
            case 'c':
                imp = (IMP)addBoolSetterMethod;
                break;
            case '@':
                imp = (IMP)addObjectSetterMethod;
                break;
            default:
                imp = (IMP)addIntegerSetterMethod;
                break;
        }
        if (imp != NULL) {
            class_addMethod([self class], sel, imp, des.types);
        } else {
            return NO;
        }
        
        
    } else {
        NSString *type = [[types componentsSeparatedByString:@":"] firstObject];
        type = [type stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        const char *encodeCode = [type UTF8String];
        const char typeEncoding = *encodeCode;
        
        IMP imp = NULL;
        //判断类型
        switch (typeEncoding) {
            case 'i': // int
            case 's': // short
            case 'l': // long
            case 'q': // long long
            case 'I': // unsigned int
            case 'S': // unsigned short
            case 'L': // unsigned long
            case 'Q': // unsigned long long
                imp = (IMP)addIntegerGetterMethod;
                break;
            case 'f': // float
            case 'd': // double
                imp = (IMP)addDoubleGetterMethod;
                break;
            case 'B': // BOOL
            case 'c':
                imp = (IMP)addBoolGetterMethod;
                break;
            case '@':
                imp = (IMP)addObjectGetterMethod;
                break;
            default:
                imp = (IMP)addIntegerSetterMethod;
                break;
        }
        if (imp != NULL) {
            class_addMethod([self class], sel, imp, des.types);
        } else {
            return NO;
        }
    }
    return YES;
}

@end

NSString* saveKeyForKey(NSString *key)
{
    return key;
}

NSString* setterGetKey(SEL objc_cmd)
{
    NSString* key = NSStringFromSelector(objc_cmd);
    NSString *first = [key substringWithRange:NSMakeRange(3, 1)];
    first = [first lowercaseString];
    key = [key substringWithRange:NSMakeRange(3, key.length - 4)];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:first];
    return saveKeyForKey(key);
    
}

NSString* getterGetKey(SEL objc_cmd)
{
    NSString* key = NSStringFromSelector(objc_cmd);
    return saveKeyForKey(key);
    
}

void addIntegerSetterMethod(id objc_self,SEL objc_cmd, NSInteger integer)
{
    NSString *key = setterGetKey(objc_cmd);
    [[NSUserDefaults standardUserDefaults] setInteger:integer forKey:key];
    
}

void addBoolSetterMethod(id objc_self,SEL objc_cmd, BOOL boolValue)
{
    NSString *key = setterGetKey(objc_cmd);
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    
}

void addDoubleSetterMethod(id objc_self,SEL objc_cmd, double doubleValue)
{
    NSString *key = setterGetKey(objc_cmd);
    [[NSUserDefaults standardUserDefaults] setDouble:doubleValue forKey:key];
}

void addObjectSetterMethod(id objc_self,SEL objc_cmd, id obj)
{
    NSString *key = setterGetKey(objc_cmd);
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

NSInteger addIntegerGetterMethod(id objc_self,SEL objc_cmd)
{
    NSString *key = getterGetKey(objc_cmd);
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    
}

BOOL addBoolGetterMethod(id objc_self,SEL objc_cmd)
{
    NSString *key = getterGetKey(objc_cmd);
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    
}


double addDoubleGetterMethod(id objc_self,SEL objc_cmd)
{
    NSString *key = getterGetKey(objc_cmd);
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
    
}

id addObjectGetterMethod(id objc_self,SEL objc_cmd)
{
    NSString *key = getterGetKey(objc_cmd);
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}


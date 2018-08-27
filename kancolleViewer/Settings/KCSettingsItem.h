//
//  KCSettingsItem.h
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    enumKCSettingItemTypeText,
    enumKCSettingItemTypeSwitch
} enumKCSettingItemType;

@interface KCSettingsItem : NSObject

@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign)enumKCSettingItemType type;

@property (nonatomic, copy)NSString *content;

@property (nonatomic, assign)BOOL switchIsOn;

- (instancetype)initWithTitle:(NSString *)title type:(enumKCSettingItemType)type;

@end

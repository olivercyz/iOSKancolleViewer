//
//  KCApplicationSettings.h
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KCApplicationSettingsProtocol<NSObject>

@property (nonatomic, assign)BOOL disableNotification;

@property (nonatomic, assign)BOOL disableRuinAlert;

@end

@interface KCApplicationSettings : NSObject<KCApplicationSettingsProtocol>

DECLARE_SHARED_INSTANCE(KCApplicationSettings)

@end

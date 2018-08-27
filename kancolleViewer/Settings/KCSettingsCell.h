//
//  KCSettingsCell.h
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCSettingsItem.h"

@class KCSettingsCell;

@protocol KCSettingsCellDelegate<NSObject>

- (void)settingsCell:(KCSettingsCell *)cell didChangeSwitcherValue:(BOOL)swictherIsOn;

@end

@interface KCSettingsCell : UITableViewCell

@property (nonatomic, weak)id<KCSettingsCellDelegate> delegate;

@property (nonatomic ,strong)KCSettingsItem *settingItem;

@end

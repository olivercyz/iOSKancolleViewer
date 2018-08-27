//
//  KCSettingsCell.m
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import "KCSettingsCell.h"

@interface KCSettingsCell()

@property (nonatomic, strong)UILabel *leftLabel;

@property (nonatomic, strong)UISwitch *rightSwitch;
@end

@implementation KCSettingsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
        }];
        [self.contentView addSubview:self.rightSwitch];
        [self.rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
      
        }];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [KCFontManager rFontOfSize:15];
        _leftLabel.textColor = UI_COLOR(34, 34, 34);
    }
    return _leftLabel;
}

- (UISwitch *)rightSwitch
{
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(onRightSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

- (void)onRightSwitchValueChanged:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(settingsCell:didChangeSwitcherValue:)]) {
        [self.delegate settingsCell:self didChangeSwitcherValue:self.rightSwitch.on];
    }
}

- (void)setSettingItem:(KCSettingsItem *)settingItem
{
    _settingItem = settingItem;
    self.leftLabel.text = settingItem.title;
    self.rightSwitch.on = settingItem.switchIsOn;
}


@end

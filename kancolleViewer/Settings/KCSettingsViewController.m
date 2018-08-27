//
//  KCSettingsViewController.m
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

typedef enum : NSUInteger {
    eKCSetingsIndexNotification = 0,
    eKCSetingsIndexRuinAlert = 1,
} enumKCSetingsIndex;

#import "KCSettingsViewController.h"
#import "KCSettingsCell.h"
#import "KCSettingsItem.h"
#import "KCApplicationSettings.h"

@interface KCSettingsViewController ()<UITableViewDataSource, UITableViewDelegate, KCSettingsCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)NSArray *settingItems;

@end

@implementation KCSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateDatasource];
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[KCSettingsCell class] forCellReuseIdentifier:@"KCSettingsCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UI_COLOR(242, 243, 244);
    self.tableView.separatorColor = UI_COLOR(238, 241, 243);
    
    // Do any additional setup after loading the view.
}

- (void)generateDatasource
{
    KCSettingsItem *notifcation = [[KCSettingsItem alloc] initWithTitle:LOCAL_STRING(@"stringNotifacation") type:enumKCSettingItemTypeSwitch];
    notifcation.switchIsOn = ![KCApplicationSettings sharedInstance].disableNotification;
    
    KCSettingsItem *ruin = [[KCSettingsItem alloc] initWithTitle:LOCAL_STRING(@"stringRuinAlert") type:enumKCSettingItemTypeSwitch];
    ruin.switchIsOn = ![KCApplicationSettings sharedInstance].disableRuinAlert;
    self.settingItems = @[notifcation, ruin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KCSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KCSettingsCell" forIndexPath:indexPath];
    cell.settingItem = [self.settingItems objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)settingsCell:(KCSettingsCell *)cell didChangeSwitcherValue:(BOOL)swictherIsOn
{
    NSIndexPath *indePath = [self.tableView indexPathForCell:cell];
    switch (indePath.row) {
        case eKCSetingsIndexNotification:
            [KCApplicationSettings sharedInstance].disableNotification = !swictherIsOn;
            break;
        case eKCSetingsIndexRuinAlert:
            [KCApplicationSettings sharedInstance].disableRuinAlert = !swictherIsOn;
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  Yodo1AntiAddictionMinorVC.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionMinorVC.h"
#import "Yodo1AntiAddictionRulesManager.h"
#import "Yodo1AntiAddictionUserManager.h"
#import "Yodo1AntiAddictionUtils.h"

@interface Yodo1AntiAddictionMinorVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titile;

@end

@implementation Yodo1AntiAddictionMinorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Yodo1AntiAddictionUser *user = [Yodo1AntiAddictionUserManager manager].currentUser;
    
    // 获取工作日可玩时段
    Yodo1AntiAddictionRules *rules = [Yodo1AntiAddictionRulesManager manager].currentRules;
    NSString *regularRange;
    for (GroupAntiPlayingTimeRange *range in rules.groupAntiPlayingTimeRangeList) {
        if ([Yodo1AntiAddictionUtils age:user.age inRange:range.ageRange]) {
            regularRange = range.antiPlayingTimeRange.firstObject;
            break;
        }
    }
    if (!regularRange) {
        regularRange = @"08:00-22:00";
    }
    
    Yodo1AntiAddictionHolidayRules *holidayRules = [Yodo1AntiAddictionRulesManager manager].holidayRules;
    NSString *holidayRange = holidayRules.antiPlayingTimeRange.firstObject;
    if (!holidayRange) {
        holidayRange = @"08:00-22:00";
    }
    
    // 获取可玩时长
    float regularTime = 5400; // 工作日可玩时长
    float holidayTime = 10800; // 假日可玩时长
    for (GroupPlayingTime *range in rules.groupPlayingTimeList) {
        if ([Yodo1AntiAddictionUtils age:user.age inRange:range.ageRange]) {
            regularTime = range.regularTime;
            holidayTime = range.holidayTime;
            break;
        }
    }

    // 获取消费限制
    float moneyLimit = 0.0; // 每月消费限制
    float dayLimit = 0.0; // 每日消费限制
    for (GroupMoneyLimitation *range in rules.groupMoneyLimitationList) {
        if ([Yodo1AntiAddictionUtils age:user.age inRange:range.ageRange]) {
            moneyLimit = range.monthLimit / 100;
            dayLimit = range.dayLimit / 100;
            break;
        }
    }
    
    NSString* holidayTimeSt = [NSString stringWithFormat:@"%.1f",holidayTime / 3600];
    NSString* regularTimeSt = [NSString stringWithFormat:@"%.1f",regularTime / 3600];
    if ([holidayTimeSt isEqualToString:@"0.0"]) {
        holidayTimeSt = @"0";
    }
    if ([regularTimeSt isEqualToString:@"0.0"]) {
        regularTimeSt = @"0";
    }
    
    NSString* paymentLimit = [NSString stringWithFormat:@"单笔金额不可超过%.1f元，每月累计不可超过%.1f元。",dayLimit,moneyLimit];
    if (user.certificationStatus == UserCertificationStatusAault) {
        paymentLimit = @"";//成年人不显示
    }
    NSString *content = [NSString stringWithFormat:@"%@\n%@", rules.ruleCopywriting.describe,paymentLimit];
    _contentLabel.text = content;
    _titile.text = rules.ruleCopywriting.title;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat height = UIScreen.mainScreen.bounds.size.height / 3 * 2;
    CGFloat max = 321.5;
    if (@available(iOS 11.0, *)) {
        max = max + self.view.safeAreaInsets.bottom;
    }
    _contentHeight.constant = height > max ? max : height;
}

#pragma mark - Event
// 进入游戏
- (IBAction)onEnterClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        Yodo1AntiAddictionEvent *event = [[Yodo1AntiAddictionEvent alloc] init];
        event.eventCode = Yodo1AntiAddictionEventCodeNone;
        event.action = Yodo1AntiAddictionActionResumeGame;
        [[Yodo1AntiAddictionHelper shared] successful: event];
        
        if ([Yodo1AntiAddictionHelper shared].autoTimer) {
            [[Yodo1AntiAddictionHelper shared] startTimer];
        }
    }];
}

@end

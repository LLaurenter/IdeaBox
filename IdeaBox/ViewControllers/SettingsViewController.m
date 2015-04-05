//
//  SettingsViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "SettingsViewController.h"
#import "DataManager.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0];
    
    UIView *notiBack = [[UIView alloc] initWithFrame:CGRectMake(-2, 7, self.view.width+4, 44)];
    notiBack.backgroundColor = [UIColor whiteColor];
    notiBack.layer.borderWidth = 1;
    notiBack.layer.borderColor = [[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:229.0/255.0 alpha:1.0] CGColor];
    [self.view addSubview:notiBack];
    
    UILabel *lblNoti = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    lblNoti.text = @"    Notifications";
    [notiBack addSubview:lblNoti];
    
    UISwitch *switchNoti = [[UISwitch alloc] init];
    CGRect switchFrame = switchNoti.frame;
    switchFrame.origin.x = self.view.width-60;
    switchFrame.origin.y = (notiBack.height - switchFrame.size.height)/2.0;
    switchNoti.frame = switchFrame;
    
    NSString *isOnFlag = [[DataManager SharedDataManager] defaultUserObjectForKey:@"isOnNotification"];
    
    if([isOnFlag isEqualToString:@"YES"]) {
        [switchNoti setOn:YES];
    } else {
        [switchNoti setOn:NO];
    }
    [notiBack addSubview:switchNoti];

    [switchNoti addTarget:self action:@selector(switchEnabled:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
- (void)switchEnabled:(UISwitch*) switcher {
    if([switcher isOn]) {
        [[DataManager SharedDataManager] setDefaultUserObject:@"YES" forKey:@"isOnNotification"];
        
        NSDate *today = [NSDate date];
        
        // Get the year, month, day from the date
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
        
        // Set the hour, minute, second to be zero
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        
        // Create the date
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = date;
        notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = @"Did you forget your Ideas?";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        
        notif.repeatInterval = NSCalendarUnitDay;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
    } else {
        [[DataManager SharedDataManager] setDefaultUserObject:@"NO" forKey:@"isOnNotification"];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
    }
    [[DataManager SharedDataManager] update];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  ViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "InviteFriendViewController.h"
#import "RateViewController.h"
#import "SettingsViewController.h"
#import "FeedbackViewController.h"
#import "BackupViewController.h"
#import "Appirater.h"
#import <MessageUI/MessageUI.h>
#import "SCLAlertView.h"
#import "UINavigationController+Retro.h"

@interface ViewController () <MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    NSArray * data;
    HomeViewController *homeView ;
}
@end

@implementation ViewController
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:52.0/255.0 green:53.0/255.0 blue:55.0/255.0 alpha:1.0];
    data = [NSArray arrayWithObjects:@"Home",@"Invite Friends",@"Rate",@"Settings",@"Feedback",@"Backup & Sync", nil];
    self.titleNormalColor = [UIColor whiteColor];
    self.titleHighlightColor = [UIColor grayColor];
    
    homeView = [[HomeViewController alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PHAirMenuDelegate

- (NSInteger)numberOfSession
{
    return 1;
}

- (NSInteger)numberOfRowsInSession:(NSInteger)sesion
{
    return data.count;
}

- (NSString*)titleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [data objectAtIndex:indexPath.row];
}

- (NSString*)titleForHeaderAtSession:(NSInteger)session
{
    return nil;
}
- (void)didSelectRowAtIndex:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            homeView.bStatus = 0;

            break;
        }
        case 1: {
            homeView.bStatus = 1;

            break;
        }
        case 2: {
            homeView.bStatus = 2;

            break;
        }
        default: {
            homeView.bStatus = 0;
            break;
        }
    }
    
}
- (UIViewController*)viewControllerForIndexPath:(NSIndexPath*)indexPath{
    switch (indexPath.row) {
        case 0: {
            homeView.bStatus = 0;
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:homeView];
            return navCtrl;
            break;
        }
        case 1: {
            homeView.bStatus = 1;
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:homeView];
            return navCtrl;
            break;
        }
        case 2: {
            homeView.bStatus = 2;
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:homeView];
            return navCtrl;
            break;
        }
        case 3: {
            SettingsViewController *settingsView = [[SettingsViewController alloc] init];
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:settingsView];
            return navCtrl;
            break;
        }
        case 4: {
            FeedbackViewController *feedbackView = [[FeedbackViewController alloc] init];
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:feedbackView];
            return navCtrl;
            break;
        }
        case 5: {
            BackupViewController *backupView = [[BackupViewController alloc] init];
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:backupView];
            return navCtrl;
            break;
        }
        default:
            break;
    }
    return nil;
    
}

- (UIImage*)thumbnailImageAtIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end

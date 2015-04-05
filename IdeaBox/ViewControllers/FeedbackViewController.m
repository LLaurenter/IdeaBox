//
//  FeedbackViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UINavigationBar+Addition.h"
#import "SCLAlertView.h"

@interface FeedbackViewController ()<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@end

@implementation FeedbackViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Feedback";
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:243.0/255.0 alpha:1.0];
    
    UIButton *leaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leaveBtn.frame = CGRectMake(-2, 7, self.view.width+4, 44);
    leaveBtn.backgroundColor = [UIColor whiteColor];
    leaveBtn.layer.borderWidth = 1;
    [leaveBtn setTitle:@"Leave Feedback" forState:UIControlStateNormal];
    [leaveBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [leaveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [leaveBtn addTarget:self action:@selector(leaveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    leaveBtn.layer.borderColor = [[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:229.0/255.0 alpha:1.0] CGColor];
    
    UILabel *lblVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-100, self.view.width, 20)];
    lblVersion.text = @"Version 1.0";
    lblVersion.textColor = [UIColor grayColor];
    lblVersion.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:leaveBtn];
    [self.view addSubview:lblVersion];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)leaveBtnClicked {
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    mailCompose.navigationBar.tintColor = [UIColor whiteColor];
    mailCompose.mailComposeDelegate = self;
    [mailCompose setSubject:@"Feedback"];
    [mailCompose setToRecipients:[NSArray arrayWithObjects:@"ideaboxapp@yahoo.com", nil]];
    [self.navigationController presentViewController:mailCompose animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error  {
    switch (result)
    {
        case MFMailComposeResultCancelled: {

            break;
        }
        case MFMailComposeResultSaved: {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showNotice:self title:@"Wefie Pic Email Send" subTitle:@"Saved to Draft!" closeButtonTitle:nil duration:2.0f];
            
            break;
            
        }
        case MFMailComposeResultSent: {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showSuccess:self title:@"Wefie Pic Email Send" subTitle:@"Successfully sent!" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
        case MFMailComposeResultFailed: {
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showError:self title:@"Wefie Pic Email Send" subTitle:@"Failed to Send!" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
        default:
        {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showError:self title:@"Wefie Pic Email Send" subTitle:@"Failed to Send" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end

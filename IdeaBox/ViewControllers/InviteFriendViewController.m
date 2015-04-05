//
//  InviteFriendViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "InviteFriendViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface InviteFriendViewController ()

@property (weak, nonatomic) IBOutlet UIButton *inviteContactBtn;
@property (weak, nonatomic) IBOutlet UIButton *inviteEmailBtn;
@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inviteContactBtn.layer.cornerRadius = 4.0;
    self.inviteEmailBtn.layer.cornerRadius = 4.0;
    
    
    [self.inviteContactBtn setImage:[UIImage imageNamed:@"InviteIcon"] forState:UIControlStateNormal];
    [self.inviteEmailBtn setImage:[UIImage imageNamed:@"InviteEmail"] forState:UIControlStateNormal];
    
    [self.inviteContactBtn setTintColor:[UIColor whiteColor]];
    [self.inviteEmailBtn setTintColor:[UIColor whiteColor]];
    
    self.inviteContactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.inviteContactBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.inviteContactBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, -40)];

    self.inviteEmailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.inviteEmailBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.inviteEmailBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, -40)];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];    
}
- (IBAction)inviteContactBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(inviteViaContactsBtnClicked:)]) {
        [self.delegate inviteViaContactsBtnClicked:self];
    }
}
- (IBAction)inviteEmailBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(inviteViaEmailBtnClicked:)]) {
        [self.delegate inviteViaEmailBtnClicked:self];
    }
}
- (IBAction)cancelBtnClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
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

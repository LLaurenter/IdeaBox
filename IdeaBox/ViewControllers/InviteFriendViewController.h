//
//  InviteFriendViewController.h
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol InviteFriendViewDelegate;

@interface InviteFriendViewController : RootViewController
@property (assign, nonatomic) id <InviteFriendViewDelegate>delegate;
@end

@protocol InviteFriendViewDelegate<NSObject>

@optional

- (void)cancelButtonClicked:(InviteFriendViewController*) inviteCtrl;
- (void)inviteViaEmailBtnClicked:(InviteFriendViewController*) inviteCtrl;
- (void)inviteViaContactsBtnClicked:(InviteFriendViewController*) inviteCtrl;

@end
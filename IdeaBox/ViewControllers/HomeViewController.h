//
//  HomeViewController.h
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHAirViewController.h"
#import "RootViewController.h"
#import <MessageUI/MessageUI.h>

@interface HomeViewController : RootViewController
{
    UITableView *homeTableView;
}

@property (nonatomic, assign) int bStatus;

@end

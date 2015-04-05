//
//  IdeaCreateViewController.h
//  IdeaBox
//
//  Created by Louis Laurent on 12/10/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface IdeaCreateViewController : UIViewController

@property (nonatomic, strong) NSString *nameIdeaStr;
@property (nonatomic, strong) NSManagedObject *objectIdeaBox;

@end

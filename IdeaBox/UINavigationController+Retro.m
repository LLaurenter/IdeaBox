//
//  UINavigationController+Retro.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/18/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "UINavigationController+Retro.h"

@implementation UINavigationController (Retro)

- (void)pushViewControllerRetro:(UIViewController *)viewController {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromRight;
//    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:YES];
}

- (void)popViewControllerRetro {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromLeft;
//    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:YES];
}
- (void)popViewControllerRetroToRoot {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromLeft;
//    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popToRootViewControllerAnimated:YES];
}
@end
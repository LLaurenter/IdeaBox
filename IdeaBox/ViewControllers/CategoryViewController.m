//
//  CategoryViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/10/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "CategoryViewController.h"
#import "UIViewAdditions.h"
#import "UINavigationBar+Addition.h"
#import "IdeaCreateViewController.h"
#import "UINavigationController+Retro.h"
#import "DataManager.h"

@interface CategoryViewController ()
{
    NSMutableArray *colorArray;
    NSMutableArray *titleArray;
    NSString* ideaTitle;
    UIScrollView *scrollView;
}
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ideaTitle = @"Your Idea";
    self.view.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:206.0/255.0 blue:63.0/255.0 alpha:1.0];

    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"prev_a"] forState:UIControlStateHighlighted];
    [customButton setTitle:@"Done" forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.4] forState:UIControlStateHighlighted];
    [customButton addTarget:self action:@selector(btnDoneClicked) forControlEvents:UIControlEventTouchUpInside];
    [customButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [customButton sizeToFit];
    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customButton setImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 18)];
    [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    UIBarButtonItem* btnDone = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = btnDone;
    
    colorArray = [NSMutableArray arrayWithObjects:[UIColor colorWithRed:246.0/255.0 green:192.0/255.0 blue:62.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:126.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:131.0/255.0 blue:181.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:218.0/255.0 green:74.0/255.0 blue:29.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:158.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:41.0/255.0 green:63.0/255.0 blue:79.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:175.0/255.0 blue:103.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:218.0/255.0 green:74.0/255.0 blue:29.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:144.0/255.0 green:70.0/255.0 blue:168.0/255.0 alpha:1.0 ],nil];
    
    titleArray = [NSMutableArray arrayWithObjects:@"Your Idea",@"Products",@"Services",@"Target Market",@"Customers",@"Market Strategy",@"Business Model",@"Competitors",@"Execution", nil];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scrollView.backgroundColor = [UIColor colorWithRed:253.0/255.0 green:206.0/255.0 blue:63.0/255.0 alpha:1.0];
    float caseDefaultHeight = 120;
    for(int i=0; i<9; i++) {
        
        //********************************************************
        
        UIImageView *caseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*(caseDefaultHeight-30), self.view.width, self.view.height)];
        caseView.tag = i;
        caseView.backgroundColor = [colorArray objectAtIndex:i];
        caseView.userInteractionEnabled = YES;
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:caseView.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(16.0, 16.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = caseView.bounds;
        maskLayer.path = maskPath.CGPath;
        caseView.layer.mask = maskLayer;
        
        
        UITapGestureRecognizer *panGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pangesClicked:)];
        panGes.numberOfTouchesRequired = 1;
        [caseView addGestureRecognizer:panGes];
        NSString *title = [titleArray objectAtIndex:i];

        UIImageView *imageMark = [[UIImageView alloc] initWithFrame:CGRectMake(20, 16, 60, 60)];
        imageMark.image = [UIImage imageNamed:title];
        [caseView addSubview:imageMark];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(90, 16, 200, 60)];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = title;
        lblTitle.font = [UIFont boldSystemFontOfSize:16];
        [caseView addSubview:lblTitle];
        //*******************************************************
        
        [scrollView addSubview:caseView];
    }
    [scrollView setContentSize:CGSizeMake(self.view.width, 10*(caseDefaultHeight-30)-80)];
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
}
- (void)pangesClicked:(UITapGestureRecognizer *) panGes {
    [self AnimationStart:(UIImageView*)panGes.view];
}
- (void)AnimationStart:(UIImageView *)imageView{
    ideaTitle = [titleArray objectAtIndex:imageView.tag];
    [self btnCheckClicked];
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        for(int i=0; i<9; i++) {
//            UIImageView *tempView = (UIImageView*)[scrollView viewWithTag:i];
//            CGRect frame = tempView.frame;
//            frame.origin.y = 0;
//            tempView.frame = frame;
//            tempView.alpha = 0;
//
//        }
//    } completion:^(BOOL finished) {
//        if(finished) {
//            ideaTitle = [titleArray objectAtIndex:imageView.tag];
//            [self btnCheckClicked];
//
//        }
//    }];
    
}
- (void)btnCaseClicked: (id) sender {
    UIButton *btnCase = (UIButton*)sender;
    ideaTitle = [titleArray objectAtIndex:btnCase.tag];
    [self btnCheckClicked];
}
- (void)btnDoneClicked {
    
    [self.objectIdeaBox didSave];
    [[DataManager SharedDataManager] update];
    
    [self.navigationController popViewControllerRetroToRoot];
}

- (void)btnCheckClicked {
    IdeaCreateViewController *ideaView = [[IdeaCreateViewController alloc] init];
    ideaView.title = ideaTitle;
    ideaView.nameIdeaStr = self.nameIdeaStr;
    ideaView.objectIdeaBox = self.objectIdeaBox;
    [self.navigationController pushViewControllerRetro:ideaView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Ideaboxnav.png"] forBarMetrics:UIBarMetricsDefault];
    float caseDefaultHeight = 120;

    for(int i=0; i<9; i++) {
        //********************************************************
        UIImageView *caseView = (UIImageView*)[scrollView viewWithTag:i];
        caseView.alpha = 1.0;
        caseView.frame = CGRectMake(0, i*(caseDefaultHeight-30), self.view.width, self.view.height);
    }
    
}

- (void)registerIdea {
    DataManager *dm = [DataManager SharedDataManager];
    NSManagedObject *record = [dm newObjectForEntityForName:@"Ideabox"];
    [record setValue:self.nameIdeaStr forKey:@"name"];
    [record setValue:@"" forKey:@"category"];
    [record setValue:@"" forKey:@"content"];
    [record setValue:[NSDate date] forKey:@"createdAt"];
    [record didSave];
    [dm update];
}

@end

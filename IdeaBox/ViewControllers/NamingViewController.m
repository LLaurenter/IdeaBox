//
//  NamingViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/10/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "NamingViewController.h"
#import "UIViewAdditions.h"
#import "CategoryViewController.h"
#import "UINavigationBar+Addition.h"
#import "UINavigationController+Retro.h"
#import "DataManager.h"

@interface NamingViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameTextField;
@end

@implementation NamingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *btnClose = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked)];
    [btnClose setImageInsets:UIEdgeInsetsMake(0, -12, 0, 12)];
    
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(btnNextClicked)];
    [btnNext setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]} forState:UIControlStateNormal];

    btnNext.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = btnNext;
    self.navigationItem.leftBarButtonItem = btnClose;

    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64,self.view.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0];
    [self.view addSubview:lineView];

    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.nameTextField.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];
    self.nameTextField.textColor = [UIColor blackColor];
    self.nameTextField.delegate = self;
    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name your idea/business" attributes:@{
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0]}];
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    
    [self.view addSubview:self.nameTextField];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnClicked {
    [self.navigationController popViewControllerRetro];
}

- (void)btnNextClicked {
    CategoryViewController *categoryView = [[CategoryViewController alloc] init];
    categoryView.nameIdeaStr = self.nameTextField.text;
    categoryView.objectIdeaBox = [self registerIdea];
    
    [self.navigationController pushViewControllerRetro:categoryView];
}
- (NSManagedObject *)registerIdea {
    DataManager *dm = [DataManager SharedDataManager];
    NSManagedObject *record = [dm newObjectForEntityForName:@"Ideabox"];
    [record setValue:self.nameTextField.text forKey:@"name"];
    [record setValue:[NSDate date] forKey:@"createdAt"];
    [record didSave];
    [dm update];
    return record;
}
#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tempStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([tempStr isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(![textField.text isEqualToString:@""])
        [self btnNextClicked];
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Name Idea";
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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

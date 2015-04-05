//
//  IdeaCreateViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/10/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "IdeaCreateViewController.h"
#import "UINavigationBar+Addition.h"
#import "UIViewAdditions.h"
#import "DataManager.h"
#import "UINavigationController+Retro.h"

@interface IdeaCreateViewController ()
{
    UIView *toolBar;
    float _currentKeyboardHeight;
    UITextView *textView;
    UIButton *btnKeyboard;
    NSMutableDictionary *dictUse;
    NSString *placeHolderText;
}
@end

@implementation IdeaCreateViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    dictUse = [self getDictionary];
    
    NSArray *arrayValues = [NSArray arrayWithObjects:@"Describe your million dollar idea.",
                            @"Describe your physical product,features and benefits. What problem is your product solving or what gap is it filling?",
                            @"Describe what service you will be offering. What problem are you solving or what gap are you filling?",
                            @"Describe the geographic, demographic and psychographic characteristics that define your target market",
                            @"Describe who your customers are.",
                            @"Describe how you will promote and advertise your product or service. How will you market your idea?",
                            @"Describe what strategy you will use to create revenue. How will your company/idea make money?",
                            @"Who are the other competitors in the same space as you? What makes you better, compare your strengths and weaknesses to your competitors.",
                            @"What steps will you take to expand your idea and make it a reality?"
                            , nil];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"Your Idea",@"Products",@"Services",@"Target Market",@"Customers",@"Market Strategy",@"Business Model",@"Competitors",@"Execution", nil];

    NSDictionary *dictArray = [NSDictionary dictionaryWithObjects:arrayValues forKeys:titleArray];
    
    placeHolderText = [dictArray objectForKey:self.title];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height)];
    textView.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    if([dictUse objectForKey:self.title]) {
        textView.text = [dictUse objectForKey:self.title];
        textView.textColor = [UIColor blackColor];
        if([textView.text isEqualToString:@""]) {
            textView.text = placeHolderText;
            textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];

        }

    } else {
        textView.text = placeHolderText;
        textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];

    }
    
    [self.view addSubview:textView];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 0, 2, self.view.height)];
    lineView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:194.0/255.0 blue:221.0/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    
    toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-44-64, self.view.width, 44)];
    toolBar.backgroundColor = [UIColor clearColor];
    
    btnKeyboard = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-88, 0, 44, 44)];
    [btnKeyboard setBackgroundImage:[UIImage imageNamed:@"keyboardup"] forState:UIControlStateNormal];
    [btnKeyboard setBackgroundImage:[UIImage imageNamed:@"keyboarddown"] forState:UIControlStateSelected];
    [btnKeyboard addTarget:self action:@selector(btnKeyboardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:btnKeyboard];
    
    UIButton *btnCheckBox = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-44,0, 44, 44)];
    [btnCheckBox addTarget:self action:@selector(btnCheckBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnCheckBox setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [toolBar addSubview:btnCheckBox];
    
    [self.view addSubview:toolBar];
    // Do any additional setup after loading the view.
}
- (void)btnCheckBoxClicked:(id) sender {
    UIButton *btnCheckBox = (UIButton*)sender;
    btnCheckBox.selected = !btnCheckBox.selected;
    btnKeyboard.selected = NO;
    [textView resignFirstResponder];
}
- (void)btnKeyboardClicked:(id) sender {
    UIButton *btnKeyboardTemp = (UIButton*)sender;
    btnKeyboardTemp.selected = !btnKeyboardTemp.selected;
    if(btnKeyboardTemp.selected == YES) {
        [textView becomeFirstResponder];
    } else {
        [textView resignFirstResponder];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

}
-(void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _currentKeyboardHeight = kbSize.height;
    
    [self setViewMovedUp:YES];
    if([textView.text isEqualToString:placeHolderText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];
        
    }
    btnKeyboard.selected = YES;
    textView.frame = CGRectMake(0, 0, 320, self.view.height-_currentKeyboardHeight);

}

-(void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _currentKeyboardHeight = kbSize.height;
    
    [self setViewMovedUp:NO];
    
    if([textView.text isEqualToString:@""]) {
        textView.text = placeHolderText;
        textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];
        textView.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];
        
    }
    btnKeyboard.selected = NO;
    textView.frame = CGRectMake(0, 0, 320, self.view.height);
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25]; // if you want to slide up the view
    
    CGRect rect = toolBar.frame;
    if (movedUp)
    {
        rect = CGRectMake(0, self.view.height-toolBar.frame.size.height-_currentKeyboardHeight, self.view.width, toolBar.frame.size.height);
    }
    else
    {
        // revert back to the normal state.
        rect = CGRectMake(0, self.view.height-toolBar.frame.size.height, self.view.width, toolBar.frame.size.height);
    }
    toolBar.frame = rect;
    [UIView commitAnimations];
}

- (void)btnDoneClicked {
    
    if([textView.text isEqualToString:placeHolderText]) {
        [dictUse setValue:@"" forKey:self.title];
    } else {
        [dictUse setValue:textView.text forKey:self.title];
    }
    [self saveDictionary];
    
    [self.navigationController popViewControllerRetro];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerIdea {
    
    DataManager *dm = [DataManager SharedDataManager];
    NSManagedObject *record = [dm newObjectForEntityForName:@"Ideabox"];
    [record setValue:self.nameIdeaStr forKey:@"name"];
    [record setValue:self.title forKey:@"category"];
    [record setValue:textView.text forKey:@"content"];
    [record setValue:[NSDate date] forKey:@"createdAt"];
    [record didSave];
    [dm update];
    [self.navigationController popViewControllerRetroToRoot];
    
}

- (NSMutableDictionary *)getDictionary {

    NSData *data = [[NSMutableData alloc] initWithData:[self.objectIdeaBox valueForKey:@"content"]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *yourDictionary=[unarchiver decodeObjectForKey:@"content"];
    NSMutableDictionary *dictReturn = [NSMutableDictionary dictionaryWithDictionary:yourDictionary];
    [unarchiver finishDecoding];
    return dictReturn;
}

- (void)saveDictionary {

    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictUse forKey:@"content"];
    [archiver finishEncoding];
    [self.objectIdeaBox setValue:data forKey:@"content"];
}

@end

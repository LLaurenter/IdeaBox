//
//  QuickNotesViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/10/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "QuickNotesViewController.h"
#import "UIViewAdditions.h"
#import "UINavigationBar+Addition.h"
#import "DataManager.h"
#import "UINavigationController+Retro.h"

@interface QuickNotesViewController ()
{
    UIView *toolBar;
    float _currentKeyboardHeight;
    UITextView *textView;
    UIButton *btnKeyboard;

}
@end

@implementation QuickNotesViewController

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"QuickNotes";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar hideBottomHairline];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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
    textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.text = @"Have a quick thought or idea?";
    
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
    [self loadQuickNote];
    // Do any additional setup after loading the view.
}

- (void)loadQuickNote {
    DataManager *dm = [DataManager SharedDataManager];
    if([dm defaultUserObjectForKey:@"quicknotes"]) {
        textView.text = [dm defaultUserObjectForKey:@"quicknotes"];
        textView.textColor = [UIColor blackColor];
        NSString *quicknstr = [dm defaultUserObjectForKey:@"quicknotes"];
        if([quicknstr isEqualToString:@""] || [quicknstr isEqualToString:@"Have a quick thought or idea?"]) {
            textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];
        }
    } else {
        textView.text = @"Have a quick thought or idea?";
        textView.textColor = [UIColor colorWithRed:114.0/255.0 green:122.0/255.0 blue:140.0/255.0 alpha:1.0];
    }
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
    btnKeyboard.selected = YES;
    if([textView.text isEqualToString:@"Have a quick thought or idea?"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];

    }
    textView.frame = CGRectMake(0, 0, 320, self.view.height-_currentKeyboardHeight);
}

-(void)keyboardWillHide:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _currentKeyboardHeight = kbSize.height;
    
    [self setViewMovedUp:NO];
    
    if([textView.text isEqualToString:@""]) {
        textView.text = @"Have a quick thought or idea?";
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
    [self.view endEditing:YES];

    DataManager *dm = [DataManager SharedDataManager];
    [dm setDefaultUserObject:textView.text forKey:@"quicknotes"];
    [dm update];

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

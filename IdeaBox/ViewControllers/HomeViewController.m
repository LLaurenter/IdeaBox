//
//  HomeViewController.m
//  IdeaBox
//
//  Created by Louis Laurent on 12/9/14.
//  Copyright (c) 2014 IdeaBox. All rights reserved.
//

#import "HomeViewController.h"
#import "QuickNotesViewController.h"
#import "NamingViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "InviteFriendViewController.h"
#import "Appirater.h"
#import "DataManager.h"
#import "SCLAlertView.h"
#import "UINavigationController+Retro.h"
#import "CategoryViewController.h"

@interface HomeViewController ()<InviteFriendViewDelegate,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *idea_Array;
    NSDictionary *dictColor;
    NSArray *colorRoutine;
}
@end

@implementation HomeViewController
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:246.0/255.0 green:192.0/255.0 blue:62.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:126.0/255.0 green:140.0/255.0 blue:141.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:131.0/255.0 blue:181.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:218.0/255.0 green:74.0/255.0 blue:29.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:158.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:41.0/255.0 green:63.0/255.0 blue:79.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:0.0/255.0 green:175.0/255.0 blue:103.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:218.0/255.0 green:74.0/255.0 blue:29.0/255.0 alpha:1.0 ],
                  [UIColor colorWithRed:144.0/255.0 green:70.0/255.0 blue:168.0/255.0 alpha:1.0 ],nil];
    
    NSArray* titleArray = [NSArray arrayWithObjects:@"Your Idea",@"Products",@"Services",@"Target Market",@"Customers",@"Market Strategy",@"Business Model",@"Competitors",@"Execution", nil];

    colorRoutine = [NSArray arrayWithObjects:
                             [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:35.0/255.0 alpha:1.0 ],
                             [UIColor colorWithRed:255.0/255.0 green:115.0/255.0 blue:61.0/255.0 alpha:1.0 ],
                             [UIColor colorWithRed:13.0/255.0 green:191.0/255.0 blue:84.0/255.0 alpha:1.0 ],
                             [UIColor colorWithRed:120.0/255.0 green:102.0/255.0 blue:142.0/255.0 alpha:1.0 ], nil];
    
    dictColor = [NSDictionary dictionaryWithObjects:colorArray forKeys:titleArray];
    
    //self.title = @"Ideabox";
    
    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStylePlain];
    homeTableView.rowHeight = (self.view.height-64)/6.6;
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    [self.view addSubview:homeTableView];
    
    UIBarButtonItem *plusBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusBtnClicked:)];
    self.navigationItem.rightBarButtonItem = plusBtn;
    
    UIButton *btnLight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLight setImage:[UIImage imageNamed:@"lightBump"] forState:UIControlStateNormal];
    [btnLight setImage:[UIImage imageNamed:@"lightBumpH"] forState:UIControlStateHighlighted];
    [btnLight addTarget:self action:@selector(btnLightClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnLight.bounds = CGRectMake(0, 0, 100, 100);
    btnLight.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-120);
    [self.view addSubview:btnLight];
    
    [homeTableView setSeparatorInset:UIEdgeInsetsZero];
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // Do any additional setup after loading the view.
}
- (void)btnLightClicked:(id)sender
{
    QuickNotesViewController *quickView = [[QuickNotesViewController alloc] init];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:quickView];
    navCtrl.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;

    [self.navigationController presentViewController:navCtrl animated:YES completion:nil];
}
- (void)plusBtnClicked:(id)sender
{

    NamingViewController *namingView = [[NamingViewController alloc] init];
    [self.navigationController pushViewControllerRetro:namingView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(self.bStatus == 1) {
        InviteFriendViewController *inviteView = [[InviteFriendViewController alloc] initWithNibName:@"InviteFriendViewController" bundle:nil];
        inviteView.delegate = self;
        [self.navigationController presentPopupViewController:inviteView animationType:MJPopupViewAnimationSlideLeftLeft];
        self.bStatus = 0;
    } else if(self.bStatus == 2) {
        [Appirater rateApp];
        self.bStatus = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Ideaboxnav.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self loadingData];
}
#pragma mark -
#pragma mark ViewControllers Delegate
- (void)cancelButtonClicked:(InviteFriendViewController*) inviteCtrl {
    [self.navigationController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];
}
- (void)inviteViaEmailBtnClicked:(InviteFriendViewController*) inviteCtrl {
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    mailCompose.navigationBar.tintColor = [UIColor whiteColor];
    mailCompose.mailComposeDelegate = self;
    [mailCompose setSubject:@"IdeaBox Invite"];
    [mailCompose setMessageBody:@"Please download this cool IdeaBox app." isHTML:YES];
    [self.navigationController presentViewController:mailCompose animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];

    }];

}
- (void)inviteViaContactsBtnClicked:(InviteFriendViewController*) inviteCtrl {
    MFMessageComposeViewController *messageCompose = [[MFMessageComposeViewController alloc] init];
    messageCompose.navigationBar.tintColor = [UIColor whiteColor];
    messageCompose.messageComposeDelegate = self;
    messageCompose.navigationBar.topItem.title = @"Invite Friends" ;
    [messageCompose setSubject:@"Invite Friends"];
    [messageCompose setBody:@"Please download this cool IdeaBox app."];
    [messageCompose setTitle:@"Please download this cool IdeaBox app."];
    [self.navigationController presentViewController:messageCompose animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideLeftLeft];

    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 
#pragma mark Data Load
- (void)loadingData {
    DataManager *dm = [DataManager SharedDataManager];
    NSArray * coreIdeasArray = [dm getResultsWithEntity:@"Ideabox" sortDescriptor:@"createdAt" sortPredicate:nil batchSize:100];
    idea_Array = [NSMutableArray arrayWithArray:coreIdeasArray];
    [homeTableView reloadData];
}
#pragma mark -
#pragma mark UITableView Load
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return idea_Array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IdeaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSManagedObject *obj = [idea_Array objectAtIndex:indexPath.row];

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIImageView *barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, (self.view.height-64)/5.7)];
        barImageView.tag = 10;
        [cell addSubview:barImageView];

        cell.indentationLevel = 1;
        cell.indentationWidth = 20;
        
        cell.textLabel.textColor = [UIColor colorWithRed:69.0/255.0 green:75.0/255.0 blue:87.0/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18.0];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:12.0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArrow"]];
        
        UIImageView *highlightBar = [[UIImageView alloc] initWithFrame:barImageView.frame];
        highlightBar.tag = 11;
        [cell.selectedBackgroundView addSubview:highlightBar];
    }
    UIImageView *barImageColorView = (UIImageView*)[cell viewWithTag:10];
    barImageColorView.backgroundColor = [colorRoutine objectAtIndex:indexPath.row%4];

    UIImageView *highlightColorBar = (UIImageView*)[cell.selectedBackgroundView viewWithTag:11];
    highlightColorBar.backgroundColor = [colorRoutine objectAtIndex:indexPath.row%4];
    
    cell.textLabel.text = [obj valueForKey:@"name"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    NSDate *date = [obj valueForKey:@"createdAt"];
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *obj = [idea_Array objectAtIndex:indexPath.row];

    CategoryViewController *categoryView = [[CategoryViewController alloc] init];
    categoryView.nameIdeaStr =  [obj valueForKey:@"name"];
    categoryView.objectIdeaBox = obj;
    
    [self.navigationController pushViewControllerRetro:categoryView];
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.view.height-64)/5.7;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSManagedObject *obj = [idea_Array objectAtIndex:indexPath.row];
        [idea_Array removeObjectAtIndex:indexPath.row];
        [[DataManager SharedDataManager].managedObjectContext deleteObject:obj];
        [[DataManager SharedDataManager] update];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];

        [tableView endUpdates];
        [tableView performSelector:@selector(reloadData)];
    }
}

#pragma mark -
#pragma mark Mailcompose Controller Delegate
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
            
            [alert showNotice:self title:@"IdeaBox Invite Friends" subTitle:@"Saved to Draft!" closeButtonTitle:nil duration:2.0f];
            
            break;
            
        }
        case MFMailComposeResultSent: {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showSuccess:self title:@"IdeaBox Invite Friends" subTitle:@"Successfully sent!" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
        case MFMailComposeResultFailed: {
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showError:self title:@"IdeaBox Invite Friends" subTitle:@"Failed to Send!" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
        default:
        {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showError:self title:@"IdeaBox Invite Friends" subTitle:@"Failed to Send" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -
#pragma mark MFMessageDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MessageComposeResultCancelled: {
            
            break;
        }
        case MessageComposeResultFailed: {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showError:self title:@"IdeaBox Invite Friends" subTitle:@"Failed to Send!" closeButtonTitle:nil duration:2.0f];
            
            break;

            
        }
        case MessageComposeResultSent: {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            
            [alert alertIsDismissed:^{
                NSLog(@"SCLAlertView dismissed!");
            }];
            
            [alert showSuccess:self title:@"IdeaBox Invite Friends" subTitle:@"Successfully sent!" closeButtonTitle:nil duration:2.0f];
            
            break;
        }
        default:
        {
            break;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end

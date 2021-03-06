//
//  UserProfileViewController.m
//  Guilt
//
//  Created by Agnt86 on 11/5/13.
//  Copyright (c) 2013 John Andrews. All rights reserved.
//

#import "UserProfileViewController.h"
#import "DonationsTableViewController.h"

@interface UserProfileViewController () {


    DonationsTableViewController *donationsTable;
    NSMutableArray *donorInfo;
    
}

@end

@implementation UserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; //Required to run Apple's code for viewWillAppear
    
  //  [self.tableView reloadData]; //reloads data into a table
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    donationsTable = [[DonationsTableViewController alloc]init];
    
    [self.view addSubview:donationsTable.view]; //adding the TableViewController's view
    
    donorInfo = [NSMutableArray new];
    
    //find screen dimensions
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //size donationsTable
    donationsTable.view.frame = CGRectMake(0, 233, screenWidth, screenHeight*.33);
    
    PFQuery *donationsQuery = [PFQuery queryWithClassName:@"Donation"];
    [donationsQuery whereKey:@"donor" equalTo: [PFUser currentUser] ];
    [donationsQuery includeKey:@"donor"];
    [donationsQuery includeKey:@"charityRecipient"];
    [donationsQuery includeKey:@"donationAmount"];

    
    [donationsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            for (PFObject *object in objects) {
                
                [donorInfo addObject:object];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"%lul", (unsigned long)[donorInfo count]);
    return donorInfo.count;
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *donationDate;
    PFObject *charity;
    NSString *charityName;
    NSString *donationAmount;
    
    NSString* identifier =@"abc";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
    }
    
    //Person *personTemp =self.people[indexPath.row];
    
    charity = [[donorInfo objectAtIndex:indexPath.row] objectForKey:@"charityRecipient"];
    donationAmount = [[donorInfo objectAtIndex:indexPath.row] objectForKey:@"donationAmount"];
    
    cell.textLabel.text = [NSString stringWithFormat:@" Charity: %@  Donation Amount: %@", charity[@"name"], donationAmount];
    
    
    return cell;
    
}






















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








#pragma mark - Table view delegate




@end

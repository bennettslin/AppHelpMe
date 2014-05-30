//
//  NamesTableViewController.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "NamesTableViewController.h"
#import "List.h"
#import "NameTableViewCell.h"
#import "ProfileViewController.h"

@interface NamesTableViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) List *myList;
@property (strong, nonatomic) UIButton *dismissKeyboardButton;

@property (strong, nonatomic) UIButton *navLogoView;
@property (strong, nonatomic) UIImageView *userButton;

@end

@implementation NamesTableViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationController.navigationBar.barTintColor = kSubBlue;
  
  self.navLogoView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  self.navLogoView.center = CGPointMake(self.navLogoView.superview.center.x, self.navLogoView.superview.center.y);

  NSLog(@"center is %.1f, %.1f", self.navLogoView.superview.center.x, self.navLogoView.superview.center.y)  ;
  [self.navLogoView addTarget:self action:@selector(navLogoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
  UIImageView *navLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppHelpMe_pj"]];
  navLogo.contentMode = UIViewContentModeScaleAspectFit;
  navLogo.frame = CGRectMake(0, 0, 120, 44);
  
  navLogo.center = CGPointMake(navLogo.superview.center.x + 15, navLogo.superview.center.y);
  NSLog(@"center is %.1f, %.1f", navLogo.superview.center.x + 60, navLogo.superview.center.y)  ;
  
  [self.navLogoView addSubview:navLogo];

  self.userButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User_LoggedIn"]];

  self.userButton.contentMode = UIViewContentModeScaleAspectFit;
  self.userButton.frame = CGRectMake(0, 0, 36, 36);
  self.userButton.center = CGPointMake(self.userButton.superview.center.x + 150, self.userButton.superview.center.y);
  
  [self.navLogoView addSubview:self.userButton];
  
  self.navigationItem.titleView = self.navLogoView;
  
  self.myList = [[List alloc] init];
  [self.myList populateData];
  
  self.searchBar.delegate = self;
  self.searchBar.placeholder = @"Who do you want to help?";
  
  self.dismissKeyboardButton = [[UIButton alloc] initWithFrame:self.view.frame];
  self.dismissKeyboardButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.0f];
}

-(void)viewWillAppear:(BOOL)animated {
  [self.tableView reloadData];
}

-(void)navLogoButtonTapped:(UIButton *)sender {
  NSLog(@"tapped");
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - search bar methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

  [self.dismissKeyboardButton addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:self.dismissKeyboardButton];
}

-(void)dismissKeyboard:(UIButton *)sender {
  [self.searchBar resignFirstResponder];
  [sender removeFromSuperview];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  // Return the number of rows in the section.
  return self.myList.people.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  cell.myPerson = self.myList.people[indexPath.row];
  [cell setProperties];

  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@"profileSegue"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    ProfileViewController *profileVC = [segue destinationViewController];
    Person *myPerson = self.myList.people[indexPath.row];
    profileVC.myPerson = myPerson;
  }
}

@end

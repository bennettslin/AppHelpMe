//
//  ThankYouViewController.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/18/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "ThankYouViewController.h"
#import "Person.h"

@interface ThankYouViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnButton;

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIImageView *arrowGraphic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *superHelpersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *faceBookImage;
@property (weak, nonatomic) IBOutlet UIButton *helperButton;
@property (weak, nonatomic) IBOutlet UILabel *happenedLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sponsorLogo1;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorLogo2;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorLogo3;

-(IBAction)returnButtonTapped:(id)sender;

@end

@implementation ThankYouViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.myPerson = [self.delegate getMyPerson];
  
  self.logo.image = [UIImage imageNamed:@"AppHelpMe_pj"];
  self.logo.contentMode = UIViewContentModeScaleAspectFit;
  
  self.profilePicture.image = self.myPerson.profilePicture;
  self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width * 0.3f;
  self.profilePicture.clipsToBounds = YES;
  self.nameLabel.text = [NSString stringWithFormat:@"%@ thanks you!", self.myPerson.name];
  self.sponsorLogo1.image = [UIImage imageNamed:@"safewayLogo_small.gif"];
  self.sponsorLogo2.image = [UIImage imageNamed:@"Target_Logo_small.gif"];
  self.sponsorLogo3.image = [UIImage imageNamed:@"walgreens_logo.gif"];
  self.arrowGraphic.image = [UIImage imageNamed:@"ThankU_graphic"];
  
  self.happenedLabel.text = @"Your donation will go onto a gift card that can only be redeemed for food, clothing, medical, or housing.";
  
  self.arrowGraphic.contentMode = UIViewContentModeScaleAspectFit;
  
  self.sponsorLogo1.contentMode = UIViewContentModeScaleAspectFit;
  self.sponsorLogo2.contentMode = UIViewContentModeScaleAspectFit;
  self.sponsorLogo3.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(IBAction)returnButtonTapped:(id)sender {

  [self dismissViewControllerAnimated:YES completion:nil];

}

@end

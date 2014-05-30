//
//  ProfileViewController.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "ProfileViewController.h"
#import "Person.h"
#import "ThankYouViewController.h"
#import "PayPalMobile.h"

@interface ProfileViewController () <UIAlertViewDelegate, ThankYouDelegate, PayPalPaymentDelegate>

@property (strong, nonatomic, readwrite) PayPalConfiguration *payPalConfiguration;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@property (strong, nonatomic) UIButton *navLogoView;
  //@property (strong, nonatomic) UIImageView *navLogo;
@property (strong, nonatomic) UIImageView *userButton;

@property (strong, nonatomic) UIView *overlayForAlert;

@property NSUInteger donationAmount;

-(IBAction)sliderChanged:(id)sender;
-(IBAction)donateButtonTapped:(id)sender;

@end

@implementation ProfileViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.payPalConfiguration = [[PayPalConfiguration alloc] init];
  
  self.navigationController.navigationBar.barTintColor = kSubBlue;
  
  self.navLogoView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  self.navLogoView.center = CGPointMake(self.navLogoView.superview.center.x, self.navLogoView.superview.center.y);
  
//  NSLog(@"center is %.1f, %.1f", self.navLogoView.superview.center.x, self.navLogoView.superview.center.y);
//  [self.navLogoView addTarget:self action:@selector(navLogoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
  
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
  
  self.overlayForAlert = [[UIView alloc] initWithFrame:self.view.frame];
  self.overlayForAlert.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5];
  
  self.profilePicture.image = self.myPerson.profilePicture;
  self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width * 0.3f;
  self.profilePicture.clipsToBounds = YES;
  
  self.nameLabel.text = self.myPerson.name;
  self.textView.text = self.myPerson.story;
  
  self.donationAmount = 5;
  self.slider.minimumValue = 1;
  self.slider.maximumValue = 25;
  self.slider.value = self.donationAmount;
  [self sliderChanged:self.slider];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}

#pragma mark - PayPalPaymentDelegate methods

-(IBAction)pay {
  
    // Create a PayPalPayment
  PayPalPayment *payment = [[PayPalPayment alloc] init];
  
    // Amount, currency, and description
  payment.amount = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%i.00", self.donationAmount]];
  payment.currencyCode = @"USD";
  payment.shortDescription = [NSString stringWithFormat:@"AppHelpMe member %@", self.myPerson.name];
  
    // Use the intent property to indicate that this is a "sale" payment,
    // meaning combined Authorization + Capture. To perform Authorization only,
    // and defer Capture to your server, use PayPalPaymentIntentAuthorize.
  payment.intent = PayPalPaymentIntentSale;
  
    // Check whether payment is processable.
  if (!payment.processable) {
      // If, for example, the amount was negative or the shortDescription was empty, then
      // this payment would not be processable. You would want to handle that here.
    
    [self handlePaymentCantBeProcessed];
  }
  
    // Create a PayPalPaymentViewController.
  PayPalPaymentViewController *paymentViewController;
  paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                 configuration:self.payPalConfiguration
                                                                      delegate:self];
  
    // Present the PayPalPaymentViewController.
  [self presentViewController:paymentViewController animated:YES completion:nil];
  
}

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
  [self verifyCompletedPayment:completedPayment];
  
    // Dismiss the PayPalPaymentViewController.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
  NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                         options:0
                                                           error:nil];
  
  NSString *testString = [[NSString alloc] initWithData:confirmation encoding:NSUTF8StringEncoding];
  
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
  
//  NSLog(@"confirmation is %@", testString);
}

-(void)handlePaymentCantBeProcessed {
  NSLog(@"payment can't be processed");
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderChanged:(id)sender {
  
  self.donationAmount = self.slider.value;
  self.amountLabel.text = [NSString stringWithFormat:@"$%i", self.donationAmount];
}

-(IBAction)donateButtonTapped:(id)sender {
  [self pay];
  
//  [self.view addSubview:self.overlayForAlert];
//  
//  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Donate $%i to %@", self.donationAmount, self.myPerson.name] message:@"Validated by PayPal.\nComplete payment?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
//  
//  [alertView show];
}

#pragma mark - alert view methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) { // Okay
    [self okayButtonTapped];
    [self.overlayForAlert removeFromSuperview];
  } else if (buttonIndex == [alertView cancelButtonIndex]) {
    [self.overlayForAlert removeFromSuperview];
  }
}

-(void)okayButtonTapped {

  [self performSegueWithIdentifier:@"thankYouSegue" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"thankYouSegue"]) {
    ThankYouViewController *tyVC = (ThankYouViewController *)segue.destinationViewController;
    tyVC.delegate = self;
  }
}

-(Person *)getMyPerson {
  return self.myPerson;
}

@end

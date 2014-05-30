//
//  SplashViewController.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/18/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "SplashViewController.h"
#import "NamesTableViewController.h"
#import "Constants.h"
#import "HowToViewController.h"

@interface SplashViewController () <UIPageViewControllerDataSource>

//@property (strong, nonatomic) UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *discoverButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainLogo;
//@property (weak, nonatomic) IBOutlet UILabel *aboutTextLabel;

@property (weak, nonatomic) IBOutlet UIWebView *youTubeVideo;

@property (strong, nonatomic) NamesTableViewController *namesVC;

@property (strong, nonatomic) UIPageViewController *pageVC;
@property (strong, nonatomic) NSArray *pageInstructions;
@property (strong, nonatomic) NSArray *pageImages;

@end

@implementation SplashViewController

-(void)viewDidLoad {
  
  [super viewDidLoad];

  self.mainLogo.image = [UIImage imageNamed:@"AppHelpMe_pj"];
  self.mainLogo.contentMode = UIViewContentModeScaleAspectFit;
  
  self.pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
  self.pageInstructions = @[@"Donate to the needy with gift cards for food, clothing, and medical.", @"instructions page 2", @"instructions page 3", @"instructions page 4"];
  
    // Create page view controller
  self.pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToPageVC"];
  self.pageVC.dataSource = self;
  
  HowToViewController *startingViewController = [self viewControllerAtIndex:0];
  NSArray *viewControllers = @[startingViewController];
  [self.pageVC setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
  
    // Change the size of page view controller
  self.pageVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 55.f);
  
  [self addChildViewController:self.pageVC];
  [self.view insertSubview:self.pageVC.view belowSubview:self.mainLogo];
  [self.pageVC didMoveToParentViewController:self];
  
  self.youTubeVideo.hidden = YES;
  
//  [self loadYouTubeVideo];
  
//  self.aboutTextLabel.text = @"Donate to the needy with gift cards for food, clothing, and medical.";
}

-(void)loadYouTubeVideo {
  NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=3ATBk9ak_J0"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self.youTubeVideo loadRequest:request];
  
  [self.view addSubview:self.youTubeVideo];
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Page View Controller Data Source

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
  NSUInteger index = ((HowToViewController *) viewController).pageIndex;
  
  if ((index == 0) || (index == NSNotFound)) {
    return nil;
  }
  
  index--;
  return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
  NSUInteger index = ((HowToViewController *) viewController).pageIndex;
  
  if (index == NSNotFound) {
    return nil;
  }
  
  index++;
  if (index == [self.pageInstructions count]) {
    return nil;
  }
  return [self viewControllerAtIndex:index];
}

-(HowToViewController *)viewControllerAtIndex:(NSUInteger)index {
  if (([self.pageInstructions count] == 0) || (index >= [self.pageInstructions count])) {
    return nil;
  }
  
    // Create a new view controller and pass suitable data.
  HowToViewController *howToVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HowToVC"];
  howToVC.imageFile = self.pageImages[index];
  howToVC.instructionText = self.pageInstructions[index];
  howToVC.pageIndex = index;
  
  return howToVC;
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
  return [self.pageInstructions count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
  return 0;
}

@end

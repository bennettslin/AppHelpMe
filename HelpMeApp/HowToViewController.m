//
//  HowToViewController.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/29/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "HowToViewController.h"

@interface HowToViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@end

@implementation HowToViewController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.myImageView.image = [UIImage imageNamed:self.imageFile];
  self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
  self.instructionLabel.text = self.instructionText;
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

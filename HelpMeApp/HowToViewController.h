//
//  HowToViewController.h
//  HelpMeApp
//
//  Created by Bennett Lin on 5/29/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HowToViewController : UIViewController

@property NSUInteger pageIndex;

@property (strong, nonatomic) NSString *instructionText;
@property (strong, nonatomic) NSString *imageFile;

@end

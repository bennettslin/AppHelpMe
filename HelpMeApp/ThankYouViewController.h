//
//  ThankYouViewController.h
//  HelpMeApp
//
//  Created by Bennett Lin on 5/18/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;

#define kOrange [UIColor colorWithRed:1.f green:0.63f blue:0.176f alpha:1.f]
#define kVibrantBlue [UIColor colorWithRed:0.105f green:0.07f blue:.623f alpha:1.f]
#define kSubBlue [UIColor colorWithRed:0.047f green:0.313f blue:0.439f alpha:1.f]

@protocol ThankYouDelegate;

@interface ThankYouViewController : UIViewController

@property (strong, nonatomic) Person *myPerson;
@property (weak, nonatomic) id <ThankYouDelegate> delegate;

@end

@protocol ThankYouDelegate <NSObject>

-(Person *)getMyPerson;

@end
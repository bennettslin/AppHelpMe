//
//  NameTableViewCell.h
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;

@interface NameTableViewCell : UITableViewCell

@property (strong, nonatomic) Person *myPerson;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;

-(void)setProperties;

@end

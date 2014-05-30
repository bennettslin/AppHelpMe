//
//  NameTableViewCell.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "NameTableViewCell.h"
#import "Person.h"

@implementation NameTableViewCell

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setProperties {
  self.profilePicture.image = self.myPerson.profilePicture;
  self.nameLabel.text = self.myPerson.name;
  self.ageLabel.text = [NSString stringWithFormat:@"Age %i", self.myPerson.age];
  
  self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width * 0.3f;
  self.profilePicture.clipsToBounds = YES;
  self.storyLabel.text = self.myPerson.story;
}

@end

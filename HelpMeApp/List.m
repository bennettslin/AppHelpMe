//
//  List.m
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import "List.h"
#import "Person.h"

@implementation List

-(id)init {
  self = [super init];
  if (self) {
    self.people = @[];
  }
  return self;
}

-(void)populateData {
  
    // hard coded values for now
  NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:9];
  NSArray *peopleList = @[@"Chris034",
                          @"Danielle321",
                          @"John053",
                          @"Heather002",
                          @"Kitty036",
                          @"Lucas499",
                          @"Lucy325",
                          @"Martin029",
                          @"Robert892",
                          @"Steve901",
                          @"Stark409",
                          @"SuperMatt642",
                          @"SpacePirate611"];
  
  NSArray *pictureList = @[@"Chris034",
                           @"HoldingSignDanielle",
                           @"John053",
                           @"Heather",
                           @"Kitty",
                           @"Lucas976",
                           @"Lucy325",
                           @"Martin029",
                           @"Robert892",
                           @"Steve",
                           @"Stark409",
                           @"SuperMatt",
                           @"SpacePirate"];
  
  NSArray *ageList = @[@34, @23, @52, @32, @26, @48, @41, @34, @39, @58, @38, @29, @23];
  
//  NSMutableArray *storyList = @[@"
//                         @"I lost my family in a car accident last year. I need money for college textbooks.", ];
  
  NSMutableArray *storyList = [[NSMutableArray alloc] initWithCapacity:13];
  for (int i = 0; i < 13; i++) {
    
    NSString *story = @"I lost my family in a car accident last year. I need money for college textbooks.";
    if (i == 0) {
      story = @"I need to eat. I need your help.";
    } else if (i == 2) {
      story = @"My humility is gone. I went through a bad divorce. Then I got hit by a car.";
    } else if (i == 3) {
      story = @"I got hooked on crack and lost everything to that drug. I want to change.";
    }
    
    
    [storyList addObject:story];
  }
  
  
  for (int i = 0; i < 10; i++) {
    Person *person = [[Person alloc] init];
    person.name = peopleList[i];
    person.gender = kMale;
    person.age = [ageList[i] integerValue];
    person.profilePicture = [UIImage imageNamed:pictureList[i]];
    person.story = storyList[i];
    
      // add other values here
    
    
    [mutableArray addObject:person];
  }
  
  self.people = [NSArray arrayWithArray:mutableArray];
}

@end

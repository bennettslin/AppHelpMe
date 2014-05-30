//
//  Person.h
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

typedef enum gender {
  kMale,
  kFemale
} Gender;

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property Gender gender;
@property (strong, nonatomic) NSDate *birthDate;

  // this number will eventually come from birthdate
@property NSUInteger age;

@property (strong, nonatomic) NSNumber *zipCode;
@property (strong, nonatomic) NSNumber *pickupLocation;
@property (strong, nonatomic) NSNumber *primaryKey;
@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) UIImage *profilePicture;

@end

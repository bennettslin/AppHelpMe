//
//  List.h
//  HelpMeApp
//
//  Created by Bennett Lin on 5/17/14.
//  Copyright (c) 2014 Bennett Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject

@property (strong, nonatomic) NSArray *people;

-(void)populateData;

@end

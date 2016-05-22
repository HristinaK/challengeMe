//
//  Challenge.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@interface Challenge : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *challenges;

+ (NSString *)parseClassName;

@end

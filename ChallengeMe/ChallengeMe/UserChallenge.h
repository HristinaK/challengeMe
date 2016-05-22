//
//  UserChallenge.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@interface UserChallenge : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *uchallenge;

+ (NSString *)parseClassName;

@end

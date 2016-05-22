//
//  UserPunishment.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "UserPunishment.h"

@implementation UserPunishment

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"UserPunishment";
}

@dynamic upunishment;


@end

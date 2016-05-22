//
//  UserChallenge.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "UserChallenge.h"

@implementation UserChallenge

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"UserChallenge";
}

@dynamic uchallenge;

@end

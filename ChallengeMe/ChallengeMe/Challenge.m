//
//  Challenge.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "Challenge.h"

@implementation Challenge

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Challenge";
}

@dynamic challenges;


@end

//
//  Punishment.m
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import "Punishment.h"

@implementation Punishment

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Punishment";
}

@dynamic punishments;

@end

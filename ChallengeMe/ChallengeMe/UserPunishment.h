//
//  UserPunishment.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/16/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@interface UserPunishment : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *upunishment;

+ (NSString *)parseClassName;
@end

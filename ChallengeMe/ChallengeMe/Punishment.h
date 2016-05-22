//
//  Punishment.h
//  ChallengeMe
//
//  Created by Nikola Angelkovik on 6/2/15.
//  Copyright (c) 2015 Nikola Angelkovik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"

@interface Punishment : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *punishments;

+ (NSString *)parseClassName;

@end

/*
 * Copyright (C) 2015 by 3P Development.
 * All rights reserved.
 *
 * The copyright to the computer program(s) herein is the property of
 * 3P Development, Republic of Macedonia. The program(s) may be used and/or copied
 * only with the written permission of 3P Development or in accordance
 * with the terms and conditions stipulated in the agreement/contract
 * under which the program(s) have been supplied.
 */

#import <Foundation/Foundation.h>

@interface AbstractConfigurationManager : NSObject
+ (NSNumber *)logLevel;
+ (id)get:(NSString *)keyPath;
+ (NSURL *)addParameters:(NSDictionary *)parameters
             toURLString:(NSString *)URLString
     relativeToURLString:(NSURL *)relativeURL;
+ (NSURL *)urlForKey:(NSString *)key parameters:(NSDictionary *)param;
@end

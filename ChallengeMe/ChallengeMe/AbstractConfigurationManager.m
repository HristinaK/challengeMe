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

#import "AbstractConfigurationManager.h"
#import "TemplateSingleton.h"
#import "NSString+Utils.h"
#import "NSData+Security.h"
#import "NSString+Utils.h"

static  NSDictionary *defaultConfiguration = nil;
static  NSDictionary *modeConfiguration;
static NSDictionary *infoPlistConfiguration;

@implementation AbstractConfigurationManager
+ (void)initialize
{
    if (self == [AbstractConfigurationManager class]) {
        NSString *infoPlistFilePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoPlistConfiguration = [NSDictionary dictionaryWithContentsOfFile:infoPlistFilePath];
        
        NSString *configurationPath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
        defaultConfiguration = [[NSDictionary alloc] initWithContentsOfFile:configurationPath];
#if DEVELOPMENT
        modeConfiguration = [[defaultConfiguration objectForKey:@"modes"] objectForKey:@"development"];
#else
        modeConfiguration = defaultConfiguration;
#endif
    }
}

+ (NSString *)queryParametersStringFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *keyValuePairs = [NSMutableArray array];
    
    for (NSString *key in dictionary) {
        NSString *value = [dictionary valueForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            for (NSString *valueInArray in (NSArray *)value) {
                NSString *pair = [NSString stringWithFormat:@"%@=%@",
                                  [key stringByPreparingForURL],
                                  [valueInArray stringByPreparingForURL]];
                [keyValuePairs addObject:pair];
            }
        } else {
            NSString *pair = [NSString stringWithFormat:@"%@=%@",
                              [key stringByPreparingForURL],
                              [value stringByPreparingForURL]];
            [keyValuePairs addObject:pair];
        }
    }
    
    return [keyValuePairs componentsJoinedByString:@"&"];
}

+ (NSString *)stringByAppendingParameters:(NSDictionary *)parameters toURLString:(NSString *)URLString
{
    if (URLString.length > 0) {
        if ([URLString containsString:@"?"]) {
            NSString *escapedQueryParametersString = [self queryParametersStringFromDictionary:parameters];
            if ([escapedQueryParametersString length] > 0) {
                URLString = [URLString stringByAppendingFormat:@"&%@", escapedQueryParametersString];
            }
            return URLString;
        } else {
            NSString *escapedQueryParametersString = [self queryParametersStringFromDictionary:parameters];
            URLString = [URLString stringByAppendingFormat:@"?%@", escapedQueryParametersString];
            return URLString;
        }
    }
    return URLString;
}

+ (NSURL *)addParameters:(NSDictionary *)parameters toURLString:(NSString *)URLString relativeToURLString:(NSURL *)relativeURL
{
    if (URLString.length > 0) {
        if ([URLString containsString:@"?"]) {
            NSString *escapedQueryParametersString = [self queryParametersStringFromDictionary:parameters];
            if ([escapedQueryParametersString length] > 0) {
                URLString = [URLString stringByAppendingFormat:@"&%@", escapedQueryParametersString];
            }
            if (relativeURL) {
                return [[NSURL alloc] initWithString:URLString relativeToURL:relativeURL];
            }
            return [[NSURL alloc] initWithString:URLString];
        } else {
            NSString *escapedQueryParametersString = [self queryParametersStringFromDictionary:parameters];
            URLString = [URLString stringByAppendingFormat:@"?%@", escapedQueryParametersString];
            if (relativeURL) {
                return [[NSURL alloc] initWithString:URLString relativeToURL:relativeURL];
            }
            return [[NSURL alloc] initWithString:URLString];
        }
    }
    if (relativeURL) {
        return [[NSURL alloc] initWithString:URLString relativeToURL:relativeURL];
    }
    return [[NSURL alloc] initWithString:URLString];
}

+ (id)getWithoutEncryption:(NSString *)keyPath
{
    id result = [modeConfiguration objectForKey:keyPath];
    if (!result) {
        result = [defaultConfiguration objectForKey:keyPath];
    }
    return result;
}

+ (id)get:(NSString *)keyPath
{
    id result = [self getWithoutEncryption:keyPath];
    
    if (!result) {
        NSString *obfuscatedKeyPath = [NSString stringWithFormat:@"%@[encrypted]", keyPath];
        if ([self getWithoutEncryption:obfuscatedKeyPath]) {
            result = [self decryptedValueForKey:obfuscatedKeyPath];
        }
    }
    
    return result;
}

+ (id)decryptedValueForKey:(NSString *)key
{
    NSString *base64EncryptedString = [AbstractConfigurationManager get:key];
    NSString *decrypted = nil;
    if (base64EncryptedString) {
        NSData *aesEncriptedValue = [NSData dataWithBase64EncodedString:base64EncryptedString];
        NSData *decryptedBytes = [aesEncriptedValue AES256Decrypt];
        if (decryptedBytes) {
            decrypted = [[NSString alloc] initWithData:decryptedBytes
                                              encoding:NSUTF8StringEncoding];
        }
    }
    return decrypted;
    
}

+ (NSNumber *)logLevel
{
    return [self get:@"logLevel"];
}

+ (NSURL *)urlForKey:(NSString *)key parameters:(NSDictionary *)param
{
    NSString *urlAsString = [self get:key];
    NSURL *url;
    if (param) {
        url = [self addParameters:param toURLString:urlAsString relativeToURLString:nil];
    } else {
        url = [NSURL URLWithString:urlAsString];
    }
    
    if (![url baseURL]) {
        NSURL *baseUrl = [NSURL URLWithString:[self get:@"baseURL"]];
        if (param) {
            url = [self addParameters:param toURLString:urlAsString relativeToURLString:baseUrl];
        } else {
            url = [[NSURL alloc] initWithString:urlAsString relativeToURL:baseUrl];
        }
    }
    
    return url;
}

@end
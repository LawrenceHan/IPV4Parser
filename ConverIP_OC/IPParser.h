//
//  IPParser.h
//  ConverIP_OC
//
//  Created by Hanguang on 2018/12/25.
//  Copyright © 2018 hanguang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RuleNo1 @"You can only iterate the string once."
#define RuleNo2 @"You should handle spaces correctly: a string with spaces between a digit and a dot is a valid input; while a string with spaces between two digits is not."

#define SpaceError @"Spaces between digits is not valid."
#define CharacterError @"Invalid character."

extern const uint32 validResult;

#ifdef __cplusplus
extern "C" {
#endif
    uint32_t ipv4ParseCStyle(const char *ip);
    uint32_t ipv4ParseCStyleEnhanced(const char *ip);
    uint32_t ipv4ParseFoundation(const char *ip);
#ifdef __cplusplus
}
#endif


//
//  IPParser.m
//  ConverIP_OC
//
//  Created by Hanguang on 2018/12/25.
//  Copyright © 2018 hanguang. All rights reserved.
//

#import "IPParser.h"

const uint32 validResult = 2896692481;

uint32_t ipv4ParseCStyle(const char *ip) {
    uint8_t bytes[4] = {};
    int i = 0;
    int8_t j = 3;
    
    while (ip[i] != '\0') {
        char c = ip[i];
        
        if (c >= '0' && c <= '9') { // handle digits
            bytes[j]= bytes[j]*10 + atoi(&c);
        } else if (c == '.') { // handle dot
            j--;
        } else if (c == ' ') { // handle spaces (plural)
            // I could use strlen, but it would violate RuleNo1 (check header for details)
            int validIndex = i > 0 ? i-1 : 0;
            char lastCharacter = ip[validIndex];
            
            validIndex = ip[i+1] == '\0' ? i : i+1;
            char nextCharacter = ip[validIndex];
            
            if (isdigit(lastCharacter) && isdigit(nextCharacter)
                && lastCharacter != '.' && nextCharacter != '.') {
                return 0;
            }
        } else {
            return 0;
        }
        i++;
    }
    
    // bitwise is my favourite
    return bytes[3] << 24
    | bytes[2] << 16
    | bytes[1] << 8
    | bytes[0];
}

uint32_t ipv4ParseFoundation(const char *ip) {
    NSString *ipv4 = [[NSString alloc] initWithUTF8String:ip];
    ipv4 = [ipv4 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray *separated = [[ipv4 componentsSeparatedByString:@"."] mutableCopy];
    
    for (int i = 0; i < separated.count; i++) {
        separated[i] = [separated[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *string = separated[i];
        NSRange range = [string rangeOfString:@" "];
        if (range.location != string.length-1 && range.location != 0
            && range.location != NSNotFound) {
            return 0;
        }
    }
    
    if (separated.count != 4) {
        return 0;
    }
    
    return [separated[0] intValue] << 24
    | [separated[1] intValue] << 16
    | [separated[2] intValue] << 8
    | [separated[3] intValue];
}

//
//  main.m
//  ConverIP_OC
//
//  Created by Hanguang on 2018/12/25.
//  Copyright © 2018 hanguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // The problem is:
        // Convert an IPv4 address in the format of null-terminated C string into a 32-bit integer.
        
        // The tricky part is, 2896692481 is over int32
        // in fact int32 include -2147483648 to 2147483647
        // but uint32 include 0 to 4294967295
        // Quote from wikipedia "IPv4 uses 32-bit addresses which limits the address space to 4294967296 (232) addresses."
        // A-ha!
        
        NSString *ip = @"     172.   168    . 5. 1 ";
        
        
        // if we runs over 10,000 times, C style win
        CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
        for (int i=0; i<10000; i++) {
            ipv4ParseCStyle(ip.UTF8String);
        }
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent()-start;
        
        printf("ipv4ParseCStyle runs 10,000 times, costs: %f\n", end);
        
        start = CFAbsoluteTimeGetCurrent();
        for (int i=0; i<10000; i++) {
            ipv4ParseFoundation(ip.UTF8String);
        }
        end = CFAbsoluteTimeGetCurrent()-start;
        
        printf("ipv4ParseFoundation runs 10,000 times, costs: %f\n", end);
        
        
        // if we runs over 1,000,000 times, Foundation win
        start = CFAbsoluteTimeGetCurrent();
        for (int i=0; i<1000000; i++) {
            ipv4ParseCStyle(ip.UTF8String);
        }
        end = CFAbsoluteTimeGetCurrent()-start;
        
        printf("ipv4ParseCStyle runs 1,000,000 times, costs: %f\n", end);
        
        start = CFAbsoluteTimeGetCurrent();
        for (int i=0; i<10000; i++) {
            ipv4ParseFoundation(ip.UTF8String);
        }
        end = CFAbsoluteTimeGetCurrent()-start;
        
        printf("ipv4ParseFoundation runs 1,000,000 times, costs: %f\n", end);
    }
    return 0;
}

//
//  IPParserTest.m
//  IPParserTest
//
//  Created by Hanguang on 2018/12/25.
//  Copyright © 2018 hanguang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IPParser.h"

@interface IPParserTest : XCTestCase

@end

@implementation IPParserTest {
    NSString *_ip;
}

- (void)setUp {
    _ip = @"172.168.5.1";
}

- (void)tearDown {
    _ip = nil;
}

- (void)testNormalCase {
    // a standard ipv4 string should be parsed correctly.
    // the result should be 2896692481
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result > 0);
}

- (void)testSpaceInFront {
    _ip = @" 172.168.5.1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == validResult);
}

- (void)testMultipleSpaceInFront {
    _ip = @"    172.168.5.1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == validResult);
}

- (void)testSpacesBetweenDigitAndDot {
    _ip = @"172 .168  .5  .1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == validResult);
}

- (void)testSpacesInLast {
    _ip = @"172.168.5.1   ";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == validResult);
}

- (void)testCombinedCases {
    _ip = @"  172 .   168.   5. 1 ";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == validResult);
}

- (void)testSpaceBetweenDigits {
    _ip = @"  17 2.16 8.5.1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == 0);
}

- (void)testSpacesBetweenDigits {
    _ip = @"1 7 2.1  6 8.5.1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == 0);
}

- (void)testCombinedSpacesBetweenDigits {
    _ip = @"  17 2.1  68.5    .1  ";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    XCTAssert(result == 0);
}

- (void)testMoreThanOneSpaceBetweenDigitFails {
    _ip = @"17  2.168.5.1";
    uint32 result = ipv4ParseCStyle(_ip.UTF8String);
    // the ipv4ParseCStyle doesn't cover more than 1 spaces between digit
    XCTAssert(result == 0);
}

@end

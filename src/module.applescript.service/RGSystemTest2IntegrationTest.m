// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AppleScriptService.h"

#import "CALog.h"

#import "HLIntegrationTestUtilities.h"

#import "RGSystemTest2IntegrationTest.h"
#import "RGSystemTest2Proxy.h"

@implementation RGSystemTest2IntegrationTest

-(void)test1 {
    
    Log_enteredMethod();
    
}

-(void)test_ping {

    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"system-test.2"];
    [appleScriptService autorelease];
    
    id<HLService> service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    
    RGSystemTest2Proxy* proxy = [[RGSystemTest2Proxy alloc] initWithService:service];

    [proxy ping];

}

-(void)test_get_current_date {

    Log_enteredMethod();

    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"system-test.2"];
    [appleScriptService autorelease];
    
    id<HLService> service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    
    RGSystemTest2Proxy* proxy = [[RGSystemTest2Proxy alloc] initWithService:service];
    
    NSNumber* timeSinceEpoc = [proxy get_current_date];
    STAssertNotNil( timeSinceEpoc, @"timeSinceEpoc = %p", timeSinceEpoc);
    
    NSDate* currentDate = [NSDate dateWithTimeIntervalSince1970:[timeSinceEpoc longValue]];
    Log_debugString( [currentDate description] );
}

-(void)test_divide {

    Log_enteredMethod();
    
    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"system-test.2"];
    [appleScriptService autorelease];
    
    id<HLService> service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    
    RGSystemTest2Proxy* proxy = [[RGSystemTest2Proxy alloc] initWithService:service];
    
    NSNumber* numerator = [NSNumber numberWithInt:4];
    NSNumber* denominator = [NSNumber numberWithInt:2];
    
    NSNumber* response = [proxy divideNumerator:numerator denominator:denominator];
    STAssertTrue( 2 == [response integerValue], @"[response integerValue] = %d", [response integerValue]);

}


@end

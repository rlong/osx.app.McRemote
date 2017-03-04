// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"

#import "RGAppleScriptServiceHelper.h"

@implementation RGAppleScriptServiceHelper


+(NSString*)serviceNameForScript:(NSString*)scriptName {

    NSString* answer = [NSString stringWithFormat:@"remote_gateway.AppleScriptService:%@", scriptName];
    Log_debugString(answer);
    
    return answer;
    
    
}

@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonArray.h"

@interface AppleScript : NSObject {
	
	
	
}


#pragma mark - instance setup/teardown

-(id)initWithScriptName:(NSString*)scriptName;

- (id)initWithSource:(NSString *)source;

#pragma mark -

-(id)executeMethodWithName:(NSString*)methodName parameters:(CAJsonArray*)parameters;

@end

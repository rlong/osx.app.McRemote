// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AppleScript.h"

@interface LoginItemsHelper : NSObject {

	AppleScript* _appleScript;
	//@property (nonatomic, retain) AppleScript* appleScript;
	//@synthesize appleScript = _appleScript;
	
	NSString* _applicationPath; 
	//@property (nonatomic, retain) NSString* applicationPath;
	//@synthesize applicationPath = _applicationPath;
	
	
}

-(void)addApplicationToLoginItems;

-(BOOL)isApplicationInLoginItems;

-(void)removeApplicationFromLoginItems;


@end

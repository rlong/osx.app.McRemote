// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "AppleScript.h"
#import "HLDescribedService.h"

@interface AppleScriptService : NSObject <HLDescribedService> {

    
    // scriptName
	NSString* _scriptName;
	//@property (nonatomic, retain) NSString* scriptName;
	//@synthesize scriptName = _scriptName;

    
    // serviceDescription
	HLServiceDescription* _serviceDescription;
	//@property (nonatomic, retain) ServiceDescription* serviceDescription;
	//@synthesize serviceDescription = _serviceDescription;

    // script
	AppleScript* _script;
	//@property (nonatomic, retain) AppleScript* script;
	//@synthesize script = _script;

    
}

#pragma mark instance lifecycle


-(id)initWithScriptName:(NSString*)scriptName;

#pragma mark -

-(id)executeMethodWithName:(NSString*)methodName parameters:(CAJsonArray*)parameters;


@end

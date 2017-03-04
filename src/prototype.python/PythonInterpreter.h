// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import <Cocoa/Cocoa.h>

#import "PythonModule.h"
#import "PythonRuntimeHelper.h"

@interface PythonInterpreter : NSObject {
	
	
	PythonRuntimeHelper *_runtimeHelper;
	//@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
	//@synthesize runtimeHelper = _runtimeHelper;
	
	
}


-(PythonModule*)loadModule:(NSString*)moduleName;

@end

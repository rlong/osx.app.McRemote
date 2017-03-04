// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"

#import "PythonTests.h"
#import "PythonInterpreter.h"


@implementation PythonTests


static PythonInterpreter* _interpreter; 
static PythonModule* _module;

+(void)initialize {
	
	_interpreter = [[PythonInterpreter alloc] init];
	_module = [[_interpreter loadModule:@"PythonTests"] retain];
}


-(void)test1 {
	
	[Log entered:__func__];
	
}

-(void)testCallMethods {
	
	[_module callMethods];
	[Log entered:__func__];
	
}

@end

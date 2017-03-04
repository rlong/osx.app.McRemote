// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Cocoa/Cocoa.h>
#import <Python/Python.h>

#import "PythonRuntimeHelper.h"

@interface PythonModule : NSObject {

	
	//PyObject *_pName, *_pModule;
	
	PyObject* _pythonModule;
	
	NSString* _moduleName;
	//@property (nonatomic, retain) NSString* moduleName;
	//@synthesize moduleName = _moduleName;
	
	
	PythonRuntimeHelper *_runtimeHelper;
	//@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
	//@synthesize runtimeHelper = _runtimeHelper;
	
}

-(void)callMethods;
-(void)callHttpGet;

#pragma mark instance lifecycle

-(id)initWithModule:(PyObject*)pythonModule moduleName:(NSString*)moduleName runtimeHelper:(PythonRuntimeHelper*)runtimeHelper;

@end

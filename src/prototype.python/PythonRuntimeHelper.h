// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Python/Python.h>


@interface PythonRuntimeHelper : NSObject {

	PyObject* _tracebackModule;

}

-(void)checkForPythonError;


@end

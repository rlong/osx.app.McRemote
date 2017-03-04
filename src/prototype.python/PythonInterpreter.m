// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import <Python/Python.h>

#import "CALog.h"

#import "PythonInterpreter.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PythonInterpreter () 

//PythonRuntimeHelper *_runtimeHelper;
@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
//@synthesize runtimeHelper = _runtimeHelper;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation PythonInterpreter


-(BOOL)pythonErrorOccurredOnCallTo:(NSString*)pythonMethod fromCaller:(const char*)caller; { 
	BOOL answer = false;
	
	if( NULL != PyErr_Occurred() ) {
		answer = true;
        Log_warnString( pythonMethod );
        Log_warnString( [NSString stringWithUTF8String:caller] );
		PyErr_Print();
		PyErr_Clear();

	}
	
	return answer;
}

-(PythonModule*)loadModule:(NSString*)moduleName {
	
	
	const char* utf8ModuleName = [moduleName UTF8String];
	
	PyObject *pythonModuleName = NULL;
	PyObject *pythonModule = NULL;
	
	PythonModule* answer = NULL;
	
	@try {
		
		pythonModuleName = PyString_FromString( utf8ModuleName );
		pythonModule = PyImport_Import(pythonModuleName);
        Log_debugPointer( pythonModule );
		
		if( nil == pythonModule ) {
			PyErr_Print();
			return nil;
		}
		answer = [[PythonModule alloc] initWithModule:pythonModule moduleName:moduleName runtimeHelper:_runtimeHelper];
	}
	@finally {
		
		Py_DECREF(pythonModuleName);
		Py_DECREF(pythonModule);
		
	}
	
	return answer;
	
}

-(id)init {

    Log_enteredMethod();
	
	PythonInterpreter* answer = [super init];
	
	if( Py_IsInitialized() ) {
        Log_info( @"Py_IsInitialized()"  );
	} else {
		Py_Initialize();
		
		
		{
			// vvv http://www.gossamer-threads.com/lists/python/dev/675857
			PyObject* pathList = PySys_GetObject("path");
			if( [self pythonErrorOccurredOnCallTo:@"PySys_GetObject" fromCaller:__func__] ) {
				return answer;
			}
			
            Log_debugUtf8String( pathList->ob_type->tp_name );
			
			if( !PyList_Check( pathList ) ) {
                Log_warn( @"!PyList_Check( pathList )" );
				return answer;
			}
			
			Py_ssize_t pathListSize = PyList_Size(pathList);
            Log_debugLongLong( pathListSize );
			   
			
			for( int i = 0; i < pathListSize; i++ ) {
				PyObject* pathEntry = PyList_GetItem(pathList, i);
				if( PyString_Check( pathEntry ) ) {
                    Log_debugUtf8String( PyString_AsString(pathEntry) );
				}
			}
			
			NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
			PyObject* pythonResourcePath = PyString_FromString( [resourcePath UTF8String] );
            Log_debugUtf8String( PyString_AsString(pythonResourcePath) );
			
			// ^^^ http://www.gossamer-threads.com/lists/python/dev/675857
			PyList_Append(pathList, pythonResourcePath);

//			Py_ssize_t pathListSize = PyList_Size(pathList);
//			[Log debugLong:pathListSize withName:@"pathListSize" inFunction:__func__];
//			
//			for( int i = 0; i < pathListSize; i++ ) {
//				PyObject* pathEntry = PyList_GetItem(pathList, i);
//			}
			
		}
	}
	
	_runtimeHelper = [[PythonRuntimeHelper alloc] init];
	
	return answer;
	
}

-(void)dealloc {
	
	Py_Finalize();
	
	[self setRuntimeHelper:nil];
	
}

#pragma mark fields

//PythonRuntimeHelper *_runtimeHelper;
//@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
@synthesize runtimeHelper = _runtimeHelper;


@end

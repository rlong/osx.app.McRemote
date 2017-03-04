// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"

#import "PythonRuntimeHelper.h"


@implementation PythonRuntimeHelper

// format: (filename, line number, function name, text)
// example: ('python_functions.py', 11, 'div0', 'return 0/0')
-(NSArray*)extractStackFrame:(PyObject*)stackFrame {
	
	if( !PyTuple_Check( stackFrame ) ) {
        Log_warn( @"!PyTuple_Check( stackFrame )" );
		return nil;
		
	}
	
	long size = PyTuple_Size( stackFrame );
	
	if( 4 != size ) {
        Log_warnInt( size );
		return nil;
	}
	
	
	PyObject* pyFilename = PyTuple_GetItem( stackFrame, 0);
	NSString* filename = nil;
	
	if( ! PyString_Check( pyFilename ) ) {
        Log_warn( @"! PyString_Check( filename )" );
		return nil;
	} else {
		filename = [NSString stringWithUTF8String:PyString_AsString( pyFilename )];
	}

	PyObject* pyLineNumber = PyTuple_GetItem( stackFrame, 1);
	NSString* lineNumber  = nil;
	// [Log debugUTF8String:lineNumber->ob_type->tp_name withName:@"lineNumber->ob_type->tp_name" inFunction:__func__];
	if( ! PyNumber_Check(pyLineNumber) ) {
        Log_warn( @"! PyString_Check( filename )" );
		return nil;
	} else {
		lineNumber = [NSString stringWithFormat:@"%ld", PyInt_AsLong( pyLineNumber )];
	}

	
	PyObject* pyFunctionName = PyTuple_GetItem( stackFrame, 2);
	NSString* functionName = nil;
	if( !  PyString_Check( pyFunctionName ) ) {
        Log_warn(@"!  PyString_Check( functionName )" );
		return nil;
	} else {
		functionName = [NSString stringWithUTF8String:PyString_AsString( pyFunctionName )];
	}
	
	PyObject* pyText = PyTuple_GetItem( stackFrame, 3);
	NSString* text = nil;
	if( ! PyString_Check( pyText ) ) {
        Log_warn( @"! PyString_Check( pyText )" );
		return nil;
	} else {
		text = [NSString stringWithUTF8String:PyString_AsString(pyText)];
	}
	
//	NSString* message = [NSString stringWithFormat:@"file: %@; line-number: %@; method-name: %@; line-text: %@", filename, lineNumber, functionName, text];
//	[Log warn:message inFunction:__func__];
	
	NSArray* answer = [NSArray arrayWithObjects:filename, lineNumber, functionName, text, nil];
	return answer;
}

-(NSArray*)extractStackTrace:(PyObject*)stackTrace {
	
	//[Log debugPointer:stackTrace withName:@"stackTrace" inFunction:__func__];
	if( NULL == stackTrace ) {
        Log_warn(@"NULL == stackTrace" );
		return nil;
	}
	// [Log debugUTF8String:stackTrace->ob_type->tp_name withName:@"stackTrace->ob_type->tp_name" inFunction:__func__];
	
	if( !PyList_Check( stackTrace )  ){
        Log_warn( @"!PyList_Check( stackTrace )" );
		return nil;
	}
	
	long size = PyList_Size( stackTrace );
    Log_debugLongLong( size);
	
	NSMutableArray* answer = [[NSMutableArray alloc] init];

	for( int i = 0; i < size; i++ ) {
		PyObject* stackFrame = PyList_GetItem( stackTrace, i);
		NSArray* frame = [self extractStackFrame:stackFrame];
		if( nil == frame ) { 
            Log_warn( @"nil == frame" );
			return nil; // will not return a partial stack trace 
		} else {
			[answer addObject:frame];
		}
		
	}
	
	return answer;
}



-(PyObject*)extract_tb:(PyObject*)traceback {
	
	
	if( nil == _tracebackModule ) {
        Log_warn( @"nil == _tracebackModule" );
		return nil;
	}
	if( nil == traceback ) {
        Log_warn( @"nil == traceback" );
		return nil;
	}
	
	PyObject* tracebackModuleDictionary = PyModule_GetDict(_tracebackModule);
	
	PyObject* extract_tb = PyDict_GetItemString(tracebackModuleDictionary,"extract_tb");
	if( nil == extract_tb ) {
        Log_warn( @"nil == extract_tb" );
		return nil;
		
	}
	
	PyObject* args = NULL;
	PyObject* answer = NULL;
	
	@try {
		args = PyTuple_New(1);
		PyTuple_SetItem(args, 0, traceback);
		answer = PyObject_CallObject(extract_tb, args);
		//[self extractStackTrace:response];
	}
	@finally {
		if( NULL != args ) Py_DECREF( args );
		// if( NULL != response ) Py_DECREF( response );
	}
	
	return answer;
	
}
//
//-(void)dumpTraceback:(PyObject*)traceback {
//	
//	if( nil == _tracebackModule ) {
//		[Log warn:@"nil == _tracebackModule" inFunction:__func__];
//		return;
//	}
//	if( nil == traceback ) {
//		[Log warn:@"nil == traceback" inFunction:__func__];
//		return;
//	}
//	
//	PyObject* tracebackModuleDictionary = PyModule_GetDict(_tracebackModule);
//	
//	PyObject* extract_tb = PyDict_GetItemString(tracebackModuleDictionary,"extract_tb");
//	if( nil == extract_tb ) {
//		[Log warn:@"nil == extract_tb" inFunction:__func__];
//		return;
//		
//	}
//	
//	PyObject* args = NULL;
//	PyObject* response = NULL;
//	
//	@try {
//		args = PyTuple_New(1);
//		PyTuple_SetItem(args, 0, traceback);
//		response = PyObject_CallObject(extract_tb, args);
//		[self extractStackTrace:response];
//		
//
//	}
//	@finally {
//		if( NULL != args ) Py_DECREF( args );
//		if( NULL != response ) Py_DECREF( response );
//	}
//
//	
//}


-(void)checkForPythonError {
	
	if( PyErr_Occurred() ) {
        Log_warn( @"PyErr_Occurred()" );
		
		PyObject* ptype = 0;
		PyObject* pvalue = 0;
		PyObject* ptraceback = 0;
		
		PyErr_Fetch( &ptype, &pvalue, &ptraceback );
		PyErr_NormalizeException( &ptype, &pvalue, &ptraceback );
		
				
		PyObject* pythonStackTrace = [self extract_tb:ptraceback];
        Log_debugPointer( pythonStackTrace);
		NSArray* stackTrace = [self extractStackTrace:pythonStackTrace];
        if( nil == stackTrace ) {
            Log_warn( @"nil == stackTrace" );
        } else {
			for( NSArray* stackFrame in stackTrace ) {
				NSString* filename = [stackFrame objectAtIndex:0];
				NSString* lineNumber = [stackFrame objectAtIndex:1];
				NSString* functionName = [stackFrame objectAtIndex:2];
				NSString* text = [stackFrame objectAtIndex:3];
				NSString* message = [NSString stringWithFormat:@"file: %@; line-number: %@; method-name: %@; line-text: %@", filename, lineNumber, functionName, text];
                Log_error( message );
			}
		}
		
		
        Log_warn( @"TODO: BE40EE1A-907F-438B-BCC7-5997F6ED74F3" );
		// TODO: BE40EE1A-907F-438B-BCC7-5997F6ED74F3
		//see if the errno is available in the pvalue and use it to build an NSError which will go into an exceptio
		//	* need to cope with when null is returned as part of the stack trace 
		
		
		if( NULL != pvalue ) {

            Log_debugUtf8String( pvalue->ob_type->tp_name );
            Log_debugUtf8String( PyString_AsString(PyObject_Str( pvalue )) );
			
			
		}
		
        Log_debugPointer( ptraceback );
		if( NULL != ptraceback ) {
			
			// [self dumpTraceback:ptraceback];
            Log_debugUtf8String( ptraceback->ob_type->tp_name );
		}
		
		
		//PyErr_Print();
	}
}


#pragma mark instance lifecycle 

-(id)init {
	
	
	PythonRuntimeHelper* answer = [super init];

	PyObject *tracebackModuleName = PyString_FromString( "traceback" );
	answer->_tracebackModule = PyImport_Import(tracebackModuleName);

    Log_debugPointer( answer->_tracebackModule );
	
	if( nil == _tracebackModule ) {
        Log_warn( @"nil == _tracebackModule" );
		PyErr_Print();
	}
	

	
	return answer;
	

}

-(void)dealloc {
	
	Py_DECREF( _tracebackModule );
	
}


#pragma mark fields



@end

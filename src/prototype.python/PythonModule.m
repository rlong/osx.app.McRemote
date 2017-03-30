// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CABaseException.h"
#import "CALog.h"

#import "PythonModule.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PythonModule () 



//NSString* _moduleName;
@property (nonatomic, retain) NSString* moduleName;
//@synthesize moduleName = _moduleName;


//PythonRuntimeHelper *_runtimeHelper;
@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
//@synthesize runtimeHelper = _runtimeHelper;

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -



@implementation PythonModule



-(void)callMethods {
	
	
	PyObject* pDict = PyModule_GetDict(_pythonModule);
    Log_debugPointer( pDict );

	
	{ // simple call 
		
		PyObject* pythonClass = PyDict_GetItemString( pDict,"PythonTests" );
        Log_debugPointer( pythonClass );
		
		PyObject* pFunc = PyDict_GetItemString(pythonClass,"hello_world");
        Log_debugPointer( pFunc );
		
		if( nil == pFunc ) {
            @throw exceptionWithReason( @"nil == pFunc" );
		}
		
		if (PyCallable_Check(pFunc)) {
			PyObject_CallObject(pFunc, NULL); 
			
		} else {
			PyErr_Print();
		}
	}	
	
    
#ifdef NEVER_EXECUTE
	
	{ // call with a string param
		
		PyObject* pFunc = PyDict_GetItemString(pDict,"PythonTests.hello");
        Log_debugPointer( pFunc );
		
		PyObject* pArgs = PyTuple_New(1);
		
		PyObject* sal = PyString_FromString("sal");
		
		PyTuple_SetItem(pArgs, 0, sal);
		
		PyObject_CallObject(pFunc, pArgs);
		
		
		if (pArgs != NULL) {
			Py_DECREF(pArgs);
		}
		
	}
	
	{ // call a function that does not exist
		
		PyObject* pFunc = PyDict_GetItemString(pDict,"PythonTests.badMethodName");
        Log_debugPointer( pFunc );
		
		[_runtimeHelper checkForPythonError];
		
		
		
	}
	
	{ // force an error in the python world 
		
		PyObject* pFunc = PyDict_GetItemString(pDict,"PythonTests.div0");
        Log_debugPointer( pFunc );
		
		if (PyCallable_Check(pFunc)) {
			PyObject_CallObject(pFunc, NULL); 
			[_runtimeHelper checkForPythonError];
			
		}
	}
    
#endif 

    return;

}


-(void)callHttpGet {
	

    Log_enteredMethod();
	
	PyObject* pDict = PyModule_GetDict(_pythonModule);

	PyObject* pFunc = PyDict_GetItemString(pDict,"PythonTests.http_get");
    Log_debugPointer( pFunc );
	
	PyObject* pArgs = PyTuple_New(3);
	
	
	PyObject* host = PyString_FromString("127.0.0.1");
	PyTuple_SetItem(pArgs, 0, host);
	
	PyObject* port = PyInt_FromLong(8080);
	PyTuple_SetItem(pArgs, 1, port);

	PyObject* url = PyString_FromString("/requests/status.xml");
	PyTuple_SetItem(pArgs, 2, url);
	
	PyObject_CallObject(pFunc, pArgs);
	
	[_runtimeHelper checkForPythonError];

}

#pragma mark instance lifecycle


-(id)initWithModule:(PyObject*)pythonModule moduleName:(NSString*)moduleName runtimeHelper:(PythonRuntimeHelper*)runtimeHelper {

	
    Log_enteredMethod();

    PythonModule* answer = [super init];
	
	
	answer->_pythonModule = pythonModule;	
	Py_INCREF( answer->_pythonModule );
	
	[answer setRuntimeHelper:runtimeHelper];
	[answer setModuleName:moduleName];

	return answer;
	
}

-(void)dealloc {
	
    Log_enteredMethod();
	
	Py_DECREF(_pythonModule);
	
	[self setRuntimeHelper:nil];
	
}
	
#pragma mark fields
	
//NSString* _moduleName;
//@property (nonatomic, retain) NSString* moduleName;
@synthesize moduleName = _moduleName;

//PythonRuntimeHelper *_runtimeHelper;
//@property (nonatomic, retain) PythonRuntimeHelper *runtimeHelper;
@synthesize runtimeHelper = _runtimeHelper;

	
@end

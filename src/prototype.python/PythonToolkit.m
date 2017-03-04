// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Python/Python.h>

#import "CALog.h"

#import "PythonToolkit.h"


@implementation PythonToolkit


+(void)warnTraceback:(PyObject*)traceback { 
	
	
}

+(void)checkForPythonError {
	
	if( PyErr_Occurred() ) {
        Log_warn( @"PyErr_Occurred()" );
		
		PyObject* ptype = 0;
		PyObject* pvalue = 0;
		PyObject* ptraceback = 0;
		
		PyErr_Fetch( &ptype, &pvalue, &ptraceback );
		//PyErr_NormalizeException( &ptype, &pvalue, &ptraceback );
		
        Log_debugPointer( ptype );
		if( NULL != ptype ) {
            Log_debugUtf8String( ptype->ob_type->tp_name );
			if( PyType_Check( ptype ) ) {
                Log_debug( @"PyType_Check( ptype )"  );
			}
			
            Log_debugUtf8String( ptype->ob_type->tp_name );
            Log_debugUtf8String( PyString_AsString(PyObject_Str( ptype )) );
		}
        Log_debugPointer( pvalue );
		
		if( NULL != pvalue ) {
		
            Log_debugUtf8String( pvalue->ob_type->tp_name );
            Log_debugUtf8String( PyString_AsString(PyObject_Str( pvalue )) );

			
		}
        Log_debugPointer( ptraceback );
		if( NULL != ptraceback ) {
            Log_debugUtf8String( ptraceback->ob_type->tp_name );
		}
		
		
		//PyErr_Print();
	}
}

@end

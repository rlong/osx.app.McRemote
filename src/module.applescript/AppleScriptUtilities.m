// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"

#import "AppleScriptUtilities.h"


@implementation AppleScriptUtilities

// buffer MUST be at least 5 characters in length
+(void)formatDescriptorType:(char*)buffer withDescriptor:(NSAppleEventDescriptor*)descriptor {
	
	DescType descriptorType = [descriptor descriptorType];
	
	buffer[0] = descriptorType>>24;
	buffer[1] = descriptorType>>16;
	buffer[2] = descriptorType>>8;
	buffer[3] = descriptorType;
	buffer[4] = 0;
}


+(double)getDoubleFrom:(NSAppleEventDescriptor*)descriptor {
	
	const double* answer = [[descriptor data] bytes];
	return *answer;

}

+(void)dumpDescriptor:(NSAppleEventDescriptor*)descriptor withIndent:(NSString*)indent {
	
#ifdef DEBUG
	char utf8DescriptorType[5];
	[self formatDescriptorType:utf8DescriptorType withDescriptor:descriptor];
	
	DescType descriptorType = [descriptor descriptorType];
	

	// boolean ... 
	if( typeTrue == descriptorType ) { // 'true' == typeTrue
        
        Log_debugFormat( @"%@%s: TRUE", indent, utf8DescriptorType );
		return;
	}
	
	if( typeFalse == descriptorType ) { // 'fals' == typeFalse
        
        Log_debugFormat( @"%@%s: FALSE", indent, utf8DescriptorType );
		return;
	}
	
	// dateTime.iso8601 ... 
	if( cLongDateTime == descriptorType ) { // 'ldt ' == cLongDateTime
				
		const uint64_t* longDateTime = [[descriptor data] bytes];
		CFAbsoluteTime absoluteTime = *longDateTime - kCFAbsoluteTimeIntervalSince1904;
		NSDate* date = [NSDate dateWithTimeIntervalSinceReferenceDate:absoluteTime];
		
        Log_debugFormat( @"%@%s: %@", indent, utf8DescriptorType, [date description] );
        
		return;
	} 
	
	
	// double ... 
	if( typeIEEE64BitFloatingPoint == descriptorType ) { // 'doub' == typeIEEE64BitFloatingPoint
		double value = [self getDoubleFrom:descriptor];
        
        Log_debugFormat( @"%@%s: %lf", indent, utf8DescriptorType, value );
		return;
	} 
	
	// integer ... 
	if( typeSInt32 == descriptorType ) {
        
        Log_debugFormat( @"%@%s: %d", indent, utf8DescriptorType, [descriptor int32Value] );
		return;

	} 

	// string ... 
	if( typeUnicodeText == descriptorType ) {
        
        Log_debugFormat( @"%@%s: %@", indent, utf8DescriptorType, [descriptor stringValue] );
		return;
	}
    
    // enum ...
    if( typeEnumerated == descriptorType ) {
        Log_debugFormat( @"%@%s: %@", indent, utf8DescriptorType, [descriptor stringValue] );
        return;
        
    }
	
	
	// struct/other ... 
	long numberOfItems = [descriptor numberOfItems];
	if( 0 < numberOfItems ) {
        
        Log_debugFormat( @"%@%s {", indent, utf8DescriptorType );
		
		NSString* newIndent = [NSString stringWithFormat:@"%@  ", indent];
		for( int i = 0; i < numberOfItems; i++ ) {
			NSAppleEventDescriptor *child = [descriptor descriptorAtIndex:i+1]; // applescript uses '1' based indexes
			[self dumpDescriptor:child withIndent:newIndent];
		}
		
        Log_debugFormat( @"%@%}", indent );
	} else {
        
        Log_debugFormat( @"%@%s {}", indent, utf8DescriptorType );
	}
	
#endif
	
}

+(void)dumpDescriptor:(NSAppleEventDescriptor*)descriptor {
	
	if( ! Log_isDebugEnabled() ) {
		return;
	}
	[self dumpDescriptor:descriptor withIndent:@""];
	
	
}

+(void)dumpDescriptor:(NSAppleEventDescriptor*)descriptor caller:(const char*)caller {
    
    Log_debugUtf8String( caller );
	
	[self dumpDescriptor:descriptor];
	
	
}

@end

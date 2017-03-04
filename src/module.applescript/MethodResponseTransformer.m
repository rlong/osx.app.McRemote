// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AppleScriptUtilities.h"
#import "MethodResponseTransformer.h"

#import "CABaseException.h"
#import "CAJsonObject.h"
#import "CALog.h"


@implementation MethodResponseTransformer

//
//// buffer MUST be at least 5 characters in length
////+(void)formatDescriptorType:(char*)buffer withDescriptor:(NSAppleEventDescriptor*)descriptor {
////	
////	DescType descriptorType = [descriptor descriptorType];
////	
////	buffer[0] = descriptorType>>24;
////	buffer[1] = descriptorType>>16;
////	buffer[2] = descriptorType>>8;
////	buffer[3] = descriptorType;
////	buffer[4] = 0;
////}
////
////
////+(void)dumpDescriptor:(NSAppleEventDescriptor*)descriptor {
////	
////	
////	char utf8DescriptorType[5];
////	[self formatDescriptorType:utf8DescriptorType withDescriptor:descriptor];
////	[Log debugUTF8String:utf8DescriptorType withName:@"utf8DescriptorType" inFunction:__func__];
////	
////	DescType descriptorType = [descriptor descriptorType];
////	if( typeUnicodeText == descriptorType ) {
////		[Log debugString:[descriptor stringValue] withName:@"[descriptor stringValue]" inFunction:__func__];
////	}
////	else if( typeSInt32 == descriptorType ) {
////		[Log debugLong:[descriptor int32Value] withName:@"[descriptor int32Value]" inFunction:__func__];
////	}
////	
////	int numberOfItems = [descriptor numberOfItems];
////	[Log debugInt:numberOfItems withName:@"numberOfItems" inFunction:__func__];
////	for( int i = 1; i <= numberOfItems; i++ ) {
////		NSAppleEventDescriptor *child = [descriptor descriptorAtIndex:i];
////		[self dumpDescriptor:child];
////	}
////	
////}
//
//
//
//+(id)buildObjectFor:(NSAppleEventDescriptor*)descriptor {
//	
//	
//	DescType descriptorType = [descriptor descriptorType];
//	
//	if( typeNull == descriptorType ) {
//		return nil;
//	} 
//	
//	// array ... 
//	if ( typeAEList == descriptorType ) {
//		NSMutableArray* answer = [[NSMutableArray alloc] init];
//		[answer autorelease];
//		
//		for( int i = 1; i <= [descriptor numberOfItems]; i++ ) {
//			NSAppleEventDescriptor *componentDescriptor = [descriptor descriptorAtIndex:i];
//			id componentObject = [self buildObjectFor:componentDescriptor];
//			[answer addObject:componentObject];
//		}
//		return answer;		
//	} 
//	
//	// boolean ... 
//	if( typeTrue == descriptorType ) { // 'true' == typeTrue
//		//		XRBoolean* answer = [[XRBoolean alloc] initWithValue:FALSE]; compiler has trouble with inlining of alloc and over-loaded init
//		XRBoolean* answer = [XRBoolean alloc];
//		[answer setValue:TRUE];
//		[answer autorelease];
//		return answer;
//							 
//	}
//
//	
//	// boolean ... 
//	if( typeFalse == descriptorType ) { // 'fals' == typeFalse
//		//		XRBoolean* answer = [[XRBoolean alloc] initWithValue:FALSE]; compiler has trouble with inlining of alloc and over-loaded init
//		XRBoolean* answer = [XRBoolean alloc];
//		[answer setValue:FALSE];
//		[answer autorelease];
//		return answer;
//	}
//
//	
//	// double ... 
//	if( typeIEEE64BitFloatingPoint == descriptorType ) { // 'doub' == typeIEEE64BitFloatingPoint
//		
//		double value = [AppleScriptUtilities getDoubleFrom:descriptor];
//		
//		XRDouble* answer = [XRDouble alloc];
//		[answer initWithValue:value]; 
//		//		XRDouble* answer = [[XRDouble alloc] initWithValue:value]; // compiler has trouble with inlining of alloc and over-loaded init
//		[answer autorelease];
//		return answer;
//	} 
//	
//	// dateTime.iso8601 ...
//	if( cLongDateTime == descriptorType ) { // 'ldt ' == cLongDateTime
//		const uint64_t* longDateTime = [[descriptor data] bytes];
//		CFAbsoluteTime absoluteTime = *longDateTime - kCFAbsoluteTimeIntervalSince1904;
//		NSDate* answer = [NSDate dateWithTimeIntervalSinceReferenceDate:absoluteTime];
//		return answer;
//	}
//	
//	// integer ... 
//	if( typeSInt32 == descriptorType ) {
//		XRInteger* answer = [[[XRInteger alloc] init] autorelease];
//		[answer setValue:[descriptor int32Value]];
//		[Log debugInt:[answer value] withName:@"[answer value]" inFunction:__func__];
//		return answer;
//	} 
//	
//	// string ... 
//	if ( typeUnicodeText == descriptorType ) {
//		NSString* answer = [descriptor stringValue];
//		[Log debugString:answer withName:@"answer" inFunction:__func__];
//		return answer;
//	} 
//	
//	// struct ... 
//	if ( typeAERecord == descriptorType ) {
//		NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
//		[answer autorelease];
//		
//		//NSAppleEventDescriptor* listDescriptor = [descriptor descriptorForKeyword:typeAEList]; // the list within the record
//		//NSAppleEventDescriptor* listDescriptor = [descriptor descriptorForKeyword:typeAEList]; // the list within the record
//		NSAppleEventDescriptor* listDescriptor = [descriptor descriptorAtIndex:1]; // the list within the record
//
//		[Log debugInt:[listDescriptor numberOfItems] withName:@"[listDescriptor numberOfItems]" inFunction:__func__];
//		
//		int listCount = [listDescriptor numberOfItems];
//		for( int i = 1; i < listCount; i+=2 ) {
//			NSAppleEventDescriptor* fieldNameDescriptor = [listDescriptor descriptorAtIndex:i];
//			NSString* fieldName = [fieldNameDescriptor stringValue];
//			
//			NSAppleEventDescriptor* fieldValueDescriptor = [listDescriptor descriptorAtIndex:i+1];
//			id fieldValue = [self buildObjectFor:fieldValueDescriptor];
//			
//			[answer setObject:fieldValue forKey:fieldName];
//		}
//		return answer;
//		
//	}
//
//	
//	char utf8DescriptorType[5];
//	[AppleScriptUtilities formatDescriptorType:utf8DescriptorType withDescriptor:descriptor];
//	NSString* technicalError = [NSString stringWithFormat:@"Do not know how to map ApplScript type of '%s' to an equivalent Objective-C type", utf8DescriptorType];
//	BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ technicalError:technicalError];
//	[e autorelease];
//	
//	@throw e;
//	
//}


+(id)buildObjectFor:(NSAppleEventDescriptor*)descriptor {
    
    DescType descriptorType = [descriptor descriptorType];
	
    
    
    // array ... 
	if ( typeAEList == descriptorType ) {
        CAJsonArray* answer = [[CAJsonArray alloc] initWithCapacity:[descriptor numberOfItems]];
		
		for( int i = 1; i <= [descriptor numberOfItems]; i++ ) {
			NSAppleEventDescriptor *componentDescriptor = [descriptor descriptorAtIndex:i];
			id componentObject = [self buildObjectFor:componentDescriptor];
            [answer add:componentObject];
		}
		return answer;		
	} 

    
	// boolean true ... 
	if( typeTrue == descriptorType ) { // 'true' == typeTrue
        NSNumber* answer = [NSNumber numberWithBool:TRUE];
		return answer;
	}
    
    
	// boolean false ... 
	if( typeFalse == descriptorType ) { // 'fals' == typeFalse
        NSNumber* answer = [NSNumber numberWithBool:FALSE];
		return answer;
	}

    
    // double ... 
	if( typeIEEE64BitFloatingPoint == descriptorType ) { // 'doub' == typeIEEE64BitFloatingPoint
		
		double value = [AppleScriptUtilities getDoubleFrom:descriptor];
        NSNumber* answer = [NSNumber numberWithDouble:value];
		return answer;
	} 
    
    // dateTime.iso8601 ...
	if( cLongDateTime == descriptorType ) { // 'ldt ' == cLongDateTime
        
		const uint64_t* intervalSince1904 = [[descriptor data] bytes];
        Log_debugInt( *intervalSince1904 );
        
        int64_t intervalSince2001 = *intervalSince1904 - kCFAbsoluteTimeIntervalSince1904;
        Log_debugInt( intervalSince2001 );
        
        int64_t intervalSinceEpoc = intervalSince2001 + kCFAbsoluteTimeIntervalSince1970;
        Log_debugInt( intervalSinceEpoc );
        
        NSNumber* answer = [NSNumber numberWithLongLong:intervalSinceEpoc];
        return answer;
        
//		CFAbsoluteTime absoluteTime = *longDateTime - kCFAbsoluteTimeIntervalSince1904;
//		NSDate* answer = [NSDate dateWithTimeIntervalSinceReferenceDate:absoluteTime];
//		return answer;
	}
    
    
    // integer ... 
	if( typeSInt32 == descriptorType ) {
        int value = [descriptor int32Value];
        NSNumber* answer = [NSNumber numberWithInt:value];
		return answer;
	} 

    // null ...
    if( typeNull == descriptorType ) {
        return [NSNull null];
    }

    // string ... 
	if ( typeUnicodeText == descriptorType ) {
		NSString* answer = [descriptor stringValue];
        Log_debugString( answer );
		return answer;
	} 

	// struct ... 
	if ( typeAERecord == descriptorType ) {
        CAJsonObject* answer = [[CAJsonObject alloc] init];
		
		//NSAppleEventDescriptor* listDescriptor = [descriptor descriptorForKeyword:typeAEList]; // the list within the record
		NSAppleEventDescriptor* listDescriptor = [descriptor descriptorAtIndex:1]; // the list within the record
        
        Log_debugInt([listDescriptor numberOfItems] );
		
		long listCount = [listDescriptor numberOfItems];
		for( long i = 1; i < listCount; i+=2 ) {
			NSAppleEventDescriptor* fieldNameDescriptor = [listDescriptor descriptorAtIndex:i];
			NSString* fieldName = [fieldNameDescriptor stringValue];
			
			NSAppleEventDescriptor* fieldValueDescriptor = [listDescriptor descriptorAtIndex:i+1];
			id fieldValue = [self buildObjectFor:fieldValueDescriptor];
			
			[answer setObject:fieldValue forKey:fieldName];
		}
		return answer;
		
	}
    
    
    if( typeType == descriptorType ) {

        OSType typeCodeValue = [descriptor typeCodeValue];
        
        
        if( typeNull == typeCodeValue ) {
            return [NSNull null];
        }

        // utftypeCodeValue = 'msng' is "missing value"

        char utftypeCodeValue[5];
        utftypeCodeValue[0] = typeCodeValue>>24;
        utftypeCodeValue[1] = typeCodeValue>>16;
        utftypeCodeValue[2] = typeCodeValue>>8;
        utftypeCodeValue[3] = typeCodeValue;
        utftypeCodeValue[4] = 0;
        Log_errorFormat( @"unhandled typeCodeValue; typeCodeValue = '%s'", utftypeCodeValue );
        
    }
    
    if( typeEnumerated == descriptorType ) {

        NSString* answer = [descriptor stringValue];
        Log_debugString( answer );
        
#ifdef DEBUG
        {
            OSType enumCodeValue = [descriptor enumCodeValue];
            
            char utftypeCodeValue[5];
            utftypeCodeValue[0] = enumCodeValue>>24;
            utftypeCodeValue[1] = enumCodeValue>>16;
            utftypeCodeValue[2] = enumCodeValue>>8;
            utftypeCodeValue[3] = enumCodeValue;
            utftypeCodeValue[4] = 0;
            
            Log_warnFormat( @"enumCodeValue = '%s'", utftypeCodeValue );
            
        }
        
        {
            
            OSType typeCodeValue = [descriptor typeCodeValue];
            
            char utftypeCodeValue[5];
            utftypeCodeValue[0] = typeCodeValue>>24;
            utftypeCodeValue[1] = typeCodeValue>>16;
            utftypeCodeValue[2] = typeCodeValue>>8;
            utftypeCodeValue[3] = typeCodeValue;
            utftypeCodeValue[4] = 0;
            
            Log_warnFormat( @"typeCodeValue = '%s'", utftypeCodeValue );
        }

#endif
        return answer;

    }
    

	char utf8DescriptorType[5];
	[AppleScriptUtilities formatDescriptorType:utf8DescriptorType withDescriptor:descriptor];
	NSString* technicalError = [NSString stringWithFormat:@"Do not know how to map ApplScript type of '%s' to an equivalent Objective-C type", utf8DescriptorType];
	CABaseException* e = [[CABaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
	
	@throw e;
    
}


+(id)transform:(NSAppleEventDescriptor*)responseDescriptor {

    [AppleScriptUtilities dumpDescriptor:responseDescriptor caller:__func__];
    id answer = [self buildObjectFor:responseDescriptor];
    
    return answer;

}


//
//+(XRMessage*)transform:(NSAppleEventDescriptor*)responseDescriptor {
//	
//	[AppleScriptUtilities dumpDescriptor:responseDescriptor caller:__func__];
//	
//	XRMessage* answer = [[XRMessage alloc] init];
//	[answer autorelease];
//		
//	id responseParam = [self buildObjectFor:responseDescriptor];
//	if( nil != responseParam ) {
//		[[answer params] addObject:responseParam];
//	}
//
//	return answer;
//	
//}


@end

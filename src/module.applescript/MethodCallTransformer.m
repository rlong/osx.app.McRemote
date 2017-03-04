// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



// ... Carbon.h includes ASRegistry.h which defines 'keyASSubroutineName' 
#import <Carbon/Carbon.h>

#import "MethodCallTransformer.h"
#import "AppleScriptUtilities.h"

#import "CABaseException.h"
#import "CAJsonArray.h"
#import "CAJsonObject.h"
#import "CALog.h"


@implementation MethodCallTransformer





+ (NSAppleEventDescriptor *)buildDescriptorFor:(id)param {

    
    // array ... 
	if( [param isKindOfClass:[CAJsonArray class]] ) {
		CAJsonArray* jsonArray = param;
		NSAppleEventDescriptor* answer = [NSAppleEventDescriptor listDescriptor]; // typeAEList
 		for( int i = 0, count = [jsonArray length]; i < count; i++ ) {
			id arrayObject = [jsonArray objectAtIndex:i];
			NSAppleEventDescriptor* objectDescriptor = [self buildDescriptorFor:arrayObject];
			[answer insertDescriptor:objectDescriptor atIndex:i+1];
		}
		return answer;
	} 
    
    if( [param isKindOfClass:[NSNumber class]] ) {
        NSNumber* number = (NSNumber*)param;
        
        const char* objCType = [number objCType];
        
        // boolean ...
        if( 0 == strcmp(objCType, @encode(BOOL))) { // @encode(BOOL) == "B"

            return [NSAppleEventDescriptor descriptorWithBoolean:[number boolValue]];
            
        }
        

        // double ... 
        if( 0 == strcmp(objCType, @encode(double))) { // @encode(double) == "d"

            
            double value = [number doubleValue];
            DescType descriptorType = typeIEEE64BitFloatingPoint; // 'doub' == typeIEEE64BitFloatingPoint
            return [NSAppleEventDescriptor descriptorWithDescriptorType:descriptorType bytes:&value length:sizeof(double)];
            
        }

        // int ...
        if( 0 == strcmp(objCType, @encode(int))) { // @encode(int) == "i"
            
            return [NSAppleEventDescriptor descriptorWithInt32:[number intValue]]; // typeSInt32
        }
        
        // long ...
        if( 0 == strcmp(objCType, @encode(long))) { // @encode(long) == "l"

            // vvv https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
            
            //A long 'l' is treated as a 32-bit quantity on 64-bit programs.
            
            // ^^^ https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
            
            return [NSAppleEventDescriptor descriptorWithInt32:[number intValue]]; // typeSInt32
            
        }

        // long long ...
        if( 0 == strcmp(objCType, @encode(long long))) { // @encode(long) == "q"
            
            long long value = [number longLongValue];
            DescType descriptorType = typeSInt64; // typeSInt64 = 'comp', /* SInt64 : signed, 64 bit integer */
            return [NSAppleEventDescriptor descriptorWithDescriptorType:descriptorType bytes:&value length:sizeof(long long)];
            
        }

        Log_errorFormat( @"unhandled number type; objCType = %s", objCType );

    }
    
    
    // string ... 
	if( [param isKindOfClass:[NSString class]] ) { 
		NSString* stringParam = param;
        Log_debugString( stringParam );
		
		return [NSAppleEventDescriptor descriptorWithString:stringParam]; // typeUnicodeText
		
	} 
    
    
    // struct ... 
	if( [param isKindOfClass:[CAJsonObject class]] ) {
        
		NSAppleEventDescriptor* answer = [NSAppleEventDescriptor recordDescriptor]; // typeAERecord
		
		CAJsonObject* jsonObject = param;
		NSAppleEventDescriptor* listDescriptor = [NSAppleEventDescriptor listDescriptor];
        
        NSArray* allKeys = [jsonObject allKeys];
        
        int descriptorIndex = 0;

        for( long i = 0, count = [allKeys count]; i < count; i++ ) {
            
            NSString* key = [allKeys objectAtIndex:i];

			// name 
            descriptorIndex++; // start out at index 1, AppleScript uses 1 based arrays
            NSAppleEventDescriptor* nameDescriptor = [NSAppleEventDescriptor descriptorWithString:key];
            [listDescriptor insertDescriptor:nameDescriptor atIndex:descriptorIndex];
            
			// value 
			descriptorIndex++;
            NSAppleEventDescriptor* valueDescriptor = [self buildDescriptorFor:[jsonObject objectForKey:key]];
            [listDescriptor insertDescriptor:valueDescriptor atIndex:descriptorIndex];
            
        }
		
		// if we add the 'listDescriptor' to 'answer' before we have populated it, we end up with an empty list ... think "deep copy"
		[answer setDescriptor:listDescriptor forKeyword:typeAEList];
		// [answer insertDescriptor:listDescriptor atIndex:1]; ... does not work as an alternative to '[answer setDescriptor:listDescriptor forKeyword:typeAEList];'
		
		return answer;
		
	} 


    NSString* paramClassName = [param className];
	NSString* technicalError = [NSString stringWithFormat:@"Do not know how to map Objective-C type of '%@' to an equivalent ApplScript type", paramClassName];
	CABaseException* e = [[CABaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
	
	@throw e;

}

+ (NSAppleEventDescriptor *)buildArguments:(CAJsonArray*) paramaters
{
    Log_enteredMethod();
	
    NSAppleEventDescriptor *answer = [[NSAppleEventDescriptor alloc] initListDescriptor];
	
	for( int i = 0, count = [paramaters length]; i < count; i++ ) {
		id param = [paramaters objectAtIndex:i];
		NSAppleEventDescriptor *paramDescriptor = [self buildDescriptorFor:param];
		[answer insertDescriptor:paramDescriptor atIndex:i+1];
	}
    
    return answer;
    
}



+(NSAppleEventDescriptor *)transformMethodName:(NSString*)methodName withParamaters:(CAJsonArray*)paramaters{ 
    
    NSAppleEventDescriptor* answer = [[NSAppleEventDescriptor alloc] initWithEventClass: 'ascr' eventID: 'psbr' targetDescriptor: [NSAppleEventDescriptor nullDescriptor] returnID: kAutoGenerateReturnID transactionID: kAnyTransactionID];
    
 	/* associated the method call descriptor with the top level call descriptor */
    NSAppleEventDescriptor* methodDescriptor = [NSAppleEventDescriptor descriptorWithString:methodName];
    [answer setParamDescriptor: methodDescriptor forKeyword:keyASSubroutineName]; // keyASSubroutineName == 'snam'
    
 	/* associated the arguments descriptor with the top level call descriptor */    
    //JsonArray* paramaters = [request paramaters];
	NSAppleEventDescriptor *arguments = [self buildArguments:paramaters];
    [answer setParamDescriptor: arguments forKeyword: keyDirectObject]; // keyDirectObject == '----'
    
    
    [AppleScriptUtilities dumpDescriptor:answer caller:__func__];
    
    
	return answer;
    
}


+(NSAppleEventDescriptor *)transform:(HLBrokerMessage*)request { 

    NSAppleEventDescriptor* answer = [[NSAppleEventDescriptor alloc] initWithEventClass: 'ascr' eventID: 'psbr' targetDescriptor: [NSAppleEventDescriptor nullDescriptor] returnID: kAutoGenerateReturnID transactionID: kAnyTransactionID];

 	/* associated the method call descriptor with the top level call descriptor */
    NSAppleEventDescriptor* methodDescriptor = [NSAppleEventDescriptor descriptorWithString:[request methodName]];
    [answer setParamDescriptor: methodDescriptor forKeyword:keyASSubroutineName]; // keyASSubroutineName == 'snam'
    
 	/* associated the arguments descriptor with the top level call descriptor */
    CAJsonArray* orderedParamaters = [request orderedParamaters];
	NSAppleEventDescriptor *arguments = [self buildArguments:orderedParamaters];
    [answer setParamDescriptor: arguments forKeyword: keyDirectObject]; // keyDirectObject == '----'
    
    
    [AppleScriptUtilities dumpDescriptor:answer caller:__func__];
    
    
	return answer;

}

//
//+(NSAppleEventDescriptor *)transform:(XRMessage*)methodCall {
//	
//	NSAppleEventDescriptor* answer = [[NSAppleEventDescriptor alloc] initWithEventClass: 'ascr' eventID: 'psbr' targetDescriptor: [NSAppleEventDescriptor nullDescriptor] returnID: kAutoGenerateReturnID transactionID: kAnyTransactionID];
//	[answer autorelease];
//    
// 	/* associated the method call descriptor with the top level call descriptor */
//	NSAppleEventDescriptor*  methodDescriptor = [self methodNameFor:methodCall];
//    [answer setParamDescriptor: methodDescriptor forKeyword:keyASSubroutineName]; // keyASSubroutineName == 'snam'
//	
// 	/* associated the arguments descriptor with the top level call descriptor */
//	NSAppleEventDescriptor *arguments = [self buildArguments:methodCall];
//    [answer setParamDescriptor: arguments forKeyword: keyDirectObject]; // keyDirectObject == '----'
//	
//	[AppleScriptUtilities dumpDescriptor:answer caller:__func__];
////	[AppleScriptUtilities dumpDescriptor:arguments caller:__func__];
//
//
//	return answer;
//}
//


@end

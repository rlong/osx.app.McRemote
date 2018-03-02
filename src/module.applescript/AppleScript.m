// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AppleScript.h"
#import "MethodCallTransformer.h"
#import "MethodResponseTransformer.h"


#import "CABaseException.h"
#import "CALog.h"
#import "CAFile.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface AppleScript () 



@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation AppleScript {

    
    
    NSString* _scriptName;
    NSAppleScript* _script;
    NSDate* _scriptModificationDate;

}



#pragma mark instance setup/teardown

- (instancetype)initWithScriptName:(NSString*)scriptName {
    
    self = [super init];
    
    if( self ) {
        
        _scriptName = scriptName;
        
        
    }
    
    return self;
    
    
}

- (instancetype)initWithSource:(NSString *)source {
    
    AppleScript* answer = [super init];
    
    if( nil != answer ) {
        
        // tag: 0C8E5CF3-3D9C-44F4-BE5B-2BBF9A0948E9
        answer->_script = [[NSAppleScript alloc] initWithSource:source];
        Log_debugInt( [answer->_script isCompiled] );
    }
    
    return answer;
    
}


#pragma mark -


-(NSAppleScript*)getDeveloperScript {
    
#ifndef DEBUG
    return nil;
#endif
    
    NSString* scriptModuleFolder = [@"~/Projects/osx.app.McRemote/Projects/osx.app.McRemote/res/module" stringByExpandingTildeInPath];
    NSString* scriptPath = [NSString stringWithFormat:@"%@/%@/%@.scpt", scriptModuleFolder, _scriptName, _scriptName];
    Log_debugString( scriptPath );
    
    CAFile* scripteFile = [[CAFile alloc] initWithPathname:scriptPath];
    if( ![scripteFile exists] ) {
        return nil;
    }
    
    NSURL* scriptUrl = nil;
    if( nil == _scriptModificationDate) {
        
        Log_infoFormat( @"found developer script at '%@'", scriptPath );
        scriptUrl = [[NSURL alloc] initFileURLWithPath:scriptPath];
        
    } else if ( [_scriptModificationDate timeIntervalSince1970] < [[scripteFile getModificationDate] timeIntervalSince1970] ) { // scripte has been updated ?

        Log_infoFormat( @"found updated developer script at '%@'", scriptPath );
        scriptUrl = [[NSURL alloc] initFileURLWithPath:scriptPath];

    }
    if( nil == scriptUrl ) {
        return nil;
    }

    NSDictionary* errorInfo = nil;
    NSAppleScript* answer = [[NSAppleScript alloc] initWithContentsOfURL:scriptUrl error:&errorInfo];
    if( nil != errorInfo ) {
        @throw exceptionWithFormat( @"nil != errorInfo; _scriptName = '%@'", _scriptName );
    }
    
    _scriptModificationDate = [scripteFile getModificationDate];
    
    return answer;

}

-(NSAppleScript*)getScript {

#ifdef DEBUG

    NSAppleScript* developerScript = [self getDeveloperScript];
    if( nil != developerScript ) {
        _script = developerScript;
    }
    
#endif

    
    if( nil != _script) {
        return _script;
    }
    
    
    // vvv for historical purposes
    //
    //	Here I am using "initWithContentsOfURL:" to load a pre-compiled script, rather than using "initWithSource:" to load a text file with AppleScript source.
    //	The main reason for this is that the latter technique seems to give rise to inexplicable -1708 (errAEEventNotHandled) errors on Jaguar.
    //	NSAppleScript* answer = [[NSAppleScript alloc] initWithContentsOfURL: scriptURL error: &errorInfo];
    //
    // ^^^ for historical purposes
    
    
    NSString* resourcePath = [NSString stringWithFormat:@"module/%@/%@.scpt", _scriptName, _scriptName];

    NSURL* scriptUrl = [[NSBundle mainBundle] URLForResource:resourcePath withExtension:nil];
    
    if( nil == scriptUrl ) {
        @throw exceptionWithFormat( @"nil == scriptUrl; _scriptName = '%@'", _scriptName );
        
    }
    Log_debugString( [scriptUrl absoluteString] );
    NSDictionary* errorInfo = nil;
    _script = [[NSAppleScript alloc] initWithContentsOfURL:scriptUrl error:&errorInfo];
    if( nil != errorInfo ) {
        @throw exceptionWithFormat( @"nil != errorInfo; _scriptName = '%@'", _scriptName );
    }
    
    return _script;

    
}


-(id)executeMethodWithName:(NSString*)methodName parameters:(CAJsonArray*)parameters {
    
	
	NSAppleEventDescriptor* methodCallDescriptor = [MethodCallTransformer transformMethodName:methodName withParamaters:parameters];
	
	NSDictionary *errorInfo = nil;
	
	
    /* Execute the method and extract the answer */
    NSAppleScript* script = [self getScript];
    NSAppleEventDescriptor* responseDescriptor = [script executeAppleEvent:methodCallDescriptor error:&errorInfo];
	    
	if( nil != errorInfo ) {
		NSString* technicalError = @"nil != errorInfo";
		NSString* appleScriptErrorBriefMessage = [errorInfo objectForKey:NSAppleScriptErrorBriefMessage];
		if( nil != appleScriptErrorBriefMessage ) {
			technicalError = appleScriptErrorBriefMessage;
		}
		
		BaseException* e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];

#ifdef NEVER_EXECUTE
        
		if( NO ) {
			
			for( id key in errorInfo ) {
				if( [key isKindOfClass:[NSString class]] ) {
                    Log_debugString( key );
				} else {
                    Log_debugString( NSStringFromClass([key class]) );
				}
				
			}

#ifdef DEBUG
			NSValue* appleScriptErrorRangeValue = [errorInfo objectForKey:NSAppleScriptErrorRange];
            Log_debugUtf8String( [appleScriptErrorRangeValue objCType] );
            
            NSRange appleScriptErrorRange = [appleScriptErrorRangeValue rangeValue];            
            Log_debugInt( appleScriptErrorRange.length );
            Log_debugInt( appleScriptErrorRange.location );
			
#endif
			
		}
		
#endif
        id appleScriptErrorNumber = [errorInfo objectForKey:NSAppleScriptErrorNumber];
		if( nil != appleScriptErrorNumber && [appleScriptErrorNumber isKindOfClass:[NSNumber class]] ) {
			NSNumber* code = (NSNumber*)appleScriptErrorNumber;
			NSError* error = [NSError errorWithDomain:methodName code:[code intValue] userInfo:nil];
			[e setError:error];
			
		}
		
		[e addContext:errorInfo];
		
		@throw e;
		
	}
		
	return [MethodResponseTransformer transform:responseDescriptor];
}





@end

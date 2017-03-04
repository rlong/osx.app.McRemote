// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CALog.h"

#import "AppleScriptLoader.h"
#import "LoginItemsHelper.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface LoginItemsHelper () 

//AppleScript* _appleScript;
@property (nonatomic, retain) AppleScript* appleScript;
//@synthesize appleScript = _appleScript;

//NSString* _applicationPath; 
@property (nonatomic, retain) NSString* applicationPath;
//@synthesize applicationPath = _applicationPath;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation LoginItemsHelper


#pragma mark - instance setup/teardown

-(id)init {
    
    
    LoginItemsHelper* answer = [super init];
    
    
    
    
//    NSString* script = [AppleScriptLoader loadScript:@"LoginItemsHelper"];÷
    //NSString* script = [RG2_ResourceLoader loadTextResource:@"LoginItemsHelper"];
    answer->_appleScript = [[AppleScript alloc] initWithScriptName:@"LoginItemsHelper"];
    
    /*
     * _applicationPath
     */
    NSProcessInfo* processInfo = [NSProcessInfo processInfo];
    NSString* applicationPath = (NSString*)[[processInfo arguments] objectAtIndex:0];
    
    // NSURL *currentExecutableURL = [[NSRunningApplication currentApplication] executableURL];
    //NSString* applicationPath = [currentExecutableURL path];
    
    applicationPath = [applicationPath stringByDeletingLastPathComponent]; // "X-Reco"
    applicationPath = [applicationPath stringByDeletingLastPathComponent]; // "MacOS"
    applicationPath = [applicationPath stringByDeletingLastPathComponent]; // "Contents"
    
    Log_infoString( applicationPath );
    //[RG2_Log infoString:applicationPath withName:@"applicationPath" inFunction:__func__];
    
    [answer setApplicationPath:applicationPath];
    
    return answer;
    
}

-(void)dealloc {
    
    
    [self setAppleScript:nil];
    [self setApplicationPath:nil];
    
    
}


#pragma mark - 

-(void)addApplicationToLoginItems {

	
    //RG2_XRMessage* request = [[RG2_XRMessage alloc] initWithMethodName:@"create_login_item"];

    CAJsonArray* params = [[CAJsonArray alloc] init];
    {
        [params add:_applicationPath];
        //[request addStringParameter:_applicationPath];
        [params addBoolean:false];
        //[request addBooleanParameter:NO];
        
        [_appleScript executeMethodWithName:@"create_login_item" parameters:params];
        //[_appleScript execute:request];
        //[request release];
        
    }
    
	
}
	
-(BOOL)isApplicationInLoginItems {
	
    NSNumber* response;
    
    CAJsonArray* params = [[CAJsonArray alloc] init];
    {
        [params add:_applicationPath];
        //[request addStringParameter:_applicationPath];
        
        response = [_appleScript executeMethodWithName:@"is_application_in_login_items" parameters:params];
        
    }
    
    return [response boolValue];

	
}

-(void)removeApplicationFromLoginItems {
	
    
    CAJsonArray* params = [[CAJsonArray alloc] init];
    {
        [params add:_applicationPath];
        
        [_appleScript executeMethodWithName:@"remove_application" parameters:params];
        
    }

	
}



#pragma mark fields

//AppleScript* _appleScript;
//@property (nonatomic, retain) AppleScript* appleScript;
@synthesize appleScript = _appleScript;

//NSString* _applicationPath; 
//@property (nonatomic, retain) NSString* applicationPath;
@synthesize applicationPath = _applicationPath;


@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CALog.h"

#import "ApplicationContext.h"
#import "PreferencesController.h"
#import "ProcessHelper.h"
#import "WindowsController.h"
#import "LogController.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface WindowsController () 


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation WindowsController





#pragma mark - instance lifecycle

- (id)init {
    
    
    WindowsController* answer = [super init];
    
    //	_logContainer = [[LogContainer alloc] init];
    //	[RG2_Log setLogConsumer:_logContainer];
    
    return answer;
    
}


-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //	[_logContainer release];
    _logController = nil;
    //	[RG2_Log setLogConsumer:nil];
    
}

#pragma mark - fields


-(void)bringApplicationToFront {
	
	// bring the application to the front ... 
	ProcessSerialNumber psn = { 0, kCurrentProcess };
    OSStatus status = [ProcessHelper setFrontProcess:&psn];
    
    Log_debugInt( status );
	//[RG2_Log debugInt:status withName:@"status" inFunction:__func__];
	
}


-(void)handleWindowWillCloseNotification:(NSNotification *)notification {
	
    Log_enteredMethod();
	//[RG2_Log entered:__func__];
	
	NSWindow* closingWindow = [notification object];
	

    if ( nil != _logController && closingWindow == [_logController window] ) {
        [_logController teardownRefreshTimer];
        _logController = nil;
    }
}

- (IBAction)showDevices:sender {
	
    Log_enteredMethod();
	
}


- (IBAction)showLog:sender {
    
    Log_enteredMethod();	
	//[RG2_Log entered:__func__];
	
	
    if( nil == _logController ) {
        _logController = [[LogController alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(handleWindowWillCloseNotification:)  name:NSWindowWillCloseNotification object:[_logController window]];
    }
	
	[self bringApplicationToFront];
	
	[_logController showWindow:sender];
	
}


- (IBAction)showPreferences:sender {
	
	PreferencesController* _preferencesController = [PreferencesController instance];
	
	
	[self bringApplicationToFront];

	[_preferencesController showWindow:self];
}





@end

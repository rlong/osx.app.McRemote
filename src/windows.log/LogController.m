// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"
#import "CALogConsumer.h"
#import "CASimpleLogConsumer.h"


#import "ApplicationContext.h"
#import "LogController.h"
#import "LogWindow.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface LogController () 

//
////LogContainer *_logContainer;
//@property (nonatomic, retain) LogContainer* logContainer;
////@synthesize logContainer = _logContainer;


//NSTimer* _refreshTimer;
@property (nonatomic, retain) NSTimer* refreshTimer;
//@synthesize refreshTimer = _refreshTimer;

// logEntries
//NSArray* _logEntries;
@property (nonatomic, retain) NSArray* logEntries;
//@synthesize logEntries = _logEntries;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



@implementation LogController


-(void)updateLogWindow:(NSArray*)recentLogEntries {

    Log_enteredMethod();
    
    [self setLogEntries:recentLogEntries];
    
    
    NSMutableString* logContents = [[NSMutableString alloc] init];
    {
        for( NSString* logEntry in recentLogEntries ) {
            [logContents appendString:logEntry];
            [logContents appendString:@"\n"];
        }
        
        NSTextView* logText = [_logWindow logText];
        [logText setString:logContents];
        [logText scrollToEndOfDocument:self];
        
    }
    

}

-(void)refreshTimerCallback:(NSTimer*)theTimer {
	
    Log_enteredMethod();
    
    [ApplicationContext getLogConsumer];
    NSArray* recentLogEntries = [[ApplicationContext getLogConsumer] getRecentLogEntries];
    
    if( nil == _logEntries ) { 
        [self updateLogWindow:recentLogEntries];
        return;
    }
    
    if( [_logEntries count] != [recentLogEntries count] ) { 
        [self updateLogWindow:recentLogEntries];
        return;
    }
    
    // implicitly '[_logEntries count] == [recentLogEntries count]'
    
    if( 0 == [recentLogEntries count] ) {
        return;
    }
    
    NSString* firstLogEntry1 = [_logEntries objectAtIndex:0];
    NSString* firstLogEntry2 = [recentLogEntries objectAtIndex:0];
    
    if( firstLogEntry1 != firstLogEntry2 ) { 
        [self updateLogWindow:recentLogEntries];
        return;        
    }
    
    long lastIndex = [recentLogEntries count] - 1;
    
    NSString* lastLogEntry1 = [_logEntries objectAtIndex:lastIndex];
    NSString* lastLogEntry2 = [recentLogEntries objectAtIndex:lastIndex];
    
    if( lastLogEntry1 != lastLogEntry2 ) { 
        [self updateLogWindow:recentLogEntries];
        return;        
    }
    
    
}


-(void)setupRefreshTimer {
	
	if( nil != _refreshTimer ) {
        Log_warn( @"nil != _refreshTimer" );
		return;
	}
	[self setRefreshTimer:[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshTimerCallback:) userInfo:nil repeats:YES]];
	
	
}




-(void)teardownRefreshTimer {
	
	if( nil != _refreshTimer ) {
		[_refreshTimer invalidate];
		[self setRefreshTimer:nil];
	}
}







#pragma mark <NSWindowDelegate> implementation 

- (void)windowDidLoad {
	
    
    Log_enteredMethod();
    
    
    NSArray* recentLogEntries = [[ApplicationContext getLogConsumer] getRecentLogEntries];
    [self updateLogWindow:recentLogEntries];
    
	
    [self setupRefreshTimer];
	
}




- (void)windowWillClose:(NSNotification *)notification {
	
    Log_enteredMethod();

	[self teardownRefreshTimer];

}



#pragma mark instance setup/teardown

-(id)init {
    
	
	LogController* answer = [super initWithWindowNibName:@"Log"];
	
		
	return answer;
	
}

-(void)dealloc {
	
    Log_enteredMethod();
	
	[self setLogWindow:nil];	
    
    [self teardownRefreshTimer];
    [self setRefreshTimer:nil];
    [self setLogEntries:nil];
}


#pragma mark fields

//RGLogWindow *_logWindow;
//@property (nonatomic, retain) IBOutlet RGLogWindow* logWindow;
@synthesize logWindow = _logWindow;

//
////LogContainer *_logContainer;
////@property (nonatomic, retain) LogContainer* logContainer;
//@synthesize logContainer = _logContainer;

//NSTimer* _refreshTimer;
//@property (nonatomic, retain) NSTimer* refreshTimer;
@synthesize refreshTimer = _refreshTimer;

// logEntries
//NSArray* _logEntries;
//@property (nonatomic, retain) NSArray* logEntries;
@synthesize logEntries = _logEntries;


@end

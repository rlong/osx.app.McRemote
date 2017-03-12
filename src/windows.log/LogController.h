// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


@class LogWindow;

@interface LogController : NSWindowController {

	LogWindow *_logWindow;
	//@property (nonatomic, retain) IBOutlet RGLogWindow* logWindow;
	//@synthesize logWindow = _logWindow;
	
    
    NSTimer* _refreshTimer;
    //@property (nonatomic, retain) NSTimer* refreshTimer;
    //@synthesize refreshTimer = _refreshTimer;
    
	// logEntries
	NSArray* _logEntries;
	//@property (nonatomic, retain) NSArray* logEntries;
	//@synthesize logEntries = _logEntries;

	
}

#pragma mark instance setup/teardown

	
-(void)teardownRefreshTimer;

#pragma mark public fields
	
//RGLogWindow *_logWindow;
@property (nonatomic, retain) IBOutlet LogWindow* logWindow;
//@synthesize logWindow = _logWindow;

@end

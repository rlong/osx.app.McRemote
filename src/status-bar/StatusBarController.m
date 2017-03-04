// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"

#import "ProcessHelper.h"
#import "StatusBarController.h"


@implementation StatusBarController

#pragma mark lifecycle callbacks 


-(NSImage*)getImage
{
	NSImage* answer = [NSImage imageNamed:@"application-icon.dark-gray.16x12.png"];
	
	
	return answer;
	
}

-(NSImage*)getAlternateImage {

	NSImage* answer = [NSImage imageNamed:@"application-icon.white.16x12.png"];
	
	
	return answer;
	
}


- (void)windowDidLoad {
	

    Log_enteredMethod();
    
	/*
	 http://developer.apple.com/documentation/Cocoa/Conceptual/StatusBar/Tasks/creatingitems.html
	 
	 */
	NSStatusBar* statusBar = [NSStatusBar systemStatusBar];
	NSStatusItem* statusItem = [statusBar statusItemWithLength:NSVariableStatusItemLength];
	// 	
	[statusItem setMenu:_statusBarMenu];
	
	NSImage* image = [self getImage];
	
	if( nil != image ) {
		[statusItem setImage:image];
	}
	else { // shouldn't happen, but we'll apply belts and braces
		[statusItem setTitle:@"RemoteGateway"];
	}
	
	NSImage* alternateImage = [self getAlternateImage];
	if( nil != alternateImage ) {
		[statusItem setAlternateImage:alternateImage];
	}
	
	[statusItem setHighlightMode: YES];
	
	
}

#pragma mark UI callbacks



- (IBAction)about:sender {
	
	// bring the application to the front ... 
	ProcessSerialNumber psn = { 0, kCurrentProcess };
    OSStatus status = [ProcessHelper setFrontProcess:&psn];
    Log_debugInt( status );
	
	[[NSApplication sharedApplication] orderFrontStandardAboutPanel:sender];

	
}

- (IBAction)quit:sender {
    Log_enteredMethod();
	
	[[NSApplication sharedApplication] terminate:sender];
}



#pragma mark - instance setup/teardown

-(id)init {

    Log_enteredMethod();

	StatusBarController* answer = [super initWithWindowNibName:@"StatusBar"];
	
	return answer;
	
}

-(void)dealloc {
	
	
}

#pragma mark fields

//NSMenu *_statusBarMenu;
//@property (nonatomic, retain) IBOutlet NSMenu *statusBarMenu;
@synthesize statusBarMenu = _statusBarMenu;



@end

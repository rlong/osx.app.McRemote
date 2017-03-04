// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "PreferencesController.h"


#import "ApplicationContext.h"
#import "Configuration.h"
#import "ExecutionContext.h"

#import "CALog.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface PreferencesController () 

//LoginItemsHelper *_loginItemsHelper;
@property (nonatomic, retain) LoginItemsHelper *loginItemsHelper;
//@synthesize loginItemsHelper = _loginItemsHelper;




@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation PreferencesController

static PreferencesController* _instance = nil;



+(PreferencesController*)instance {
	
	if( nil == _instance ) {
		_instance = [[PreferencesController alloc] init];
	}
	
	return _instance;
}

#pragma mark UI callbacks 

- (IBAction)showPreferencesOnStartup:(id)sender {

    Log_enteredMethod();
	
	Configuration* configuration = [ApplicationContext getRG2_Configuration];

	if( NSOnState == [[_preferencesWindow showPreferencesOnStartup] state] ) {
		[configuration setShowPreferencesOnStartup:YES];
	} else {
		[configuration setShowPreferencesOnStartup:NO];
	}

	
}

- (IBAction)startAtLogin:(id)sender {
    
    Log_enteredMethod();
	
	if( NSOnState == [[_preferencesWindow startAtLogin] state] ) {
		[_loginItemsHelper addApplicationToLoginItems];
	} else {
		[_loginItemsHelper removeApplicationFromLoginItems];
	}
	
}



-(void)showRestartWarning:(BOOL)showInDock {
	
	NSAlert *alert = [[NSAlert alloc] init];
	[alert addButtonWithTitle:@"OK"];
	
	[alert setMessageText:@"Restart required"];
	
	
	NSString* informativeText = @"For this Application to show in the Dock, you will need to restart this application";
	if( ! showInDock ) {
		informativeText = @"For this Application to show in the status bar, you will need to restart this application";
	}
	
	[alert setInformativeText:informativeText];

	[alert setAlertStyle:NSWarningAlertStyle];
	
	//	[alert runModal];
	[alert beginSheetModalForWindow:_preferencesWindow modalDelegate:nil didEndSelector:nil contextInfo:nil];
	
}

- (IBAction)showInDock:(id)sender {
	
    Log_enteredMethod();
	
	if( NSOnState == [[_preferencesWindow showInDock] state] ) {
		[[_preferencesWindow showInPreview] setImage:[NSImage imageNamed:@"in-the-dock.png"]];
		[self showRestartWarning:YES];
		Configuration* configuration = [ApplicationContext getRG2_Configuration];
		[configuration setForegroundApplication:YES];
	}
	
}

- (IBAction)showInStatusBar:(id)sender {

    Log_enteredMethod();
	
	if( NSOnState == [[_preferencesWindow showInDock] state] ) {
		[[_preferencesWindow showInPreview] setImage:[NSImage imageNamed:@"in-the-status-bar.png"]];
		[self showRestartWarning:NO];
		Configuration* configuration = [ApplicationContext getRG2_Configuration];
		[configuration setForegroundApplication:NO];
	}
	
}



#pragma mark lifecycle callbacks 


- (void)windowDidLoad {
    
    Log_enteredMethod();
	
	Configuration* configuration = [ApplicationContext getRG2_Configuration];
	
	if( [configuration showPreferencesOnStartup] ) {
		[[_preferencesWindow showPreferencesOnStartup] setState:NSOnState];
	} else {
		[[_preferencesWindow showPreferencesOnStartup] setState:NSOffState];
	}
	
	if( [_loginItemsHelper isApplicationInLoginItems] ) {
		[[_preferencesWindow startAtLogin] setState:NSOnState];
	} else {
		[[_preferencesWindow startAtLogin] setState:NSOffState];
	}
	
	if( [configuration foregroundApplication] ) {
		[[_preferencesWindow showInPreview] setImage:[NSImage imageNamed:@"in-the-dock.png"]];
		[[_preferencesWindow showInDock] setState:NSOnState];
		[[_preferencesWindow showInStatusBar] setState:NSOffState];
	} else {
		[[_preferencesWindow showInPreview] setImage:[NSImage imageNamed:@"in-the-status-bar.png"]];
		[[_preferencesWindow showInDock] setState:NSOffState];
		[[_preferencesWindow showInStatusBar] setState:NSOnState];
	}
	
}


#pragma mark instance setup/teardown


-(id)init {
	
    Log_enteredMethod();
	
	PreferencesController* answer = [super initWithWindowNibName:@"Preferences"];
	answer->_loginItemsHelper = [[LoginItemsHelper alloc] init];
	
	return answer;
	
}

-(void)dealloc {
	
    Log_enteredMethod();

    [self setPreferencesWindow:nil];
    [self setLoginItemsHelper:nil];

}



#pragma mark fields

//PreferencesWindow *_preferencesWindow;
//@property (nonatomic, retain) IBOutlet PreferencesWindow *preferencesWindow;
@synthesize preferencesWindow = _preferencesWindow;

//LoginItemsHelper *_loginItemsHelper;
//@property (nonatomic, retain) LoginItemsHelper *loginItemsHelper;
@synthesize loginItemsHelper = _loginItemsHelper;




@end

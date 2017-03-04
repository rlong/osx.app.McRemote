// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Cocoa/Cocoa.h>


@interface PreferencesWindow : NSWindow {
	
	
	NSButton* _showPreferencesOnStartup;
	//@property (nonatomic, retain) IBOutlet NSButton* showPreferencesOnStartup;
	//@synthesize showPreferencesOnStartup = _showPreferencesOnStartup;


	NSButton* _startAtLogin;
	//@property (nonatomic, retain) IBOutlet NSButton* startAtLogin;
	//@synthesize startAtLogin = _startAtLogin;
	
	NSButtonCell* _showInDock;
	//@property (nonatomic, retain) IBOutlet NSButtonCell* showInDock;
	//@synthesize showInDock = _showInDock;
	
	NSButtonCell* _showInStatusBar;
	//@property (nonatomic, retain) IBOutlet NSButtonCell* showInStatusBar;
	//@synthesize showInStatusBar = _showInStatusBar;
	
	NSImageView* _showInPreview;
	//@property (nonatomic, retain) IBOutlet NSImageView* showInPreview;
	//@synthesize showInPreview = _showInPreview;
	
}

//NSButton* _showPreferencesOnStartup;
@property (nonatomic, retain) IBOutlet NSButton* showPreferencesOnStartup;
//@synthesize showPreferencesOnStartup = _showPreferencesOnStartup;


//NSButton* _startAtLogin;
@property (nonatomic, retain) IBOutlet NSButton* startAtLogin;
//@synthesize startAtLogin = _startAtLogin;

//NSButtonCell* _showInDock;
@property (nonatomic, retain) IBOutlet NSButtonCell* showInDock;
//@synthesize showInDock = _showInDock;

//NSButtonCell* _showInStatusBar;
@property (nonatomic, retain) IBOutlet NSButtonCell* showInStatusBar;
//@synthesize showInStatusBar = _showInStatusBar;


//NSImageView* _showInPreview;
@property (nonatomic, retain) IBOutlet NSImageView* showInPreview;
//@synthesize showInPreview = _showInPreview;

@end

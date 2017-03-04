// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "LoginItemsHelper.h"
#import "PreferencesWindow.h"

@interface PreferencesController : NSWindowController {

	PreferencesWindow *_preferencesWindow;
	//@property (nonatomic, retain) IBOutlet PreferencesWindow *preferencesWindow;
	//@synthesize preferencesWindow = _preferencesWindow;
	
	LoginItemsHelper *_loginItemsHelper;
	//@property (nonatomic, retain) LoginItemsHelper *loginItemsHelper;
	//@synthesize loginItemsHelper = _loginItemsHelper;
	
}


+(PreferencesController*)instance;

- (IBAction)showPreferencesOnStartup:(id)sender;
- (IBAction)startAtLogin:(id)sender;
- (IBAction)showInDock:(id)sender;
- (IBAction)showInStatusBar:(id)sender;
	


#pragma mark fields


//PreferencesWindow *_preferencesWindow;
@property (nonatomic, retain) IBOutlet PreferencesWindow *preferencesWindow;
//@synthesize preferencesWindow = _preferencesWindow;

@end

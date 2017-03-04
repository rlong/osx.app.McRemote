// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Cocoa/Cocoa.h>


@interface StatusBarController : NSWindowController {
	
	NSMenu *_statusBarMenu;
	//@property (nonatomic, retain) IBOutlet NSMenu *statusBarMenu;
	//@synthesize statusBarMenu = _statusBarMenu;
	
//	IBOutlet NSMenu *menu;

}


- (IBAction)about:sender;
- (IBAction)quit:sender;


#pragma mark fields

//NSMenu *_statusBarMenu;
@property (nonatomic, retain) IBOutlet NSMenu *statusBarMenu;
//@synthesize statusBarMenu = _statusBarMenu;


@end

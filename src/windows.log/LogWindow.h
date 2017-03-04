// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Cocoa/Cocoa.h>


@interface LogWindow : NSWindow {

	NSTextView *_logText;
	//@property (nonatomic, retain) IBOutlet NSTextView *logText;
	//@synthesize logText = _logText;
	
}



//NSTextView *_logText;
@property (nonatomic, retain) IBOutlet NSTextView *logText;
//@synthesize logText = _logText;


@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"

#import "LogWindow.h"


@implementation LogWindow



#pragma mark <NSNibAwaking> implementation

- (void)awakeFromNib {

    Log_enteredMethod();
	
}

#pragma mark fields


//NSTextView *_logText;
//@property (nonatomic, retain) IBOutlet NSTextView *logText;
@synthesize logText = _logText;



@end

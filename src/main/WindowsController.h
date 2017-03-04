// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

@class LogController;

@interface WindowsController : NSObject {


	LogController* _logController;


}

- (IBAction)showDevices:sender;
- (IBAction)showLog:sender;
- (IBAction)showPreferences:sender;


@end

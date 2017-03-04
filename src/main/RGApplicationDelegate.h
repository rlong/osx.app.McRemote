// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "PreferencesController.h"
#import "BonjourBroadcaster.h"
#import "StatusBarController.h"
#import "WindowsController.h"

#import "HttpServer.h"

@interface RGApplicationDelegate : NSObject <NSApplicationDelegate> {
		
//    RG2_ConnectionListener* _connectionListener;
//    //@property (nonatomic, retain) ConnectionListener* connectionListener;
//    //@synthesize connectionListener = _connectionListener;
//    
    
//    NSWindow *_window;
    
    //@property (assign) IBOutlet NSWindow *window;
    //@synthesize window = _window;
    
    //	WindowsController* _windowsController;
    
    //	PreferencesController *_preferencesController;
    
    //	DevicesController *_devicesController;
    
    //	LogController* _logController;
//    
//    
//    
//    NSTimer* _cleanupTimer;
//    //@property (nonatomic, retain) NSTimer* cleanupTimer;
//    //@synthesize cleanupTimer = _cleanupTimer;
//    
//    RG2_LogContainer* _logContainer;
//    //@property (nonatomic, retain) LogContainer* logContainer;
//    //@synthesize logContainer = _logContainer;
    
    BonjourBroadcaster* _serviceBroadcaster;
    //@property (nonatomic, retain) ServiceBroadcaster* serviceBroadcaster;
    //@synthesize serviceBroadcaster = _serviceBroadcaster;
    
    BOOL _standardNotificationsActive;
    
    
	// windowsController
	WindowsController* IBOutlet _windowsController;
	//@property (nonatomic, retain) WindowsController* windowsController;
	//@synthesize windowsController = _windowsController;
    
    
    // remoteGatewayServer
	HttpServer* _remoteGatewayServer;
	//@property (nonatomic, retain) RemoteGatewayServer* remoteGatewayServer;
	//@synthesize remoteGatewayServer = _remoteGatewayServer;

		
}


//- (IBAction)showPreferences:sender;
//- (IBAction)showPairedDevices:sender;
//- (IBAction)showLog:sender;


#pragma mark fields

////ConnectionListener* _connectionListener;
//@property (nonatomic, retain) RG2_ConnectionListener* connectionListener;
////@synthesize connectionListener = _connectionListener;


//NSWindow *_window;
@property (assign) IBOutlet NSWindow *window;
//@synthesize window = _window;

//
////NSTimer* _cleanupTimer;
//@property (nonatomic, retain) NSTimer* cleanupTimer;
////@synthesize cleanupTimer = _cleanupTimer;

// windowsController
//WindowsController* IBOutlet _windowsController;
@property (nonatomic, retain) WindowsController* windowsController;
//@synthesize windowsController = _windowsController;

@end

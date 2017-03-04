// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CALog.h"

#import "ApplicationContext.h"
#import "NetworkSetupChangeListener.h"
#import "HttpServer.h"
#import "ProcessHelper.h"
#import "ApplicationDelegate.h"
#import "Configuration.h"
#import "ExecutionContext.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface ApplicationDelegate () 

//
////LogContainer* _logContainer;
//@property (nonatomic, retain) RG2_LogContainer* logContainer;
////@synthesize logContainer = _logContainer;

//ServiceBroadcaster* _serviceBroadcaster;
@property (nonatomic, retain) BonjourBroadcaster* serviceBroadcaster;
//@synthesize serviceBroadcaster = _serviceBroadcaster;



// remoteGatewayServer
//RemoteGatewayServer* _remoteGatewayServer;
@property (nonatomic, retain) HttpServer* remoteGatewayServer;
//@synthesize remoteGatewayServer = _remoteGatewayServer;



@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////



@implementation ApplicationDelegate



-(void)connectionListenerAlertCallback:(NSAlert*)alert {
    
    Log_enteredMethod();
	//[RG2_Log entered:__func__];

}


#pragma mark notfication support



-(void)setupStandardNotifications {
	
	if( _standardNotificationsActive ) {
        Log_warn(@"_standardNotificationsActive");
		//[RG2_Log warn:@"_standardNotificationsActive" inFunction:__func__];
		return;
	}
	
	_standardNotificationsActive = TRUE;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(handleNotification:)  name:NetworkSetupChangeListener_NetworkSetupChanged_Notification object:nil];

	
}


-(void)teardownStandardNotifications{
	
	if( !_standardNotificationsActive ) {
        Log_warn( @"!_standardNotificationsActive" );
		//[RG2_Log warn:@"!_standardNotificationsActive" inFunction:__func__];
		return;
	}
	
	_standardNotificationsActive = FALSE;
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkSetupChangeListener_NetworkSetupChanged_Notification object:nil];

}



- (void)handleNotificationFrom:(id)notificationSource withName:(NSString*)notificationName userInfo:(NSDictionary *)userInfo {
	
	if( [NetworkSetupChangeListener_NetworkSetupChanged_Notification isEqualToString:notificationName] ) {
		[_serviceBroadcaster endBroadcast];
		[_serviceBroadcaster beginBroadcast];
		return;
	}
    Log_warnString( notificationName );
	//[RG2_Log warnString:notificationName withName:@"notificationName" inFunction:__func__];
	
}

- (void)handleNotification:(NSNotification *)notification {
	[self handleNotificationFrom:[notification object] withName:[notification name] userInfo:[notification userInfo]];
	
}


#pragma mark application lifecycle


-(void)startRemoteGateway {
	
    
    bool runningInTheDock = true; 
    {
        Configuration* configuration = [ApplicationContext getRG2_Configuration];
        if( ! [configuration foregroundApplication] ) {
            runningInTheDock = false;
            
        }
    }
    HttpServerContext* serverObjects = [ApplicationContext getRemoteGatewayObjects];

    bool runningInTheStatusBar = !runningInTheDock;
    
	BOOL connectionListenerStarted = FALSE;
    
	while ( !connectionListenerStarted ) {
		
		@try {

            _remoteGatewayServer = [[HttpServer alloc] initWithRemoteGatewayObjects:serverObjects runningInTheDock:runningInTheDock runningInTheStatusBar:runningInTheStatusBar];
            [_remoteGatewayServer start];
			connectionListenerStarted = TRUE;
		}
		@catch (BaseException* e) {
            Log_errorException( e );
			
			NSAlert *alert = [[NSAlert alloc] init];
			[alert addButtonWithTitle:@"Quit"]; // NSAlertFirstButtonReturn  
			[alert addButtonWithTitle:@"Retry"]; // NSAlertSecondButtonReturn
			
			NSString* messageText = [NSString stringWithFormat:@"Failed to Start"];
			[alert setMessageText:messageText];
			
            NSString* informativeText = nil;
            {
                informativeText = [e underlyingFaultMessage];
                if( nil == informativeText ) { 
                    informativeText = [e reason];
                }
            }
            if( nil != informativeText ) {
                
                [alert setInformativeText:informativeText];
                
            }
			//[alert setInformativeText:[e technicalError]];
			[alert setAlertStyle:NSWarningAlertStyle];
			
			
			NSInteger response = [alert runModal];
			if( NSAlertFirstButtonReturn == response ) {
				
                Log_debug( @"quit" );
				//[RG2_Log debug:@"quit" inFunction:__func__];
				[[NSApplication sharedApplication] terminate:self];
				return;
				
			} else {
				
                Log_debug( @"retry" );
				//[RG2_Log debug:@"retry" inFunction:__func__];
                
				//[self setConnectionListener:[[RG2_ConnectionListener alloc] init]];
                
			}
			// [Log debugInt:response withName:@"response" inFunction:__func__];
			//		[alert beginSheetModalForWindow:_devicesWindow modalDelegate:self didEndSelector:@selector(removeAlertCallback:) contextInfo:nil];
			
		}
	}
}





- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
    Log_enteredMethod();
    
    
    [ApplicationContext setup];

	[self setupStandardNotifications];
    
	
	[NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
    
    {
        Configuration* configuration = [ApplicationContext getRG2_Configuration];
        
        if( ! [configuration foregroundApplication] ) {
            StatusBarController* statusBarController = [[StatusBarController alloc] init];
            [statusBarController showWindow:self];
        } 
    }
	
	[NetworkSetupChangeListener begin];
	
    [self startRemoteGateway];
    
	
	[_serviceBroadcaster beginBroadcast];
    
    {
        
        Configuration* configuration = [ApplicationContext getRG2_Configuration];

        if( [configuration showPreferencesOnStartup] ) {
            PreferencesController* preferencesController = [PreferencesController instance];
            
            // bring the application to the front ... 
            ProcessSerialNumber psn = { 0, kCurrentProcess };
            OSStatus status = [ProcessHelper setFrontProcess:&psn];
            Log_debugInt( status );
            //[RG2_Log debugInt:status withName:@"status" inFunction:__func__];
            
            [preferencesController showWindow:self];
            
        }

    }
	
	
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
    Log_enteredMethod();
	//[RG2_Log entered:__func__];
	
	[self teardownStandardNotifications];
    
	
	[ExecutionContext saveConfiguration];
	
	[_serviceBroadcaster endBroadcast];
	
	//[self teardownCleanupTimer];
	

	
}




#pragma mark instance lifecycle

- (id)init {


	ApplicationDelegate* answer = [super init];
	
	answer->_standardNotificationsActive = NO;
	
	answer->_serviceBroadcaster = [[BonjourBroadcaster alloc] init];
	
	return answer;
	
}


-(void)dealloc {
	
	[self teardownStandardNotifications];
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	
	
	[self setServiceBroadcaster:nil];
    [self setWindowsController:nil];
	[self setRemoteGatewayServer:nil];

	
//	[super dealloc];
}


#pragma mark fields



//NSWindow *_window;
//@property (assign) IBOutlet NSWindow *window;
@synthesize window = _window;

//
////NSTimer* _cleanupTimer;
////@property (nonatomic, retain) NSTimer* cleanupTimer;
//@synthesize cleanupTimer = _cleanupTimer;
//
//
////LogContainer* _logContainer;
////@property (nonatomic, retain) LogContainer* logContainer;
//@synthesize logContainer = _logContainer;

//ServiceBroadcaster* _serviceBroadcaster;
//@property (nonatomic, retain) ServiceBroadcaster* serviceBroadcaster;
@synthesize serviceBroadcaster = _serviceBroadcaster;

// windowsController
//WindowsController* IBOutlet _windowsController;
//@property (nonatomic, retain) WindowsController* windowsController;
@synthesize windowsController = _windowsController;


// remoteGatewayServer
//RemoteGatewayServer* _remoteGatewayServer;
//@property (nonatomic, retain) RemoteGatewayServer* remoteGatewayServer;
@synthesize remoteGatewayServer = _remoteGatewayServer;


@end

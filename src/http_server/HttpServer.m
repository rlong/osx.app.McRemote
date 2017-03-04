// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AboutService.h"
#import "AppleScriptService.h"
#import "HttpServer.h"

#import "CAFileUtilities.h"
#import "CALog.h"
#import "CAWorkManager.h"

#import "HLAuthRequestHandler.h"
#import "HLFileGetRequestHandler.h"
#import "HLOpenRequestHandler.h"
#import "HLRootRequestHandler.h"
#import "HLServicesRegistery.h"
#import "HLServicesRequestHandler.h"
#import "HLTestService.h"


#import "HLFileService.h"
#import "HLFileTransactionManager.h"
#import "HLFileDownloadRequestHandler.h"

#import "NTJsonRequestHandler.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface HttpServer () 


// runningInTheDock
//bool _runningInTheDock;
@property (nonatomic) bool runningInTheDock;
//@synthesize runningInTheDock = _runningInTheDock;


// runningInTheStatusBar
//bool _runningInTheStatusBar;
@property (nonatomic) bool runningInTheStatusBar;
//@synthesize runningInTheStatusBar = _runningInTheStatusBar;



// rootProcessor
//RootProcessor* _rootProcessor;
@property (nonatomic, retain) HLRootRequestHandler* rootProcessor;
//@synthesize rootProcessor = _rootProcessor;



// serverObjects
//RGServerObjects* _serverObjects;
@property (nonatomic, retain) HttpServerContext* serverObjects;
//@synthesize serverObjects = _serverObjects;

// webServer
//HLWebServer* _webServer;
@property (nonatomic, retain) HLWebServer* webServer;
//@synthesize webServer = _webServer;


#pragma mark instance lifecycle

-(id)initWithRemoteGatewayObjects:(HttpServerContext*)serverObjects runningInTheDock:(bool)runningInTheDock runningInTheStatusBar:(bool)runningInTheStatusBar;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation HttpServer



NTJsonRequestHandler* _jsonRequestHandler;



#pragma mark - instance lifecycle



-(id)initWithRemoteGatewayObjects:(HttpServerContext*)serverObjects runningInTheDock:(bool)runningInTheDock runningInTheStatusBar:(bool)runningInTheStatusBar {
    
    HttpServer* answer = [super init];
    
    if( nil != answer ) {
        
        [answer setServerObjects:serverObjects];
        answer->_runningInTheDock = runningInTheDock;
        answer->_runningInTheStatusBar = runningInTheStatusBar;
        
        [answer setRootProcessor:[answer buildRootProcessor]];
        
        
        Log_info( @"setting up '/services' ... " );
        id<HLRequestHandler> requestHandler = [answer buildOpenServicesRequestHandler];
        [answer->_rootProcessor addRequestHandler:requestHandler];
        
        Log_info( @"setting up '/_dynamic_/auth' ... ");
        HLAuthRequestHandler* authProcessor = [answer buildAuthProcessor];
        [answer->_rootProcessor addRequestHandler:authProcessor];
        
    
        // request handlers ...
        {
            HLFileDownloadRequestHandler* fileDownloadRequestHandler = [[HLFileDownloadRequestHandler alloc] init];
            [answer->_rootProcessor addRequestHandler:fileDownloadRequestHandler];
            
            _jsonRequestHandler = [[NTJsonRequestHandler alloc] init];
            [answer->_rootProcessor addRequestHandler:_jsonRequestHandler];
        }
    }
    
    return answer;
    
}

-(void)dealloc {
    
    
    [self setRootProcessor:nil];
    [self setServerObjects:nil];
    [self setWebServer:nil];
    
    
}


#pragma mark -

-(HLServicesRequestHandler*)buildOpenServicesRequestHandler {
    
    
    HLServicesRegistery* servicesRegistery = [[HLServicesRegistery alloc] init];
    
    {
        
        NSString* realm = [[_serverObjects securityConfiguration] realm];
        
        [servicesRegistery addService:[[AboutService alloc] initWithRealm:realm]];

        {
            HLTestService* testService = [[HLTestService alloc] init];
            [servicesRegistery addService:testService];
        }
        
        {
            HLFileTransactionManager* fileJobManager = [[HLFileTransactionManager alloc] init];
            
            HLFileService* fileService = [[HLFileService alloc] initWithFileTransactionManager:fileJobManager];
            [servicesRegistery addService:fileService];
            
        }
    }
    
    [self addAppleScriptServiceWithScriptName:@"clipboard" toServicesRegistery:servicesRegistery];
    [self addAppleScriptServiceWithScriptName:@"com.apple.DVDPlayer" toServicesRegistery:servicesRegistery];
    [self addAppleScriptServiceWithScriptName:@"finder" toServicesRegistery:servicesRegistery];
    [self addAppleScriptServiceWithScriptName:@"system-test" toServicesRegistery:servicesRegistery];

    HLServicesRequestHandler* answer = [[HLServicesRequestHandler alloc] initWithServicesRegistery:servicesRegistery];

    return answer;
    
}


-(void)addAppleScriptServiceWithScriptName:(NSString*)scriptName toServicesRegistery:(HLServicesRegistery*)servicesRegistery {
    
    AppleScriptService* service = [[AppleScriptService alloc] initWithScriptName:scriptName];
    [servicesRegistery addService:service];
    
    
}

-(HLAuthRequestHandler*)buildAuthProcessor { 

    HLAuthRequestHandler* answer = [[HLAuthRequestHandler alloc] initWithSecurityManager:[_serverObjects httpSecurityManager]];

    HLServicesRegistery* servicesRegistery = [[HLServicesRegistery alloc] init];
    
    {
        
        {
            HLFileTransactionManager* fileJobManager = [[HLFileTransactionManager alloc] init];
            
            HLFileService* fileService = [[HLFileService alloc] initWithFileTransactionManager:fileJobManager];
            [servicesRegistery addService:fileService];
        }
        
        
        
        //////////////////////////////////////////////////////////////////
        //        
        HLTestService* testService = [[HLTestService alloc] init];
        {
            [servicesRegistery addService:testService];
        }

        
        //////////////////////////////////////////////////////////////////
        //        
        

        [self addAppleScriptServiceWithScriptName:@"back-row.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"dvd-remote.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"dvd-remote.2" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"presentation-remote.powerpoint.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"qt-remote.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"qt-remote.2" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"remote-gateway.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"system-test" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"system-test.1" toServicesRegistery:servicesRegistery];
        [self addAppleScriptServiceWithScriptName:@"system-test.2" toServicesRegistery:servicesRegistery];


    }
    
    HLServicesRequestHandler* servicesProcessor = [[HLServicesRequestHandler alloc] initWithServicesRegistery:servicesRegistery];

    [answer addRequestHandler:servicesProcessor];

    

    return answer;
                              
    
}


-(HLRootRequestHandler*)buildRootProcessor {
    
    HLRootRequestHandler* answer;
    
    
    
    HLFileGetRequestHandler* fileRequestHandler;
    {
        NSString* site = [[NSBundle mainBundle] pathForResource:@"browser.site.McRemote" ofType:nil];
        
#ifdef DEBUG
        NSString* devSite = [@"~/Projects/osx.app.McRemote/Projects/browser.site.McRemote" stringByExpandingTildeInPath];
        if( [CAFileUtilities fileExistsAtPath:devSite] ) {
            site = devSite;
        }
#endif
        Log_debugString( site );

        fileRequestHandler = [[HLFileGetRequestHandler alloc] initWithRootFolder:site];

    }
    
    answer = [[HLRootRequestHandler alloc] initWithDefaultProcessor:fileRequestHandler];
    
    return answer;
    
}



-(void)addAuthService:(id<HLDescribedService>)service {
    
    [_serverObjects addAuthService:service];
    
}


-(void)start {
    
    Log_info( @"setting up security janitor ... " );
    [[_serverObjects httpSecurityJanitor] start];

    NSInteger port = 8081;
#ifdef DEBUG
    port = 21318;
#endif
    
    HLWebServer* webserver = [[HLWebServer alloc] initWithPort:(int)port httpProcessor:_rootProcessor];
    [self setWebServer:webserver];
    
    [webserver start];
    
    Log_infoFormat( @"web server is running: http://127.0.0.1:%d", port );
  
}


#pragma mark fields


// runningInTheDock
//bool _runningInTheDock;
//@property (nonatomic) bool runningInTheDock;
@synthesize runningInTheDock = _runningInTheDock;

// runningInTheStatusBar
//bool _runningInTheStatusBar;
//@property (nonatomic) bool runningInTheStatusBar;
@synthesize runningInTheStatusBar = _runningInTheStatusBar;


// rootProcessor
//RootProcessor* _rootProcessor;
//@property (nonatomic, retain) RootProcessor* rootProcessor;
@synthesize rootProcessor = _rootProcessor;

// serverObjects
//RGServerObjects* _serverObjects;
//@property (nonatomic, retain) RGServerObjects* serverObjects;
@synthesize serverObjects = _serverObjects;


// webServer
//HLWebServer* _webServer;
//@property (nonatomic, retain) HLWebServer* webServer;
@synthesize webServer = _webServer;


@end

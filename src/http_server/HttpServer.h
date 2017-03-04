// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "HttpServerContext.h"

#import "HLHttpSecurityJanitor.h"
#import "HLHttpSecurityManager.h"
#import "HLRootRequestHandler.h"
#import "HLSecurityConfiguration.h"
#import "HLWebServer.h"




@interface HttpServer : NSObject {
    
    
    // runningInTheDock
	bool _runningInTheDock;
	//@property (nonatomic) bool runningInTheDock;
	//@synthesize runningInTheDock = _runningInTheDock;

    // runningInTheStatusBar
	bool _runningInTheStatusBar;
	//@property (nonatomic) bool runningInTheStatusBar;
	//@synthesize runningInTheStatusBar = _runningInTheStatusBar;

    

    // rootProcessor
	HLRootRequestHandler* _rootProcessor;
	//@property (nonatomic, retain) RootProcessor* rootProcessor;
	//@synthesize rootProcessor = _rootProcessor;


	// serverObjects
	HttpServerContext* _serverObjects;
	//@property (nonatomic, retain) RGServerObjects* serverObjects;
	//@synthesize serverObjects = _serverObjects;

    // webServer
	HLWebServer* _webServer;
	//@property (nonatomic, retain) HLWebServer* webServer;
	//@synthesize webServer = _webServer;
    
    

}


-(void)start;


#pragma mark instance lifecycle

-(id)initWithRemoteGatewayObjects:(HttpServerContext*)serverObjects runningInTheDock:(bool)runningInTheDock runningInTheStatusBar:(bool)runningInTheStatusBar;


@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "HLConfigurationService.h"
#import "HLHttpSecurityJanitor.h"
#import "HLHttpSecurityManager.h"
#import "HLSecurityConfiguration.h"
#import "HLServicesRegistery.h"


@interface HttpServerContext : NSObject {
    
    
    // httpSecurityManager
	HLHttpSecurityManager* _httpSecurityManager;
	//@property (nonatomic, retain) HttpSecurityManager* httpSecurityManager;
	//@synthesize httpSecurityManager = _httpSecurityManager;

    
    // securityConfiguration
	HLSecurityConfiguration* _securityConfiguration;
	//@property (nonatomic, retain) SecurityConfiguration* securityConfiguration;
	//@synthesize securityConfiguration = _securityConfiguration;

    // httpSecurityJanitor
	HLHttpSecurityJanitor* _httpSecurityJanitor;
	//@property (nonatomic, retain) HttpSecurityJanitor* httpSecurityJanitor;
	//@synthesize httpSecurityJanitor = _httpSecurityJanitor;
    
	// authServices
	HLServicesRegistery* _authServices;
	//@property (nonatomic, retain) ServicesRegistery* authServices;
	//@synthesize authServices = _authServices;


}

-(void)addAuthService:(id<HLDescribedService>)service;

#pragma mark instance lifecycle 

-(id)initWithArguments:(NSArray*)arguments;

#pragma mark fields


// httpSecurityManager
//HttpSecurityManager* _httpSecurityManager;
@property (nonatomic, retain) HLHttpSecurityManager* httpSecurityManager;
//@synthesize httpSecurityManager = _httpSecurityManager;


// securityConfiguration
//SecurityConfiguration* _securityConfiguration;
@property (nonatomic, retain) HLSecurityConfiguration* securityConfiguration;
//@synthesize securityConfiguration = _securityConfiguration;



// configurationService
//ConfigurationService* _configurationService;
@property (nonatomic, retain) HLConfigurationService* configurationService;
//@synthesize configurationService = _configurationService;


// httpSecurityJanitor
//HttpSecurityJanitor* _httpSecurityJanitor;
@property (nonatomic, retain) HLHttpSecurityJanitor* httpSecurityJanitor;
//@synthesize httpSecurityJanitor = _httpSecurityJanitor;

// authServices
//ServicesRegistery* _authServices;
@property (nonatomic, retain) HLServicesRegistery* authServices;
//@synthesize authServices = _authServices;



@end

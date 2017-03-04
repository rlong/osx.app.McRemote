// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CABaseException.h"

#import "HLConfigurationService.h"
#import "HLKeychainSecurityAdapter.h"
#import "HLSecurityConfiguration.h"

// #import "ConfigurationServiceHelper.h"
// #import "RGSecurityConfigurationHelper.h"
#import "HttpServerContext.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface HttpServerContext () 


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation HttpServerContext








-(void)addAuthService:(id<HLDescribedService>)service {
    
    [_authServices addService:service];
    
}

#pragma mark instance lifecycle 

-(id)initWithArguments:(NSArray*)arguments {
    
    
    HttpServerContext* answer = [super init];
    
    if( nil != answer )  {
        
        
        answer->_httpSecurityManager = [[HLHttpSecurityManager alloc] initWithSecurityConfiguration:answer->_securityConfiguration];
        answer->_httpSecurityJanitor = [[HLHttpSecurityJanitor alloc] initWithHttpSecurityManager:answer->_httpSecurityManager];
        answer->_authServices = [[HLServicesRegistery alloc] init];
    }
    
    return answer;
    
}


-(void)dealloc {
	
    [self setHttpSecurityManager:nil];
	[self setSecurityConfiguration:nil];
    
    [self setConfigurationService:nil];
    [self setHttpSecurityJanitor:nil];
	[self setAuthServices:nil];
    
}
#pragma mark fields


// httpSecurityManager
//HttpSecurityManager* _httpSecurityManager;
//@property (nonatomic, retain) HttpSecurityManager* httpSecurityManager;
@synthesize httpSecurityManager = _httpSecurityManager;

// securityConfiguration
//SecurityConfiguration* _securityConfiguration;
//@property (nonatomic, retain) SecurityConfiguration* securityConfiguration;
@synthesize securityConfiguration = _securityConfiguration;


// configurationService
//ConfigurationService* _configurationService;
//@property (nonatomic, retain) ConfigurationService* configurationService;
@synthesize configurationService = _configurationService;


// httpSecurityJanitor
//HttpSecurityJanitor* _httpSecurityJanitor;
//@property (nonatomic, retain) HttpSecurityJanitor* httpSecurityJanitor;
@synthesize httpSecurityJanitor = _httpSecurityJanitor;

// authServices
//ServicesRegistery* _authServices;
//@property (nonatomic, retain) ServicesRegistery* authServices;
@synthesize authServices = _authServices;



@end

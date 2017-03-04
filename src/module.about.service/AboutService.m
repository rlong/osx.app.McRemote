// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#if defined(__MAC_OS_X_VERSION_MIN_REQUIRED)

#else  

#include <UIKit/UIKit.h> // for 'UIDevice' below 

#endif 


#import "CALog.h"
#import "CAJsonObject.h"

#import "AboutService.h"
#import "HLServiceHelper.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface AboutService () 

// applicationId
//NSString* _applicationId;
@property (nonatomic, retain) NSString* applicationId;
//@synthesize applicationId = _applicationId;


// realm
//NSString* _realm;
@property (nonatomic, retain) NSString* realm;
//@synthesize realm = _realm;



// aboutInformation
//JsonObject* _aboutInformation;
@property (nonatomic, retain) CAJsonObject* aboutInformation;
//@synthesize aboutInformation = _aboutInformation;


@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -



@implementation AboutService

static NSString* _SERVICE_NAME = @"osx.app.Mc-Remote.AboutService";
static HLServiceDescription* _SERVICE_DESCRIPTION = nil;

static NSString* _REMOTE_GATEWAY_APPLICATION_ID = @"osx.app.Mc-Remote";




+(void)initialize {
	
    _SERVICE_DESCRIPTION = [[HLServiceDescription alloc] initWithServiceName:_SERVICE_NAME];
	
}



+(NSString*)SERVICE_NAME { 
    return _SERVICE_NAME;
}


+(NSString*)REMOTE_GATEWAY_APPLICATION_ID {
    return _REMOTE_GATEWAY_APPLICATION_ID;
}




#pragma mark -
#pragma mark instance lifecycle




-(id)initWithApplicationId:(NSString*)applicationId realm:(NSString*)realm {
    
    AboutService* answer = [super init];
    
    if( nil != answer ) {
        
        Log_debugString( applicationId );
        [answer setApplicationId:applicationId];
        [answer setRealm:realm];
    }
    
    return answer;
    
}



-(id)initWithRealm:(NSString*)realm {
    
    return [self initWithApplicationId:_REMOTE_GATEWAY_APPLICATION_ID realm:realm];
    
}



#pragma mark - <DescribedService> implementation



-(NSString*)getHostName {
    
    NSString* answer= nil;
    
#if defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    //#ifdef MACOSX_DEPLOYMENT_TARGET
	
	// OSX ... 
    
    
    // vvv http://stackoverflow.com/questions/4063129/get-computer-name-on-mac
    
    answer = [[NSHost currentHost] localizedName];

    // ^^^ http://stackoverflow.com/questions/4063129/get-computer-name-on-mac
    
#else  

    answer = [[UIDevice currentDevice] name];
    
#endif 
    
    Log_debugString( answer );
    
    return answer;
    
}

-(CAJsonObject*)buildAboutInformation {
    
    CAJsonObject* answer = [[CAJsonObject alloc] init];
    
    [answer setObject:[self getHostName] forKey:@"hostName"];
    [answer setObject:_realm forKey:@"realm"];
    [answer setObject:_applicationId forKey:@"applicationId"];
    
    return answer;
    
}

-(CAJsonObject*)getAboutInformation {
    
    if( nil == _aboutInformation ) {
        CAJsonObject* aboutInformation = [self buildAboutInformation];
        [self setAboutInformation:aboutInformation];
    }
    
    return _aboutInformation;
    
    
}

//	public BrokerMessage process( BrokerMessage message );
-(HLBrokerMessage*)process:(HLBrokerMessage*)request {
	
    //	//String methodName = request.getMethodName();
    NSString* methodName = [request methodName];
    	
    if( [@"getAboutInformation" isEqualToString:methodName] ) { 
        
        CAJsonObject* aboutInformation = [self getAboutInformation];
        
        HLBrokerMessage* response = [HLBrokerMessage buildResponse:request];

        [response setAssociativeParamaters:aboutInformation];
        return response;
    }
    
    @throw [HLServiceHelper methodNotFound:self request:request];
}



-(HLServiceDescription*)serviceDescription {
    return _SERVICE_DESCRIPTION;
}


-(void)dealloc {
	
    [self setApplicationId:nil];
    [self setRealm:nil];

    [self setAboutInformation:nil];
	
	
}

#pragma mark -
#pragma mark fields

// applicationId
//NSString* _applicationId;
//@property (nonatomic, retain) NSString* applicationId;
@synthesize applicationId = _applicationId;

// realm
//NSString* _realm;
//@property (nonatomic, retain) NSString* realm;
@synthesize realm = _realm;


// aboutInformation
//JsonObject* _aboutInformation;
//@property (nonatomic, retain) JsonObject* aboutInformation;
@synthesize aboutInformation = _aboutInformation;


@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




#import "ApplicationContext.h"
#import "ExecutionContext.h"

#import "CALog.h"
#import "CADefaults.h"
#import "CASimpleLogConsumer.h"


#import "HLTestService.h"
#import "HLServicesRegistery.h"

#import "NTConfigurationSet.h"


@implementation ApplicationContext

static Configuration* _rg2Configuration = nil;
static HttpServerContext* _remoteGatewayObjects = nil;
static CASimpleLogConsumer* _logConsumer= nil;
static NTConfigurationSet* _configurationSet = nil;



static bool BUILD_BLUETOOTH_SERVER;

+(void)initialize {
    
    
#ifdef DEBUG
    BUILD_BLUETOOTH_SERVER = true;
#else

    CADefaults* defaults = [CADefaults getDefaultsForScope:@"remote_gateway.ApplicationObjects"];
    BUILD_BLUETOOTH_SERVER = [defaults boolWithName:@"BUILD_BLUETOOTH_SERVER" defaultValue:false];

#endif
    
    if( BUILD_BLUETOOTH_SERVER ) {
        
        Log_infoBool( BUILD_BLUETOOTH_SERVER );
        
    } else {
        
        Log_debugBool( BUILD_BLUETOOTH_SERVER );
        
    }
    
    
}


+(NTConfiguration*)configurationWithName:(NSString*)name;
{
    return [_configurationSet getConfigurationWithName:name];
}



+(CASimpleLogConsumer*)getLogConsumer {
    return _logConsumer;
}

+(void)setLogConsumer:(CASimpleLogConsumer*)logConsumer {
    
    _logConsumer = logConsumer;
    
    
}


+(Configuration*)getRG2_Configuration {
    
    return _rg2Configuration;
    
}

+(void)setRG2_Configuration:(Configuration*)rg2Configuration {
    
    _rg2Configuration = rg2Configuration;

}


+(HttpServerContext*)getRemoteGatewayObjects {
    
    return _remoteGatewayObjects;
    
}
+(void)setRemoteGatewayObjects:(HttpServerContext*)remoteGatewayObjects {

    _remoteGatewayObjects = remoteGatewayObjects;
    

}





+(void)setup {
    
    {
        CASimpleLogConsumer* logConsumer = [[CASimpleLogConsumer alloc] init];
        [CALog setLogConsumer:logConsumer forCaller:__func__];
        [self setLogConsumer:logConsumer];
    }

    {
        Configuration* configuration = [ExecutionContext configuration];
        [self setRG2_Configuration:configuration];

    }
    
    {
        NSArray* arguments = [[NSProcessInfo processInfo] arguments];
        
        HttpServerContext* remoteGatewayObjects = [[HttpServerContext alloc] initWithArguments:arguments];
        [self setRemoteGatewayObjects:remoteGatewayObjects];
        
    }
    
    _configurationSet = [[NTConfigurationSet alloc] init];
}





@end

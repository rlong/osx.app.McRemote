// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "HttpServerContext.h"
#import "Configuration.h"

@class CASimpleLogConsumer;

@class NTConfiguration;


@interface ApplicationContext : NSObject {
    
}

+(NTConfiguration*)configurationWithName:(NSString*)name;

+(CASimpleLogConsumer*)getLogConsumer;
+(void)setLogConsumer:(CASimpleLogConsumer*)logConsumer;


+(Configuration*)getRG2_Configuration;
+(void)setRG2_Configuration:(Configuration*)rg2Configuration;


+(HttpServerContext*)getRemoteGatewayObjects;
+(void)setRemoteGatewayObjects:(HttpServerContext*)remoteGatewayObjects;




+(void)setup;


@end

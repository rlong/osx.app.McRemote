// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "AppleScriptService.h"

#import "CALog.h"

#import "HLServiceHelper.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface AppleScriptService () 

// scriptName
//NSString* _scriptName;
@property (nonatomic, retain) NSString* scriptName;
//@synthesize scriptName = _scriptName;

// serviceDescription
//ServiceDescription* _serviceDescription;
@property (nonatomic, retain) HLServiceDescription* serviceDescription;
//@synthesize serviceDescription = _serviceDescription;

// script
//AppleScript* _script;
@property (nonatomic, retain) AppleScript* script;
//@synthesize script = _script;

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -



@implementation AppleScriptService


#pragma mark instance lifecycle


-(id)initWithScriptName:(NSString*)scriptName {
    
    AppleScriptService* answer = [super init];
    
    if( nil != answer ) {
        
        [answer setScriptName:scriptName];
        
        NSString* serviceName = [AppleScriptService serviceNameForScript:scriptName];
        Log_debugString(serviceName);
        
        answer->_serviceDescription = [[HLServiceDescription alloc] initWithServiceName:serviceName];
        
    }
    
    return answer;
    
}

-(void)dealloc {
    
    [self setScriptName:nil];
    [self setServiceDescription:nil];
    [self setScript:nil];
    
    
}

#pragma mark - 


+(NSString*)serviceNameForScript:(NSString*)scriptName {
    
    NSString* answer = [NSString stringWithFormat:@"remote_gateway.AppleScriptService:%@", scriptName];
    Log_debugString(answer);
    
    return answer;    
    
}



-(AppleScript*)getScript { 
    
    if( nil != _script ) { 
        return _script;
    }
    
    _script = [[AppleScript alloc] initWithScriptName:_scriptName];
    return _script;
    
}


-(id)executeMethodWithName:(NSString*)methodName parameters:(CAJsonArray*)parameters {

    AppleScript* script = [self getScript];
    
    id answer = [script executeMethodWithName:methodName parameters:parameters];
    return answer;

}

#pragma mark <DescribedService> implementation


-(HLBrokerMessage*)process:(HLBrokerMessage*)request {
    
    NSString* methodName = [request methodName];
    CAJsonArray* orderedParamaters = [request orderedParamaters];
    
    id scriptResponse = [self executeMethodWithName:methodName parameters:orderedParamaters];
    
    HLBrokerMessage* answer = [HLBrokerMessage buildResponse:request];
    orderedParamaters = [answer orderedParamaters];
    [orderedParamaters add:scriptResponse];
    return answer;

}
-(HLServiceDescription*)serviceDescription {
    return _serviceDescription;
}



#pragma mark fields


// scriptName
//NSString* _scriptName;
//@property (nonatomic, retain) NSString* scriptName;
@synthesize scriptName = _scriptName;

// serviceDescription
//ServiceDescription* _serviceDescription;
//@property (nonatomic, retain) ServiceDescription* serviceDescription;
@synthesize serviceDescription = _serviceDescription;

// script
//AppleScript* _script;
//@property (nonatomic, retain) AppleScript* script;
@synthesize script = _script;

@end

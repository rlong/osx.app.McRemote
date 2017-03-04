// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "HLBrokerMessage.h"
@class CAJsonArray;

@interface MethodCallTransformer : NSObject 
{
	
}


+(NSAppleEventDescriptor *)transformMethodName:(NSString*)methodName withParamaters:(CAJsonArray*)paramaters;

//+(NSAppleEventDescriptor *)transform:(BrokerMessage*)request;


@end

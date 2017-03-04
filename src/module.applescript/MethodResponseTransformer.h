// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



@interface MethodResponseTransformer : NSObject {

}

//+(XRMessage*)transform:(NSAppleEventDescriptor*)responseDescriptor;

//+(BrokerMessage*)transform:(NSAppleEventDescriptor*)responseDescriptor forRequest:(BrokerMessage*)request;

+(id)transform:(NSAppleEventDescriptor*)responseDescriptor;



@end

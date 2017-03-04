// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




@interface AppleScriptUtilities : NSObject {

}

+(void)formatDescriptorType:(char*)buffer withDescriptor:(NSAppleEventDescriptor*)descriptor;

+(double)getDoubleFrom:(NSAppleEventDescriptor*)descriptor;

+(void)dumpDescriptor:(NSAppleEventDescriptor*)descriptor caller:(const char*)caller;

@end

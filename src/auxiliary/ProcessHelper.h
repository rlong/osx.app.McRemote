// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

@interface ProcessHelper : NSObject

+(OSStatus)setFrontProcess:(ProcessSerialNumber*)processSerialNumber;

@end

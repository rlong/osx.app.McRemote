// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "ProcessHelper.h"

@implementation ProcessHelper


// bring the application to the front ...
+(OSStatus)setFrontProcess:(ProcessSerialNumber*)processSerialNumber;
{

    return SetFrontProcess( processSerialNumber );
    
}


@end

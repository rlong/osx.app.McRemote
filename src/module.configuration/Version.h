// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Cocoa/Cocoa.h>


@interface Version : NSObject {
	
	UInt32 _majorVersion;
	//@property (nonatomic, readonly) UInt32 majorVersion;
	//@synthesize majorVersion = _majorVersion;
	
	UInt32 _minorVersion;
	//@property (nonatomic, readonly) UInt32 minorVersion;
	//@synthesize minorVersion = _minorVersion;
	
	UInt32 _microVersion;
	//@property (nonatomic, readonly) UInt32 microVersion;
	//@synthesize microVersion = _microVersion;
	

}


+(Version*)getVersion;

//UInt32 _majorVersion;
@property (nonatomic, readonly) UInt32 majorVersion;
//@synthesize majorVersion = _majorVersion;

//UInt32 _minorVersion;
@property (nonatomic, readonly) UInt32 minorVersion;
//@synthesize minorVersion = _minorVersion;

//UInt32 _microVersion;
@property (nonatomic, readonly) UInt32 microVersion;
//@synthesize microVersion = _microVersion;



@end

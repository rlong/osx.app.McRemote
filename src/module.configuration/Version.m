// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"

#import "Version.h"


@implementation Version



static Version* _instance; 

//+(void)initialize {
//	staticField = @"static-value";
//}




+(Version*)getVersion {
	
	if( nil == _instance ) {
		
		NSString* versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        Log_debugString( versionString );
		
		

		NSScanner* scanner = [[NSScanner alloc] initWithString:versionString];
		
		int majorVersion;
		[scanner scanInt:&majorVersion];
        Log_debugInt( majorVersion );
		
		[scanner scanString:@"." intoString:nil]; // dispose of the '.'

		int minorVersion;
		[scanner scanInt:&minorVersion];
        Log_debugInt( minorVersion );

		[scanner scanString:@"." intoString:nil]; // dispose of the '.'

		int microVersion;
		[scanner scanInt:&microVersion];
        Log_debugInt( microVersion );
		
		_instance = [[Version alloc] init];
		_instance->_majorVersion = majorVersion;
		_instance->_minorVersion = minorVersion;
		_instance->_microVersion = microVersion;
		
	}

	return _instance;
}



-(void)dealloc {
}

#pragma mark fields

//UInt32 _majorVersion;
//@property (nonatomic, readonly) UInt32 majorVersion;
@synthesize majorVersion = _majorVersion;

//UInt32 _minorVersion;
//@property (nonatomic, readonly) UInt32 minorVersion;
@synthesize minorVersion = _minorVersion;

//UInt32 _microVersion;
//@property (nonatomic, readonly) UInt32 microVersion;
@synthesize microVersion = _microVersion;

@end

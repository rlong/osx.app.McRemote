// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




#import <CommonCrypto/CommonDigest.h>

#import "AppleScriptLoader.h"

#import "CABaseException.h"
#import "CALog.h"

@implementation AppleScriptLoader


// vvv copied from RG2_ResourceLoader



static const UInt8 _builtInXor[256] = {
	0x86, 0x04, 0xf6, 0x73, 0xf0, 0x96, 0xef, 0x69, 0x06, 0x44, 0xfd, 0xfb, 0x3a, 0xd9, 0xfd, 0xe0, 
	0x5c, 0xbb, 0xf5, 0x6f, 0x04, 0xcc, 0x6a, 0x55, 0x4c, 0xb8, 0x22, 0x0b, 0xc9, 0xc3, 0x27, 0x4f, 
	0xc7, 0x1e, 0xc2, 0xb7, 0xb4, 0xb1, 0x21, 0xba, 0xf6, 0x1e, 0xb6, 0x30, 0xf7, 0xb3, 0x11, 0x54, 
	0x6e, 0x06, 0xc3, 0x72, 0xd3, 0x2d, 0xc8, 0x1f, 0xe5, 0xea, 0x2a, 0xae, 0xae, 0x52, 0xfd, 0x75, 
	0x70, 0xbf, 0x2d, 0x24, 0x71, 0x4e, 0xde, 0x67, 0x6c, 0x94, 0x97, 0x64, 0x47, 0xa8, 0xb8, 0xb5, 
	0xaf, 0x7b, 0x28, 0x82, 0xa8, 0xf0, 0xa1, 0x8d, 0xda, 0xcb, 0x3c, 0x88, 0x1d, 0x39, 0xfe, 0x8d, 
	0xf9, 0x2b, 0xb1, 0x6a, 0x79, 0x90, 0xd1, 0xe5, 0x24, 0x68, 0x49, 0x6c, 0x11, 0x01, 0x21, 0xc0, 
	0x7c, 0x49, 0x42, 0x24, 0x39, 0xe3, 0xb2, 0x14, 0xae, 0xee, 0x9c, 0xcc, 0x27, 0x9a, 0x59, 0x20, 
	0xc5, 0x0b, 0x8a, 0x3e, 0x9b, 0x5b, 0x24, 0xbf, 0xc4, 0x6d, 0x2b, 0xd5, 0x6f, 0x4d, 0x95, 0xeb, 
	0x96, 0xd7, 0x10, 0xd0, 0xba, 0xc2, 0xe4, 0x68, 0xb0, 0x80, 0x34, 0xd7, 0x1b, 0x8e, 0xf8, 0xe0, 
	0x99, 0x82, 0x1f, 0x34, 0xde, 0x43, 0xf3, 0xa2, 0xb0, 0x1f, 0x77, 0x1f, 0x6c, 0x0c, 0x0b, 0x02, 
	0xe3, 0x1b, 0xd2, 0x9d, 0xdd, 0xb6, 0x05, 0x8d, 0x37, 0x3a, 0x64, 0x52, 0xc8, 0x5c, 0x32, 0x61, 
	0xdf, 0x51, 0x95, 0xbd, 0x94, 0x88, 0x5f, 0x45, 0xa7, 0xd6, 0x64, 0x13, 0xe2, 0x6f, 0x16, 0xc5, 
	0x8a, 0xe8, 0x62, 0x67, 0x9f, 0x67, 0xf4, 0xd6, 0xa1, 0x59, 0x28, 0x69, 0xb5, 0x5a, 0xca, 0x94, 
	0xac, 0x5f, 0x51, 0x40, 0xe8, 0xb0, 0x85, 0x8f, 0x86, 0xea, 0xa3, 0x68, 0x59, 0xb9, 0x2d, 0xe4, 
	0xa1, 0x8f, 0x4b, 0x40, 0xf7, 0x40, 0x16, 0x98, 0x99, 0x3e, 0x02, 0x4e, 0x99, 0xcc, 0xe3, 0x45
};



+(BOOL)validateReadHash:(UInt8[16])readHash withCalculatedHash:(UInt8[16])calculatedHash {
	
	for( int i = 0; i < 16; i++ ) {
		if( readHash[i] != calculatedHash[i] ) {
            Log_warn( @"hash mismatch" );
			//[RG2_Log warn:@"hash mismatch" inFunction:__func__];
			return FALSE;
		}
	}

    Log_debug( @"hash match" );
	//[RG2_Log debug:@"hash match" inFunction:__func__];
	return TRUE;
	
	
}

+(NSString*)extractAdapterContents:(NSData*) adapter {
	
	
	Log_debugInt( [adapter length] );
	//[RG2_Log debugInt:[adapter length] withName:@"[adapter length]" inFunction:__func__];
	
	const UInt8* adapterBytes = [adapter bytes];
	
	UInt8 fileXor[255];
	
	
	
	{ // initial ...
		
		for( int i = 0; i < 255; i++ ) {
			fileXor[i] = *adapterBytes;
			adapterBytes++;
		}
	}
	
    //	for( int i = 0; i < 4; i++ ) { 
    //		[Log debugInt:fileXor[i] withName:@"fileXor[i]" inFunction:__func__];
    //	}
	
	int builtinIndex = 0;
	int fileIndex = 0;
	
	// length ...
	UInt32 adapterLength = 0;
	{  
		
		// MSB 
		UInt8 octet = *adapterBytes;
		adapterBytes++;
		octet = octet ^ _builtInXor[ builtinIndex ] ^ fileXor[ fileIndex ];
		adapterLength |= octet;
		adapterLength <<= 8;
		builtinIndex++;
		fileIndex++;
		
		octet = *adapterBytes;
		adapterBytes++;
		octet = octet ^ _builtInXor[ builtinIndex ] ^ fileXor[ fileIndex ];
		adapterLength |= octet;
		adapterLength <<= 8;
		builtinIndex++;
		fileIndex++;
		
		octet = *adapterBytes;
		adapterBytes++;
		octet = octet ^ _builtInXor[ builtinIndex ] ^ fileXor[ fileIndex ];
		adapterLength |= octet;
		adapterLength <<= 8;
		builtinIndex++;
		fileIndex++;
		
		// LSB
		octet = *adapterBytes;
		adapterBytes++;
		octet = octet ^ _builtInXor[ builtinIndex ] ^ fileXor[ fileIndex ];
		adapterLength |= octet;
		//adapterLength;
		builtinIndex++;
		fileIndex++;
		
	}
    
    Log_debugInt( adapterLength );
	//[RG2_Log debugInt:adapterLength withName:@"adapterLength" inFunction:__func__];
	
	NSMutableData* clearData = [[NSMutableData alloc] initWithCapacity:adapterLength];
	
	for( int i = 0; i < adapterLength; i++ ) {
		
		UInt8 octet = *adapterBytes;
		adapterBytes++;
		
		octet = octet ^ _builtInXor[ builtinIndex ] ^ fileXor[ fileIndex ];
		[clearData appendBytes:&octet length:1];
		
		builtinIndex++;
		if( builtinIndex == 255 ) { 
			builtinIndex = 0;
		}
		fileIndex++;
		if( 254 == fileIndex ) {
			fileIndex = 0;
		}
	}
	
	// hash .. 
	{ 
		
		
		UInt8 readHash[16];
		for( int i = 0; i < 16; i ++ ) {
			readHash[i] = *adapterBytes;
			adapterBytes++;			
		}
		
		UInt8 calculatedHash[16];
		{
			CC_MD5_CTX md5Context;
			
			CC_MD5_Init( &md5Context );
			CC_MD5_Update(&md5Context, (void *)[clearData bytes], (int)[clearData length]);
			
			CC_MD5_Final( calculatedHash, &md5Context);
		}
		
		// contents compromised in some fashion ? 
		if( ![self validateReadHash:readHash withCalculatedHash:calculatedHash] ) {
			return nil;
		}
		
	}
	
	NSString* answer = [[NSString alloc] initWithData:clearData encoding:NSUTF8StringEncoding];
	return answer;
	
}

+(NSString*)loadAdapterResource:(NSString*)resourceName {
    
	/*
	 *
	 * load the data ...  
	 *
	 */
	NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType: @"adapter"];
    Log_debugString( path);
	//[RG2_Log debugString:path withName:@"path" inFunction:__func__];
	
	if( nil == path )  {
		return nil;
	}
	
	NSURL* adapterUrl = [NSURL fileURLWithPath:path];
	NSData* obfuscatedData = [NSData dataWithContentsOfURL:adapterUrl];
	
	// could not find the file ? 
	if( nil == obfuscatedData ) {
		return nil;
	}
	
	NSString* answer = [self extractAdapterContents:obfuscatedData];
	
	if( nil != answer ) {
		NSString* message = [NSString stringWithFormat:@"'%@' loaded", resourceName];
        Log_info( message);
		//[RG2_Log info:message inFunction:__func__];
	}
    
	return answer;
	
	
}



+(NSString*)loadScript:(NSString*)scriptName {
	
	NSString* answer = [self loadAdapterResource:scriptName];
	if( nil != answer ) {
		
		return answer;
	}
	/*
	 *
	 * load the data ...  
	 *
	 */
	NSString *path = [[NSBundle mainBundle] pathForResource:scriptName ofType: @"txt"];
    Log_debugString( path );
    if( nil == path ) { 
        Log_warnFormat( @"nil == path; scriptName = '%@'", scriptName );
    }
	//[RG2_Log debugString:path withName:@"path" inFunction:__func__];
	
	NSURL* scriptUrl = [NSURL fileURLWithPath:path];
	NSError* error = nil;
	answer = [NSString stringWithContentsOfURL:scriptUrl encoding:NSUTF8StringEncoding error:&error];
	
	if( nil != error ) {
        
        CABaseException* e = [[CABaseException alloc] initWithOriginator:[AppleScriptLoader class] line:__LINE__ callTo:@"[NSString stringWithContentsOfURL:encoding:error:]" failedWithError:error];
//		NSString* technicalError = [error localizedDescription];
//		RG2_BaseException* e = [[RG2_BaseException alloc] initWithOriginator:self line:__LINE__ technicalError:technicalError];
		@throw e;
	}
	
	NSString* message = [NSString stringWithFormat:@"'%@' loaded", scriptName];
    Log_info( message );
	//[RG2_Log info:message inFunction:__func__];
	
	return answer;
	
	
}

// ^^^ copied from RG2_ResourceLoader


@end

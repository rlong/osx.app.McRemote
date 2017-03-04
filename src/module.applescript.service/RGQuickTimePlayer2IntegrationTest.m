// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "AppleScriptService.h"

#import "CALog.h"

#import "HLServiceHttpProxy.h"
#import "HLIntegrationTestUtilities.h"
#import "HLMetaProxy.h"

#import "RGQuickTimePlayer2Proxy.h"
#import "RGQuickTimePlayer2IntegrationTest.h"

@implementation RGQuickTimePlayer2IntegrationTest

-(void)test1 {
    
    Log_enteredMethod();
    
}


-(void)test_activate_quicktime_player {

    Log_enteredMethod();

    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"qt-remote.2"];
    [appleScriptService autorelease];
    
    id<HLService> service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    
    RGQuickTimePlayer2Proxy* proxy = [[RGQuickTimePlayer2Proxy alloc] initWithService:service];
    
    [proxy activate_quicktime_player];
    
}

-(void)test_getMetaVersion {
    

    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"qt-remote.2"];
    [appleScriptService autorelease];
    
    
    NSString* serviceName = [[appleScriptService serviceDescription] serviceName];
    Log_debugString( serviceName );
    
    
}

-(void)test_open_url {
    
    
    Log_enteredMethod();
    
    AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"qt-remote.2"];
    [appleScriptService autorelease];
    
    id<HLService> service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    
    RGQuickTimePlayer2Proxy* proxy = [[RGQuickTimePlayer2Proxy alloc] initWithService:service];

    HLJsonObject* mediaInfo = [proxy open_url:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8" media_url_identifier:@"prog_index.m3u8" time_out:5];
    
    NSString* name = [mediaInfo stringForKey:@"_name"];
    STAssertTrue( [@"prog_index.m3u8" isEqualToString:name], @"name = %@", name );
    
    long window_id = [mediaInfo longForKey:@"_window_id"];
    Log_debugLong(window_id);
    
    {
        HLJsonObject* document = [mediaInfo jsonObjectForKey:@"_document"];
        Log_debugLong( [document longForKey:@"_duration"] );
        Log_debugLong( [document longForKey:@"_audio_volume"] );
        Log_debugLong( [document longForKey:@"_current_time"] );
        Log_debugBool( [document boolForKey:@"_presenting"] );
        Log_debugLong( [document longForKey:@"_rate"] );
        Log_debugString( [document stringForKey:@"_file"] );
        Log_debugString( [document stringForKey:@"_name"] );
        
    }
    
}


-(void)testGetMetaInfo {
    
    
    HLIntegrationTestUtilities* integrationTestUtilities = [HLIntegrationTestUtilities getInstance];
    
    if( ![integrationTestUtilities configuredForExternalServer] && ![integrationTestUtilities configuredForInternalServer] ) {
        Log_info(@"configured for colocated tests");
        return;
    }
    
    
    id<HLService> service;
    NSString* serviceName;
    {
        AppleScriptService* appleScriptService = [[AppleScriptService alloc] initWithScriptName:@"qt-remote.2"];
        [appleScriptService autorelease];
        
        serviceName = [[appleScriptService serviceDescription] serviceName];
        Log_debugString( serviceName );
        
        service = [[HLIntegrationTestUtilities getInstance] wrapService:appleScriptService];
    }
    
    
    // we expect service to be a 'HLServiceHttpProxy'
    if( ![service isKindOfClass:[HLServiceHttpProxy class]]) {
                
        Log_warnFormat( @"![service isKindOfClass:[HLServiceHttpProxy class]]; NSStringFromClass([service class]) = '%@'", NSStringFromClass([service class]));
        return;
    }
    
    
    //
    HLMetaProxy* metaProxy = [[HLMetaProxy alloc] initWithService:service];
    NSArray* serviceVersion = [metaProxy getVersion:serviceName];
    STAssertTrue( nil != serviceVersion, @"serviceVersion = %p", serviceVersion );
    STAssertTrue( 2 == [serviceVersion count], @"[serviceVersion count] = %d", [serviceVersion count] );
    
    NSNumber* majorVersion = [serviceVersion objectAtIndex:0];
    STAssertTrue( 1 == [majorVersion intValue], @"[majorVersion intValue] = %d", [majorVersion intValue] );

    NSNumber* minorVersion = [serviceVersion objectAtIndex:1];
    STAssertTrue( 1 == [minorVersion intValue], @"[minorVersion intValue] = %d", [minorVersion intValue] );

    
    
    
    
    
    
    
    
    
    
}


@end

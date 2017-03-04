// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>


#import "HLDescribedService.h"
#import "CAJsonObject.h"

@interface AboutService : NSObject <HLDescribedService> {

    // applicationId
    NSString* _applicationId;
    //@property (nonatomic, retain) NSString* applicationId;
    //@synthesize applicationId = _applicationId;
    
    // realm
    NSString* _realm;
    //@property (nonatomic, retain) NSString* realm;
    //@synthesize realm = _realm;


	// aboutInformation
	CAJsonObject* _aboutInformation;
	//@property (nonatomic, retain) JsonObject* aboutInformation;
	//@synthesize aboutInformation = _aboutInformation;
    
    


    
    
}

+(NSString*)SERVICE_NAME;

+(NSString*)REMOTE_GATEWAY_APPLICATION_ID;

-(CAJsonObject*)getAboutInformation;

#pragma mark instance lifecycle

-(id)initWithApplicationId:(NSString*)applicationId realm:(NSString*)realm;
-(id)initWithRealm:(NSString*)realm;

@end

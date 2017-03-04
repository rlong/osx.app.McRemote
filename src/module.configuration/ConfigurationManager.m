// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"


#import "HLSubject.h"

#import "ConfigurationManager.h"


@implementation ConfigurationManager


#pragma mark RegisteredSubject



+(HLSubject*)dataToRegisteredSubject:(NSDictionary*)registeredSubjectData {
    
    NSString* username = [registeredSubjectData objectForKey:@"username"];
    NSString* password = [registeredSubjectData objectForKey:@"password"];
    NSString* label = [registeredSubjectData objectForKey:@"label"];
    
    HLSubject* answer = [[HLSubject alloc] initWithUsername:username realm:@"" password:password label:label];
    
    return answer;
    
}


+(NSDictionary*)registeredSubjectToData:(HLSubject*)registeredSubject {
	NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
	
	[answer setObject:[registeredSubject username] forKey:@"username"];
	[answer setObject:[registeredSubject password] forKey:@"password"];
	[answer setObject:[registeredSubject label] forKey:@"label"];
	
	return answer;
}


#pragma mark Configuration

+(Configuration*)dataToConfiguration:(NSDictionary*)configurationData {
	Configuration* answer = [[Configuration alloc] init];
	
	if( nil == configurationData ) { // if there is no data to load
        Log_info( @"nil == configurationData" );
		return answer;
	} 
	
	NSString* realm = [configurationData objectForKey:@"realm"];
	[answer setRealm:realm];

	
	NSArray* registeredSubjects = [configurationData objectForKey:@"registered-subjects"];
	if( nil != registeredSubjects ) {
		for( NSDictionary* registeredSubjectData in registeredSubjects ) {
			HLSubject* registeredSubject = [self dataToRegisteredSubject:registeredSubjectData];
			[[answer registeredSubjects] addObject:registeredSubject];
		}
	}

	return answer;
}

+(NSDictionary*)configurationToData:(Configuration*)configuration {
	
	NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
	

	if( nil != [configuration realm] ) {
		[answer setObject:[configuration realm] forKey:@"realm"];
	}
	
	
	NSMutableArray* registeredSubjects = [[NSMutableArray alloc] init]; 
	for( HLSubject* registeredSubject in [configuration registeredSubjects] ) {
		
		NSDictionary* registeredSubjectData = [self registeredSubjectToData:registeredSubject];		
		[registeredSubjects addObject:registeredSubjectData];
	}
	[answer setObject:registeredSubjects forKey:@"registered-subjects"];
	


	return answer;
}

#pragma mark save/load ...


+(NSString*)configurationRootKey {
	
	NSString* answer;
    if( NO ) {
        answer = [NSString stringWithFormat:@"%@.1", NSStringFromClass([Configuration class])];
    } else {
        answer = @"Configuration.1";
    }

    Log_infoString( answer );
	
	return answer;
	
}

+(Configuration*)loadConfiguration {
	
	NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSDictionary* configurationData = [standardUserDefaults dictionaryForKey:[self configurationRootKey]];

	Configuration* answer = [self dataToConfiguration:configurationData];
	return answer;

}

+(void)saveConfiguration:(Configuration*)configuration {
	
	
	NSDictionary* configurationData = [self configurationToData:configuration];
	NSUserDefaults* standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	[standardUserDefaults setObject:configurationData forKey:[self configurationRootKey]];

}



@end

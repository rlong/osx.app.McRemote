// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"


#import "Configuration.h"

#import "NTConfiguration.h"
#import "NTConfigurationSet.h"

@implementation Configuration


static NTConfiguration* _configuration;
static NTConfigurationSet* _configurationSet;

+ (void)initialize {
    
    _configurationSet = [[NTConfigurationSet alloc] init];
    _configuration = [_configurationSet getConfigurationWithName:@"Configuration"];
    
}

-(instancetype)init {

    self = [super init];
    
    if( self ) {
        _registeredSubjects = [[NSMutableArray alloc] init];
        
    }
	
	return self;
}

-(void)dealloc {
	
	[self setRegisteredSubjects:nil];
	
}

#pragma mark -

-(BOOL)foregroundApplication;
{
    return [_configuration boolValueForKey:@"foregroundApplication" withDefaultValue:true];
    
}


-(void)setForegroundApplication:(BOOL)foregroundApplication;
{
    [_configuration setBoolValue:foregroundApplication forKey:@"foregroundApplication"];
    
}


-(BOOL)showPreferencesOnStartup;
{
    return [_configuration boolValueForKey:@"showPreferencesOnStartup" withDefaultValue:true];
    
}

-(void)setShowPreferencesOnStartup:(BOOL)showPreferencesOnStartup;
{
    
    Log_enteredMethod();
    
    [_configuration setBoolValue:showPreferencesOnStartup forKey:@"showPreferencesOnStartup"];
    
}


#pragma mark fields



//NSString* _realm;
//@property (nonatomic, retain) NSString* realm;
@synthesize realm = _realm;


//NSMutableArray* _registeredSubjects;
//@property (nonatomic, retain) NSMutableArray* registeredSubjects;
@synthesize registeredSubjects = _registeredSubjects;



@end


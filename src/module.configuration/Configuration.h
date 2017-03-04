// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



@interface  Configuration : NSObject {

	
	NSString* _realm;
	//@property (nonatomic, retain) NSString* realm;
	//@synthesize realm = _realm;
	
	NSMutableArray* _registeredSubjects;
	//@property (nonatomic, retain) NSMutableArray* registeredSubjects;
	//@synthesize registeredSubjects = _registeredSubjects;
	
}


-(BOOL)foregroundApplication;
-(void)setForegroundApplication:(BOOL)foregroundApplication;

-(BOOL)showPreferencesOnStartup;
-(void)setShowPreferencesOnStartup:(BOOL)showPreferencesOnStartup;


#pragma mark fields

//NSString* _realm;
@property (nonatomic, retain) NSString* realm;
//@synthesize realm = _realm;


//NSMutableArray* _registeredSubjects;
@property (nonatomic, retain) NSMutableArray* registeredSubjects;
//@synthesize registeredSubjects = _registeredSubjects;

//BOOL _showPreferencesOnStartup;
@property (nonatomic) BOOL showPreferencesOnStartup;
//@synthesize showPreferencesOnStartup = _showPreferencesOnStartup;



@end

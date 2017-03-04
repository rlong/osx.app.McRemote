// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CALog.h"

#import "ConfigurationManager.h"
#import "ExecutionContext.h"


@implementation ExecutionContext


static Configuration* _configuration = nil;



+(Configuration*)configuration {
	if( nil == _configuration ) {
		_configuration = [ConfigurationManager loadConfiguration];
	}
	return _configuration;
}



+(void)saveConfiguration {

    Log_enteredMethod();
	
	if( nil == _configuration ) {
        Log_warn( @"nil == _configuration. Nothing to save" );
		return;
	}
	NSMutableArray* registeredSubjects = [_configuration registeredSubjects];
	[registeredSubjects removeAllObjects];
	
//	RG2_HTTPSecurityManager* httpSecurityManager = [self httpSecurityManager];
//	
//	NSEnumerator* subjectEnumerator = [[httpSecurityManager registeredSubjects] subjectEnumerator];
//	for( RG2_Subject* subject in subjectEnumerator) {
//		[registeredSubjects addObject:subject];
//	}
	
	[ConfigurationManager saveConfiguration:_configuration];
	
}



@end

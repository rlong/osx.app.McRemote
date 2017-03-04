// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"


#import "Configuration.h"
#import "ConfigurationManager.h"
#import "ProcessHelper.h"


int main(int argc, char *argv[])
{
	

//	// "handle" SIGPIPE's by ignoring them ... see HTTPRequestWriter for the relevant 'write' calls
//	signal(SIGPIPE,sigPipeHandler); 
//	
    // vvv http://stackoverflow.com/questions/108183/how-to-prevent-sigpipes-or-handle-them-properly
    
    signal(SIGPIPE,SIG_IGN);
    
    // ^^^ http://stackoverflow.com/questions/108183/how-to-prevent-sigpipes-or-handle-them-properly

	
	[[NSThread currentThread] setName:@"main"];
    
    {
        NSString* executable = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
        Log_debugString( executable );
    }


	Configuration* configuration = [ConfigurationManager loadConfiguration];
    
    Log_debugInt( [configuration foregroundApplication] );
	//[RG2_Log debugInt:[configuration foregroundApplication] withName:@"[configuration foregroundApplication]" inFunction:__func__];
	if( [configuration foregroundApplication] ) {
		
		ProcessSerialNumber psn = { 0, kCurrentProcess };
		
		OSStatus status = TransformProcessType(& psn, kProcessTransformToForegroundApplication); 
        Log_debugInt( status );
		//[RG2_Log debugInt:status withName:@"status" inFunction:__func__];	
		
		// bring the application to the front ...
        status = [ProcessHelper setFrontProcess:&psn];
        Log_debugInt( status );
		//[RG2_Log debugInt:status withName:@"status" inFunction:__func__];
		
	}
	
	


    return NSApplicationMain(argc,  (const char **) argv);
}

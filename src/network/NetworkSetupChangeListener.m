// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <SystemConfiguration/SystemConfiguration.h>

#import "CALog.h"

#import "NetworkSetupChangeListener.h"

//
//static void handle_change(SCDynamicStoreRef session, CFArrayRef changes, void * arg) {
//	[Log info:@"network changed detected" inFunction:__func__];
//}

static void dynamicStoreCallBack(SCDynamicStoreRef store, CFArrayRef changedKeys, void *info ) {
	
    Log_info( @"network setup change detected" );
	//[Log info:@"network setup change detected" inFunction:__func__];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:NetworkSetupChangeListener_NetworkSetupChanged_Notification object:[NetworkSetupChangeListener class]];

	
}

@implementation NetworkSetupChangeListener


+(OSStatus)moreSCErrorBoolean:(Boolean)success
{
    OSStatus err;
    int scErr;
	
    err = noErr;
    if ( ! success ) {
        scErr = SCError();
        if (scErr == kSCStatusOK) {
            scErr = kSCStatusFailed;
        }
        // Return an SCF error directly as an OSStatus.
        // That's a little cheesy.  In a real program
        // you might want to do some mapping from SCF
        // errors to a range within the OSStatus range.
        err = scErr;
    }
    return err;
}

+(OSStatus)moreSCError:(const void *)value
{
    return [self moreSCErrorBoolean:(value != NULL)];
}


+(OSStatus)cfqError:(CFTypeRef)cf
// Maps Core Foundation error indications (such as they
// are) to the OSStatus domain.
{
    OSStatus err;
	
    err = noErr;
    if (cf == NULL) {
        err = coreFoundationUnknownErr;
    }
    return err;
}



+(void)cfqRelease:(CFTypeRef)cf
// A version of CFRelease that's tolerant of NULL.
{
    if (cf != NULL) {
        CFRelease(cf);
    }
}


+(void)begin {
	
    Log_enteredMethod();
	
	
	// derived from TN1145
	
	SCDynamicStoreContext context = {0, NULL, NULL, NULL, NULL};
	SCDynamicStoreRef ref = SCDynamicStoreCreate( NULL, CFSTR("AddIPAddressListChangeCallbackSCF"),  dynamicStoreCallBack, &context);
	OSStatus err = [self moreSCError:ref];
	if( err != noErr ) {
		
        Log_error( @"SCDynamicStoreCreate() failed" );
		//[Log error:@"SCDynamicStoreCreate() failed" inFunction:__func__];
        Log_errorInt( err);
		return;
	}
	
	
	CFStringRef pattern = SCDynamicStoreKeyCreateNetworkServiceEntity( NULL, kSCDynamicStoreDomainState, kSCCompAnyRegex, kSCEntNetIPv4);
//	CFStringRef pattern = SCDynamicStoreKeyCreateNetworkServiceEntity( NULL, kSCDynamicStoreDomainState, kSCCompAnyRegex, kSCEntNetInterface);
	err = [self moreSCError:pattern];
	if( err != noErr ) {
		
        Log_error( @"SCDynamicStoreKeyCreateNetworkServiceEntity() failed" );
		//[Log error:@"SCDynamicStoreKeyCreateNetworkServiceEntity() failed" inFunction:__func__];		
        Log_errorInt( err);
		return;
	}
	
	CFArrayRef patternList = CFArrayCreate(NULL, (const void **) &pattern, 1,  &kCFTypeArrayCallBacks);
	err = [self cfqError:patternList];
	if( err != noErr ) {
		
        Log_error( @"CFArrayCreate() failed" );
		//[Log error:@"CFArrayCreate() failed" inFunction:__func__];		
        Log_errorInt( err);
		return;
	}
	
	
	err = [self moreSCErrorBoolean:SCDynamicStoreSetNotificationKeys( ref, NULL, patternList)];
	if( err != noErr ) {
        
        Log_error( @"SCDynamicStoreSetNotificationKeys() failed");
		//[Log error:@"SCDynamicStoreSetNotificationKeys() failed" inFunction:__func__];		
        Log_errorInt( err);
		return;
	}
	
	CFRunLoopSourceRef rls = SCDynamicStoreCreateRunLoopSource( NULL, ref, 0);
	err = [self moreSCError:rls];
	if( err != noErr ) {
		Log_error( @"SCDynamicStoreCreateRunLoopSource() failed" );
		//[Log error:@"SCDynamicStoreCreateRunLoopSource() failed" inFunction:__func__];		
        Log_errorInt( err);
        
		return;
	}
	
	CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
	
	CFRunLoopAddSource( currentRunLoop, rls, kCFRunLoopCommonModes );
	
//	CFRunLoopGetCurrent
//	
	
    Log_debug( @"leaving" );
	
//	[self cfqRelease:ref];
//	[self cfqRelease:pattern];
//	[self cfqRelease:patternList];
	
	
	
}

@end


NSString *const NetworkSetupChangeListener_NetworkSetupChanged_Notification = @"NetworkSetupChangeListener_NetworkSetupChanged_Notification";




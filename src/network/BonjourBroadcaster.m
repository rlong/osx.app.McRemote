// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#include <sys/socket.h>
#include <net/if.h>

#import "CALog.h"

#import "BonjourBroadcaster.h"


@implementation BonjourBroadcaster




-(void)beginBroadcast {
	
	//struct if_nameindex* interfaces = 
	struct if_nameindex* interface = if_nameindex();
	do {
        Log_debugUtf8String( interface->if_name );
        
		DNSServiceFlags flags = kDNSServiceFlagsDefault;
		uint32_t interfaceIndex = interface->if_index;
		const char *name = NULL; /* may be NULL */
		const char *regtype = "_mc-remote._tcp";
		const char *domain = NULL; /* may be NULL */
		const char *host = NULL; /* may be NULL */
		uint16_t port = 8081;
		uint16_t txtLen = 0; // Must be zero if the txtRecord is NULL
		const void *txtRecord = NULL; /* may be NULL */
		DNSServiceRegisterReply callBack = NULL; /* may be NULL */
		void *context = NULL; /* may be NULL */
		
		// 
		// DNSServiceRef _dnsServiceRef
		int err = DNSServiceRegister( &_dnsServiceRef, 
									 flags,
									 interfaceIndex,
									 name, 
									 regtype,
									 domain,
									 host,
									 htons(port),
									 txtLen,
									 txtRecord,
									 callBack,
									 context );
		
		if( kDNSServiceErr_NoError != err ) {
			NSString* message = [NSString stringWithFormat:@"err = %d, for '%s'", err, interface->if_name];
            Log_warn( message );
		}
		interface++;
	} while( 0 != interface->if_index );
	
}

-(void)endBroadcast {
	
}


-(id)init {
	BonjourBroadcaster* answer = [super init];
	
	
	return answer;
}

-(void)dealloc {
	
	[self endBroadcast];
	
}



@end

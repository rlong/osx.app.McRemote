// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


/*
#include <sys/types.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <net/if.h>
*/

#import <dns_sd.h>

@interface BonjourBroadcaster : NSObject {

	DNSServiceRef _dnsServiceRef;
}


-(void)beginBroadcast;
-(void)endBroadcast;



@end

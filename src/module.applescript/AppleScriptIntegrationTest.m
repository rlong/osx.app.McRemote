// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "AppleScriptIntegrationTest.h"

#import "CABaseException.h"


@implementation AppleScriptIntegrationTest

-(void)testPing {
	
//	XRMessage* call = [[XRMessage alloc] init];
//	[call setMethodName:@"ping"];
//	
//	
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithScriptName:@"AppleScriptIntegrationTest"];
//	
//	[script execute:call];
//	
////	AppleScriptMethodCall* call = [[AppleScriptMethodCall alloc] init];
////	[call dispatch];
}


-(void)testPingSource {
	
//	
////	NSString* source = @"on ping()\ndisplay dialog \"ping\"\nend ping";
//	NSString* source = @"on ping()\n\nend ping";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	XRMessage* call = [[XRMessage alloc] init];
//	[call setMethodName:@"ping"];
//
//	[script execute:call];
	
}


-(void)testEchoArray {
//	/*
//	 on echo(input)
//	 set answer to input
//	 return answer
//	 end echo
//	 
//	 echo({12, "Egypt"})	 
//	 */
//	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadArrayCall];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateArrayCall:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateArrayResponse:response];
	
	
}

-(void)testEchoBoolean1 {
	
}

-(void)testEchoInteger {
//	/*
//	 on echo(input)
//	 set answer to input
//	 return answer
//	 end echo
//	 
//	 echo(10)	 
//	 */
//	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadIntegerCall];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateIntegerCall:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateIntegerResponse:response];
	
}

-(void)testEchoDouble {
//	/*
//	 on echo(input)
//	 set answer to input
//	 return answer
//	 end echo
//	 
//	 echo(10)	 
//	 */
////	NSString* source = @"on echo(input)\n set answer to date \"Tuesday, 1 Jan 2010 00:01:00\"\n return answer\n end echo";
////	NSString* source = @"on echo(input)\n set answer to true\n return answer\n end echo";
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadDoubleCall];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateDoubleCall:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateDoubleResponse:response];
	
}


-(void)testEchoString1 {
	
//	/*
//	 on echo(input)
//	 set answer to input
//	 return answer
//	 end echo
//	 
//	 echo("echo-string")	 
//	 */
//	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadString1Call];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateString1Call:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateString1Response:response];
	
}


-(void)testEchoString2 {
	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadString2Call];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateString2Call:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateString2Response:response];
	
}

-(void)testEchoString3 {
	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadString3Call];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateString3Call:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateString3Response:response];
//	
}

// error originates from the code ... 
-(void)testError1 {

//	NSString* source = @"on test_error_1()\n 1 + \"A\"\n end test_error_1";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadTestError1];
//
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	
//	@try {
//		[script execute:call];
//		STFail( @"exception should have been thrown" ); 
//	}
//	@catch (BaseException * e) {
//		[self validateTestError1Response:e];
//	}

}


// error raised by the code ... 
-(void)testError2 {
	
//	NSString* source = @"on test_error_2()\n error number 9000\n end test_error_2";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadTestError2];
//	
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	
//	@try {
//		[script execute:call];
//		STFail( @"exception should have been thrown" ); 
//	}
//	@catch (BaseException * e) {
//		[self validateTestError2Response:e];
//	}
	
}



-(void)testStruct1 {
	/*
	 on echo(input)
	 set answer to input
	 return answer
	 end echo
	 
	 echo({integer_field:18, upperBound:139})
	 */
	
//	NSString* source = @"on echo(input)\n set answer to input\n return answer\n end echo";
//	RG2_AppleScript* script = [[RG2_AppleScript alloc] initWithSource:source];
//	
//	NSData* callData = [self loadStruct1Call];
//	XRMessage* call = [XRInboundMethodCallTransformer transform:callData];
//	[self validateStruct1Call:call];
//	
//	XRMessage* response = [script execute:call];
//	[self validateStruct1Response:response];

	
}



@end

// Copyright (c) 2017 Richard Long
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "Configuration.h"


@interface ConfigurationManager : NSObject {

}


+(Configuration*)loadConfiguration;

+(void)saveConfiguration:(Configuration*)configuration;

@end

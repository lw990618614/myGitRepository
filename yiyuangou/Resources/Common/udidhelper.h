//
//  udidhelper.h
//  bravologger1
//
//  Created by banxian on 6/14/13.
//
//

#ifndef bravologger1_udidhelper_h
#define bravologger1_udidhelper_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

NSString * getMacAddress(const char* interfacename);
NSString * getIMEI();
NSString * getSerialnumber();
NSString * getBacklightlevel();

#ifdef __cplusplus
}
#endif
    
#endif

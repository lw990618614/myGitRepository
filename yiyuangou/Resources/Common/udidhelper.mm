//
//  udidhelper.mm
//  bravologger1
//
//  Created by banxian on 6/14/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFDictionary.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include "udidhelper.h"

#include <sys/types.h>
#import <mach/mach_host.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <ifaddrs.h>


#pragma mark IOKit miniheaders

#define kIODeviceTreePlane "IODeviceTree"

enum {
    kIORegistryIterateRecursively	= 0x00000001,
    kIORegistryIterateParents	= 0x00000002
};

typedef mach_port_t	io_object_t;
typedef io_object_t	io_registry_entry_t;
typedef char	io_name_t[128];
typedef UInt32	IOOptionBits;

extern "C" CFTypeRef
IORegistryEntrySearchCFProperty(
                                io_registry_entry_t	entry,
                                const io_name_t	plane,
                                CFStringRef	key,
                                CFAllocatorRef	allocator,
                                IOOptionBits	options );

extern "C" kern_return_t
IOMasterPort( mach_port_t	bootstrapPort,
             mach_port_t *	masterPort );

extern "C" io_registry_entry_t
IORegistryGetRootEntry(
                       mach_port_t	masterPort );

extern "C" CFTypeRef
IORegistryEntrySearchCFProperty(
                                io_registry_entry_t	entry,
                                const io_name_t	plane,
                                CFStringRef	key,
                                CFAllocatorRef	allocator,
                                IOOptionBits	options );

extern "C" kern_return_t mach_port_deallocate
(ipc_space_t task,
 mach_port_name_t name);

NSString * getMacAddress(const char* interfacename)
{
#if TARGET_IPHONE_SIMULATOR
    return @"simulator";
#else

    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    NSString *errorFlag = NULL;
    size_t length;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex(interfacename)) == 0)
        errorFlag = @"if_nametoindex failure";
        // Get the size of the data available (store in len)
        else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
            // Alloc memory based on above call
            else if ((msgBuffer = (char*)malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
                // Get system information, store in buffer
                else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                {
                    free(msgBuffer);
                    errorFlag = @"sysctl msgBuffer failure";
                }
                else
                {
                    // Map msgbuffer to interface message structure
                    struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
                    
                    // Map to link-level socket structure
                    struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
                    
                    // Copy link layer address data in socket structure to an array
                    unsigned char macAddress[6];
                    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
                    
                    // Read from char array into a string object, into traditional Mac address format
                    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                                  macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
//                    NSLog(@"Mac Address: %@", macAddressString);
                    
                    // Release the buffer memory
                    free(msgBuffer);
                    
                    return macAddressString;
                }
    
    // Error...
    NSLog(@"Error: %@", errorFlag);
    
    return errorFlag;
#endif
}

NSArray *getValue(NSString *iosearch);

NSArray *getValue(NSString *iosearch)
{
#if TARGET_IPHONE_SIMULATOR
    return nil;
#else

    
    mach_port_t masterPort;
    CFTypeID propID = (CFTypeID) NULL;
    unsigned int bufSize;
    
    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
    if (kr != noErr) return nil;
    
    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
    if (entry == MACH_PORT_NULL) return nil;
    
    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry, kIODeviceTreePlane, (__bridge CFStringRef) iosearch, nil, kIORegistryIterateRecursively);
    if (!prop) return nil;
    
    propID = CFGetTypeID(prop);
    if (!(propID == CFDataGetTypeID()))
    {
        mach_port_deallocate(mach_task_self(), masterPort);
        return nil;
    }
    
    CFDataRef propData = (CFDataRef) prop;
    if (!propData) return nil;
    
    bufSize = CFDataGetLength(propData);
    if (!bufSize) return nil;
    
    NSString *p1 = [[NSString alloc] initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:1]; // autorelease
    mach_port_deallocate(mach_task_self(), masterPort);
    return [p1 componentsSeparatedByString:@"\0"];
#endif
}

NSString * getIMEI()
{
#if TARGET_IPHONE_SIMULATOR
    return @"simulator";
#else

//    NSArray *results = getValue(@"device-imei");
//    if (results) return [results objectAtIndex:0];
    return nil;
#endif
}

NSString * getSerialnumber()
{
#if TARGET_IPHONE_SIMULATOR
    return @"simulator";
#else
//    NSArray *results = getValue(@"serial-number");
//    if (results) return [results objectAtIndex:0];
    return nil;
#endif
}

NSString * getBacklightlevel()
{
#if TARGET_IPHONE_SIMULATOR
    return @"simulator";
#else
//    NSArray *results = getValue(@"backlight-level");
//    if (results) return [results objectAtIndex:0];
    return nil;
#endif
}

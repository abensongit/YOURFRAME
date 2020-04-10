

#import <Foundation/Foundation.h>


/*
 Useful system methods.
*/
@interface NSObject (System)

/*
 Returns the URL to the application's Documents directory.
 
 @returns The documents directory URL.
*/
+ (NSURL *)applicationDocumentsDirectory;

/* Returns the device model name.

 @returns The device name.
*/
+ (NSString *)deviceModel;

/* 
 Returns the device complete name (ie: iPod Touch 4G).
 TODO: This method must be kept updated for new device incoming device models.

 @returns The device name.
*/
+ (NSString *)deviceName;

/* Returns the OS version name and number.

 @returns The OS version.
*/
+ (NSString *)OSVersion;

/*

*/
+ (BOOL)isOSMinimumRequired:(NSString *)minimum;

/*
 Returns the device density value.

 @retuns The device density value.
*/
+ (float)density;

/*
 Returns the bundle name.

 @returns The bundle name.
*/
+ (NSString *)bundleName;

/*
 Returns the app display name.

 @returns The app name.
*/
+ (NSString *)appName;

/*
 Returns the app version number.

 @returns The app version.
*/
+ (NSString *)appVersion;

/*
 Returns the build version number.

 @returns The build version.
*/
+ (NSString *)buildVersion;

/* 
 Checks if the device is jailbroken or not.

 @returns  Yes if the device is jailbroken.
*/
+ (BOOL)isJailbroken;

@end

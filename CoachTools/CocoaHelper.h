//
//  CocoaHelper.h
//

#import <UIKit/UIKit.h>

@interface CocoaHelper : NSObject
{
}

+(void) showUIViewController:(UIViewController *)controller;
+(void) hideUIViewController;
//-(BOOL) isViewControllerInUse:(UIViewController *)controller;
+(BOOL) isViewControllerInUse;
@end

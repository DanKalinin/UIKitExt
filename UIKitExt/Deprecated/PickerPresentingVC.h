//
//  PickerPresentingVC.h
//  Controls
//
//  Created by Dan Kalinin on 11/9/17.
//

#import <UIKit/UIKit.h>
#import <Helpers/Helpers.h>
#import <ContactsUI/ContactsUI.h>
#import <UserNotifications/UserNotifications.h>
#import "View.h"

typedef NS_ENUM(NSInteger, PickerTag) {
    PickerTagContacts = 1,
    PickerTagUserNotifications = 2
};



@interface PickerPresentingVC : ViewController

@property CNContactStore *contactStore;
@property CNEntityType contactEntityType;

@property UNUserNotificationCenter *userNotificationCenter;
@property UNAuthorizationOptions userNotificationAuthorizationOptions;

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion;

@end

//
//  PickerPresentingVC.m
//  Controls
//
//  Created by Dan Kalinin on 11/9/17.
//

#import "PickerPresentingVC.h"

typedef NS_ENUM(NSInteger, PickerActionTag) {
    PickerActionTagNone,
    PickerActionTagSettings
};



@interface PickerPresentingVC ()

@property NSOperationQueue *mainQueue;

@end



@implementation PickerPresentingVC

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.mainQueue = NSOperationQueue.mainQueue;
        
        self.contactStore = CNContactStore.new;
        self.contactEntityType = CNEntityTypeContacts;
        
        self.userNotificationCenter = UNUserNotificationCenter.currentNotificationCenter;
        self.userNotificationAuthorizationOptions = (UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
    }
    return self;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion {
    if (viewController.view.tag == PickerTagContacts) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:self.contactEntityType];
        [self.contactStore requestAccessForEntityType:self.contactEntityType completionHandler:^(BOOL granted, NSError *error) {
            [self.mainQueue addOperationWithBlock:^{
                if (granted) {
                    [super presentViewController:viewController animated:animated completion:completion];
                } else if (status != CNAuthorizationStatusNotDetermined) {
                    UIAlertController *ac = [self alertControllerSettings];
                    ac.title = [self localize:@"Contacts access denied"];
                    ac.message = [self localize:@"You can allow access to contacts in Settings"];
                    [super presentViewController:ac animated:animated completion:completion];
                }
            }];
        }];
    } else if (viewController.view.tag == PickerTagUserNotifications) {
        [self.userNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
            [self.userNotificationCenter requestAuthorizationWithOptions:self.userNotificationAuthorizationOptions completionHandler:^(BOOL granted, NSError *error) {
                [self.mainQueue addOperationWithBlock:^{
                    if (granted) {
                        [super presentViewController:viewController animated:animated completion:completion];
                    } else if (settings.authorizationStatus != UNAuthorizationStatusNotDetermined) {
                        UIAlertController *ac = [self alertControllerSettings];
                        ac.title = [self localize:@"Notifications disabled"];
                        ac.message = [self localize:@"You can enable notifications in Settings"];
                        [super presentViewController:ac animated:animated completion:completion];
                    }
                }];
            }];
        }];
    } else {
        [super presentViewController:viewController animated:animated completion:completion];
    }
}

#pragma mark - Actions

- (void)didHandleAction:(id<Action>)action NS_EXTENSION_UNAVAILABLE("") {
    if (action.tag == PickerActionTagSettings) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - Helpers

- (UIAlertController *)alertControllerSettings {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:[self localize:@"Access denied"] message:[self localize:@"You can allow access in Settings"] preferredStyle:UIAlertControllerStyleAlert];
    
    AlertAction *settingsAction = [AlertAction actionWithTitle:[self localize:@"Settings"] style:UIAlertActionStyleDefault delegate:self tag:PickerActionTagSettings];
    AlertAction *cancelAction = [AlertAction actionWithTitle:[self localize:@"Cancel"] style:UIAlertActionStyleCancel delegate:self tag:PickerActionTagNone];
    
    [ac addAction:settingsAction];
    [ac addAction:cancelAction];
    
    return ac;
}

@end

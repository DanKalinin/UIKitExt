//
//  MultiselectionControl.h
//  Pods
//
//  Created by Dan Kalinin on 03.03.17.
//
//

#import <UIKit/UIKit.h>



@interface MultiselectionControl : UIControl

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property IBInspectable NSString *itemKeyPath;
@property IBInspectable NSUInteger minimumSelectedButtonCount;

@property (readonly) NSArray *selectedItems;
- (void)selectItems:(NSArray *)items animated:(BOOL)animated;

@end

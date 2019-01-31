//
//  UIEObject.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/31/19.
//

#import "UIEMain.h"

@class UIEObject;










@interface NSObject (UIE)

@property (readonly) Class uieOperationClass;
@property (readonly) NSEObjectOperation *uieOperation;

@end










@interface UIEObject : NSObject

@end

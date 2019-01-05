//
//  DraggableButton.h
//  Controls
//
//  Created by Dan Kalinin on 12/16/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"



@interface DraggableButton : Button

@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIView *sourceView;
@property (weak, nonatomic) IBOutlet UIView *targetView;

@property (nonatomic) IBInspectable UIRectEdge edge;
@property (nonatomic) IBInspectable CGFloat inset;
@property (nonatomic) IBInspectable UIEdgeInsets insets;

@property (readonly) NSArray *intersectedButtons;
- (BOOL)intersectsButton:(DraggableButton *)button;

- (void)returnAnimated:(BOOL)animated;

@end

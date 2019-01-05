//
//  SectorControl.h
//  SectorControl
//
//  Created by Dan Kalinin on 1/31/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"



@interface SectorControl : UIControl

@property (strong, nonatomic) IBOutletCollection(Button) NSArray *sectors;

@property (weak, nonatomic) IBOutlet Button *initialSector;

@property IBInspectable CGFloat sectorWidth;
@property IBInspectable CGFloat borderWidth;
@property IBInspectable CGFloat startAngle;
@property IBInspectable CGFloat disabledAlpha;
@property IBInspectable BOOL deselactable;

@property (readonly) Button *sector;
- (void)selectSector:(Button *)sector animated:(BOOL)animated;

@end

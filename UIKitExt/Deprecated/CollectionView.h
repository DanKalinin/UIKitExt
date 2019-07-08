//
//  CollectionView.h
//  Framework
//
//  Created by Dan Kalinin on 10.03.17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"

@class CollectionView;

typedef NS_ENUM(NSUInteger, CollectionViewItemReorderingPolicy) {
    CollectionViewItemReorderingPolicyNone,
    CollectionViewItemReorderingPolicyInSection
};










@protocol CollectionViewDataSource <UICollectionViewDataSource>

@optional

@end










@protocol CollectionViewDelegate <UICollectionViewDelegate>

@optional
- (void)collectionView:(CollectionView *)collectionView didLongPressItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(CollectionView *)collectionView didBeginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(CollectionView *)collectionView didUpdateInteractiveMovementTargetPosition:(CGPoint)targetPosition;
- (void)collectionViewDidEndInteractiveMovement:(CollectionView *)collectionView;
- (void)collectionViewDidCancelInteractiveMovement:(CollectionView *)collectionView;

@end










@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet ImageView *imageView1;
@property (weak, nonatomic) IBOutlet ImageView *imageView2;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *viewColor;

@property (weak, nonatomic) IBOutlet ShapeLayerView *shapeLayerView1;

@property (weak, nonatomic) IBOutlet UIStackView *stackView1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;

@property (weak, nonatomic) IBOutlet Button *button1;
@property (weak, nonatomic) IBOutlet Button *buttonDelete;

@property (weak, nonatomic) IBOutlet UITextField *textField1;

@property (weak, nonatomic) IBOutlet UIControl *control1;

@property IBInspectable UIColor *defaultColor;
@property IBInspectable UIColor *selectedColor;
@property IBInspectable UIColor *highlightedColor;

@property IBInspectable BOOL shakeOnEditing;

@property (readonly) BOOL editing;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end










@interface CollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *label1;

@end










@interface CollectionView : UICollectionView

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *emptyView;

@property IBInspectable BOOL canMoveItems;
@property IBInspectable BOOL canMoveSingleItem;
@property IBInspectable BOOL reorderOnEditing; // Enables @ pgrReorder on editing
@property IBInspectable CollectionViewItemReorderingPolicy itemReorderingPolicy;

@property (readonly) UILongPressGestureRecognizer *lpgr; // Enable to support long press. - collectionView:didLongPressItemAtIndexPath: will be called.
@property (readonly) UIPanGestureRecognizer *pgrReorder; // Enable to support custom reordering. Do not enable if @ reorderOnEditing = YES.
@property (readonly) BOOL editing;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end










@interface CollectionViewController : UICollectionViewController <CollectionViewDataSource, CollectionViewDelegate>

@property (nonatomic) CollectionView *view;
@property (nonatomic) CollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet Button *button1;

@end

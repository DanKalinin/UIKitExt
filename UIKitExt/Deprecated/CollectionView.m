//
//  CollectionView.m
//  Framework
//
//  Created by Dan Kalinin on 10.03.17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import "CollectionView.h"
#import <FoundationExt/FoundationExt.h>










@interface CollectionViewCell ()

@property BOOL editing;
@property CABasicAnimation *shakeAnimation;

@end



@implementation CollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CGFloat angle = M_PI_4 / 20.0;
        
        self.shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        self.shakeAnimation.fromValue = @(-angle);
        self.shakeAnimation.toValue = @(angle);
        self.shakeAnimation.duration = 0.1;
        self.shakeAnimation.autoreverses = YES;
        self.shakeAnimation.repeatCount = FLT_MAX;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.buttonDelete.hidden = YES;
}

#pragma mark - Accessors

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateState];
    
    self.button1.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateState];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    self.editing = editing;
    
    self.buttonDelete.hidden = !editing;
    
    if (self.shakeOnEditing) {
        if (editing) {
            [self.layer addAnimation:self.shakeAnimation forKey:self.shakeAnimation.keyPath];
        } else {
            [self.layer removeAnimationForKey:self.shakeAnimation.keyPath];
        }
    }
}

#pragma mark - Helpers

- (void)updateState {
    if (self.selected) {
        self.viewColor.backgroundColor = self.selectedColor;
    } else if (self.highlighted) {
        self.viewColor.backgroundColor = self.highlightedColor;
    } else {
        self.viewColor.backgroundColor = self.defaultColor;
    }
}

@end










@interface CollectionReusableView ()

@end



@implementation CollectionReusableView

@end










@interface CollectionView () <CollectionViewDataSource, CollectionViewDelegate>

@property SurrogateArray<CollectionViewDataSource> *originalDataSource;
@property SurrogateArray<CollectionViewDelegate> *originalDelegate;

@property SurrogateArray<CollectionViewDataSource> *dataSources;
@property SurrogateArray<CollectionViewDelegate> *delegates;

@property UILongPressGestureRecognizer *lpgr;
@property UIPanGestureRecognizer *pgrReorder;
@property BOOL editing;
@property BOOL movementBegan;

@end



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation CollectionView

@dynamic backgroundView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        super.dataSource = self;
        super.delegate = self;
        
        self.canMoveSingleItem = YES;
        
        self.lpgr = [UILongPressGestureRecognizer.alloc initWithTarget:self action:@selector(onLongPress:)];
        self.lpgr.enabled = NO;
        [self addGestureRecognizer:self.lpgr];
        
        self.pgrReorder = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
        self.pgrReorder.enabled = NO;
        [self addGestureRecognizer:self.pgrReorder];
    }
    return self;
}

#pragma mark - Accessors

- (void)setDataSource:(id<CollectionViewDataSource>)dataSource {
    if (dataSource) {
        self.originalDataSource = (id)SurrogateArray.new;
        [self.originalDataSource addObject:dataSource];
        
        self.dataSources = (id)SurrogateArray.new;
        [self.dataSources addObject:dataSource];
        [self.dataSources addObject:self];
        [super setDataSource:self.dataSources];
    } else {
        [super setDataSource:self];
    }
}

- (void)setDelegate:(id<CollectionViewDelegate>)delegate {
    if (delegate) {
        self.originalDelegate = (id)SurrogateArray.new;
        [self.originalDelegate addObject:delegate];
        
        self.delegates = (id)SurrogateArray.new;
        [self.delegates addObject:delegate];
        [self.delegates addObject:self];
        [super setDelegate:self.delegates];
    } else {
        // TODO: Workaround
        // [super setDelegate:self];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    self.editing = editing;
    
    for (CollectionViewCell *cell in self.visibleCells) {
        [cell setEditing:editing animated:animated];
    }
    
    if (self.reorderOnEditing) {
        self.pgrReorder.enabled = editing;
    }
}

#pragma mark - Actions

- (void)onLongPress:(UILongPressGestureRecognizer *)lpgr {
    if (lpgr.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [lpgr locationInView:self];
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:location];
        if (indexPath) {
            [self.originalDelegate collectionView:self didLongPressItemAtIndexPath:indexPath];
        }
    }
}

- (void)onPan:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        self.movementBegan = NO;
        CGPoint location = [pgr locationInView:self];
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:location];
        if (indexPath) {
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
            [self.originalDelegate collectionView:self didBeginInteractiveMovementForItemAtIndexPath:indexPath];
            self.movementBegan = YES;
        }
    } else if (pgr.state == UIGestureRecognizerStateChanged) {
        if (self.movementBegan) {
            CGPoint location = [pgr locationInView:self];
            [self updateInteractiveMovementTargetPosition:location];
            [self.originalDelegate collectionView:self didUpdateInteractiveMovementTargetPosition:location];
        }
    } else if (pgr.state == UIGestureRecognizerStateEnded) {
        if (self.movementBegan) {
            [self endInteractiveMovement];
            [self.originalDelegate collectionViewDidEndInteractiveMovement:self];
        }
    } else if (pgr.state == UIGestureRecognizerStateCancelled) {
        if (self.movementBegan) {
            [self cancelInteractiveMovement];
            [self.originalDelegate collectionViewDidCancelInteractiveMovement:self];
        }
    }
}

#pragma mark - Collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger sections = [self.dataSources.lastReturnValue integerValue];
    if (self.emptyView) {
        BOOL show = (sections == 0);
        if (sections == 1) {
            NSInteger rows = [self.dataSources collectionView:self numberOfItemsInSection:0];
            show = (rows == 0);
        }
        self.backgroundView = show ? self.emptyView : nil;
    }
    return sections;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(CollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell setEditing:self.editing animated:NO];
}

// Reordering

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canMove = NO;
    if (self.canMoveItems) {
        if (self.canMoveSingleItem) {
            canMove = YES;
        } else {
            NSInteger itemsInSection = [self numberOfItemsInSection:indexPath.section];
            canMove = (itemsInSection > 1);
        }
    }
    return canMove;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
    NSIndexPath *ip;
    if (self.itemReorderingPolicy == CollectionViewItemReorderingPolicyNone) {
        ip = proposedIndexPath;
    } else if (self.itemReorderingPolicy == CollectionViewItemReorderingPolicyInSection) {
        if (proposedIndexPath.section > originalIndexPath.section) {
            NSInteger itemsInSection = [self numberOfItemsInSection:originalIndexPath.section];
            ip = [NSIndexPath indexPathForItem:(itemsInSection - 1) inSection:originalIndexPath.section];
        } else if (proposedIndexPath.section < originalIndexPath.section) {
            ip = [NSIndexPath indexPathForItem:0 inSection:originalIndexPath.section];
        } else {
            ip = proposedIndexPath;
        }
    }
    return ip;
}

@end

#pragma clang diagnostic pop










@interface CollectionViewController ()

@end



@implementation CollectionViewController

@dynamic view;
@dynamic collectionView;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.collectionView setEditing:editing animated:animated];
}

@end

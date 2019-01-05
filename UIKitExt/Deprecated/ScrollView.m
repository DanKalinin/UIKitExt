//
//  ScrollView.m
//  Framework
//
//  Created by Dan Kalinin on 8/22/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import "ScrollView.h"










@interface ScrollView () <ScrollViewDelegate>

@property SurrogateArray<ScrollViewDelegate> *delegates;

@end



@implementation ScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegates = (id)SurrogateArray.new;
        [self.delegates addObject:self];
        self.delegate = self.delegates;
    }
    return self;
}

#pragma mark - Scroll view

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    UIFloatRange xRange = UIFloatRangeZero;
    xRange.maximum = self.contentSize.width - self.bounds.size.width;
    
    UIFloatRange yRange = UIFloatRangeZero;
    yRange.maximum = self.contentSize.height - self.bounds.size.height;
    
    contentOffset.x = CGFloatClampToRange(contentOffset.x, xRange);
    contentOffset.y = CGFloatClampToRange(contentOffset.y, yRange);
    
    [super setContentOffset:contentOffset animated:animated];
}

- (void)scrollViewDidEndDragging:(ScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
    } else {
        [self.delegates scrollViewDidEndScrolling:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(ScrollView *)scrollView {
    [self.delegates scrollViewDidEndScrolling:scrollView];
}

- (void)scrollViewDidEndScrolling:(ScrollView *)scrollView {
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)note {
    BOOL local = [note.userInfo[UIKeyboardIsLocalUserInfoKey] boolValue];
    if (local) {
        CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
        
        (void)duration;
        (void)curve;
        
        self.contentInset = self.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, frame.size.height, 0.0);
        
        CGRect bottomViewFrame = UIEdgeInsetsOutsetRect(self.bottomView.frame, self.bottomView.layoutMargins);
        [self scrollRectToVisible:bottomViewFrame animated:NO];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)note {
    self.contentInset = self.scrollIndicatorInsets = UIEdgeInsetsZero;
}

@end










@interface ScrollViewController ()

@end



@implementation ScrollViewController

@dynamic view;

@end

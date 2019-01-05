//
//  GraphView.h
//  Pods
//
//  Created by Dan Kalinin on 8/15/17.
//
//

#import <UIKit/UIKit.h>
#import "View.h"

@class GraphView;

typedef NS_ENUM(NSUInteger, GraphViewType) {
    GraphViewTypeLine,
    GraphViewTypeColumn
};










@protocol GraphViewDataSource <NSObject>

- (NSInteger)numberOfDimensionsInGraphView:(GraphView *)graphView;
- (NSInteger)graphView:(GraphView *)graphView numberOfPointsInDimension:(NSInteger)dimension;
- (CGPoint)graphView:(GraphView *)graphView pointAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)graphView:(GraphView *)graphView graphColorForDimension:(NSInteger)dimension;
- (UIColor *)graphView:(GraphView *)graphView averageColorForDimension:(NSInteger)dimension;

@end










@interface GraphView : GradientLayerView2

@property (weak, nonatomic) IBOutlet UILabel *headerLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLeftDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *headerRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerRightDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *yMinimumLabel;
@property (weak, nonatomic) IBOutlet UILabel *yMaximumLabel;

@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray<UILabel *> *xLabels;

@property IBInspectable GraphViewType type;

@property IBInspectable UIColor *axisColor;

@property UIFloatRange xRange;
@property UIFloatRange yRange;

@property (weak) id <GraphViewDataSource> dataSource;

@end










@interface GraphViewController : UIViewController <GraphViewDataSource>

@property (nonatomic) GraphView *view;

@end

//
//  View.h
//  Controls
//
//  Created by Dan Kalinin on 11/16/17.
//

#import <UIKit/UIKit.h>
#import <FoundationExt/FoundationExt.h>

@class TextFields, TimerControl, CircleView, HandleView, ScrollView;
@class View, ImageView, TextField, TextView, Button, KeyboardContainerView, ShapeLayerView, GradientLayerView, GradientLayerView2, EmitterLayerView;

extern const UIModalPresentationStyle UIModalPresentationPush;










@interface View : UIView // Customized view

@property (weak, nonatomic) IBOutlet View *view1;

@property (weak, nonatomic) IBOutlet ImageView *imageView1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView1;

@property (weak, nonatomic) IBOutlet CircleView *circleView1;

@end










@interface Label : UILabel

@property IBInspectable UIColor *defaultBackgroundColor;
@property IBInspectable UIColor *highlightedBackgroundColor;

@end










@interface ImageView : UIImageView // Customized image view

@property IBInspectable UIColor *defaultBackgroundColor;
@property IBInspectable UIColor *highlightedBackgroundColor;

@end










@interface TextView : UITextView

@end










@interface TextField : UITextField // Customized text field

@property IBInspectable BOOL clearOnBegin;
@property IBInspectable NSString *pattern;
@property IBInspectable CGFloat disabledAlpha;

@property (readonly) BOOL valid;

@end










@interface Button : UIButton // Customized button

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *subbuttons; // Subbuttons changing their state together with receiver

@property (weak, nonatomic) IBOutlet Button *button1; // Convenience outlet connections
@property (weak, nonatomic) IBOutlet Button *button2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet ImageView *imageView1;
@property (weak, nonatomic) IBOutlet ImageView *imageView2;
@property (weak, nonatomic) IBOutlet ShapeLayerView *shapeLayerView;

@property IBInspectable UIColor *defaultBackgroundColor; // Background color for different states
@property IBInspectable UIColor *highlightedBackgroundColor;
@property IBInspectable UIColor *selectedBackgroundColor;
@property IBInspectable UIColor *disabledBackgroundColor;

@property IBInspectable UIColor *defaultBorderColor; // Layer's border color for different states
@property IBInspectable UIColor *highlightedBorderColor;
@property IBInspectable UIColor *selectedBorderColor;
@property IBInspectable UIColor *disabledBorderColor;

@property IBInspectable BOOL toggle; // Should the receiver to invert @ selected property on tap

@end










@interface KeyboardContainerView : View <UIGestureRecognizerDelegate> // Content container view, which size is changing based on keyboard apperance

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint; // Constraint which constant is changing based on keyboard appearance

@end










@interface ShapeLayerView : View

@property (class, readonly) Class layerClass;
@property (readonly) CAShapeLayer *layer;

@property IBInspectable UIColor *fillColor;
@property IBInspectable UIColor *strokeColor;

@end










@interface GradientLayerView : View

@property (class, readonly) Class layerClass;
@property (readonly) CAGradientLayer *layer;

@end










@interface GradientLayerView2 : GradientLayerView

@property IBInspectable UIColor *startColor;
@property IBInspectable UIColor *endColor;

@end










@interface EmitterCellImageView : ImageView

@property (readonly) CAEmitterCell *cell;

@end










@interface EmitterLayerView : View

@property (strong, nonatomic) IBOutletCollection(EmitterCellImageView) NSArray *cells;

@property (class, readonly) Class layerClass;
@property (readonly) CAEmitterLayer *layer;

@end










@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet ScrollView *scrollView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (strong, nonatomic) IBOutlet UILabel *sLabel1;
@property (strong, nonatomic) IBOutlet UILabel *sLabel2;
@property (strong, nonatomic) IBOutlet UILabel *sLabel3;

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;

@property (weak, nonatomic) IBOutlet Button *button1;
@property (weak, nonatomic) IBOutlet Button *button2;
@property (weak, nonatomic) IBOutlet Button *button3;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem2;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sBarButtonItem1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sBarButtonItem2;

@property (weak, nonatomic) IBOutlet TextView *textView1;

@property (weak, nonatomic) IBOutlet TextField *textField1;
@property (weak, nonatomic) IBOutlet TextField *textField2;
@property (weak, nonatomic) IBOutlet TextField *textField3;

@property (weak, nonatomic) IBOutlet TextFields *textFields1;

@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;
@property (weak, nonatomic) IBOutlet UIStackView *stackView3;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint2;

@property (weak, nonatomic) IBOutlet TimerControl *timerControl1;

@property (weak, nonatomic) IBOutlet CircleView *circleView1;

@property (weak, nonatomic) IBOutlet HandleView *handleView1;

@property (weak, readonly) UIViewController *overlay;

- (void)embedOverlayWithIdentifier:(NSString *)identifier fromStoryboard:(NSString *)storyboard;
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion;

@end










@interface KeyboardViewController : ViewController

@end

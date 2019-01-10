//
//  SectorControl.m
//  SectorControl
//
//  Created by Dan Kalinin on 1/31/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import "SectorControl.h"
#import <GLKit/GLKit.h>
#import <FoundationExt/FoundationExt.h>



@interface SectorControl ()

@property Button *sector;
@property NSArray *paths;

@end



@implementation SectorControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.disabledAlpha = 0.5;
        self.enabled = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.sectors setValue:@YES forKey:@"hidden"];
    
    if (self.initialSector) {
        [self selectSector:self.initialSector animated:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = CGRectGetMidXMidY(self.bounds);
    CGFloat outerRadius = 0.5 * (self.bounds.size.width - self.borderWidth);
    CGFloat innerRadius = outerRadius - self.sectorWidth;
    CGFloat startAngle = GLKMathDegreesToRadians(self.startAngle);
    CGFloat sectorAngle = 2.0 * M_PI / self.sectors.count;
    
    NSMutableArray *paths = [NSMutableArray array];
    for (NSUInteger index = 0; index < self.sectors.count; index++) {
        CGFloat endAngle = startAngle + sectorAngle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:outerRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path addArcWithCenter:center radius:innerRadius startAngle:endAngle endAngle:startAngle clockwise:NO];
        [path closePath];
        path.lineWidth = self.borderWidth;
        [paths addObject:path];
        startAngle = endAngle;
    }
    
    self.paths = paths;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    for (NSUInteger index = 0; index < self.sectors.count; index++) {
        Button *sector = self.sectors[index];
        UIBezierPath *path = self.paths[index];
        
        UIColor *fillColor = sector.defaultBackgroundColor;
        UIColor *strokeColor = sector.defaultBorderColor;
        NSString *title = [sector titleForState:UIControlStateNormal];
        UIColor *titleColor = [sector titleColorForState:UIControlStateNormal];
        
        if (sector.state & UIControlStateSelected) {
            fillColor = sector.selectedBackgroundColor;
            strokeColor = sector.selectedBorderColor;
            titleColor = [sector titleColorForState:UIControlStateSelected];
        }
        
        [fillColor setFill];
        [strokeColor setStroke];
        
        [path fill];
        [path stroke];
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = sector.titleLabel.font;
        attributes[NSForegroundColorAttributeName] = titleColor;
        
        CGSize size = [title sizeWithAttributes:attributes];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        
        CGContextTranslateCTM(ctx, sector.center.x, sector.center.y);
        CGContextConcatCTM(ctx, sector.layer.affineTransform);
        CGContextTranslateCTM(ctx, -0.5 * size.width, -0.5 * size.height);
        
        [title drawAtPoint:CGPointZero withAttributes:attributes];
        
        CGContextRestoreGState(ctx);
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    self.alpha = enabled ? 1.0 : self.disabledAlpha;
}

- (void)selectSector:(Button *)sector animated:(BOOL)animated {
    
    self.sector.selected = NO;
    sector.selected = YES;
    
    self.sector = sector;
    
    [self setNeedsDisplay];
}

#pragma mark - Actions

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint point = [touch locationInView:self];
    NSUInteger index = NSNotFound;
    UIBezierPath *path;
    for (NSUInteger i = 0; i < self.paths.count; i++) {
        path = self.paths[i];
        if ([path containsPoint:point]) {
            index = i;
            break;
        }
    }
    
    if (index != NSNotFound) {
        Button *sector = self.sectors[index];
        BOOL same = [sector isEqual:self.sector];
        if (same && self.deselactable && self.sector.selected) {
            sector = nil;
        }
        [self selectSector:sector animated:NO];
        if (!same || !sector) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    
    return NO;
}

@end

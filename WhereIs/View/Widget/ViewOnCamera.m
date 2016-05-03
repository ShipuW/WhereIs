//
//  ViewOnCamera.m
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "ViewOnCamera.h"

@interface ViewOnCamera ()

@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation ViewOnCamera

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, kTitleWidth, kCalloutHeight);
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews
{

    // 添加标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"title";
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin * 2 + kTitleHeight, kTitleWidth, kTitleHeight)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.textColor = [UIColor blackColor];
    self.subtitleLabel.text = @"subtitleLabel";
    self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.subtitleLabel];
}


#pragma mark - Override

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    
}

- (void)setSubtitle:(NSString *)subtitle
{
    CGSize titleSize = CGSizeZero;
    self.subtitleLabel.text = subtitle;
    titleSize = [subtitle sizeWithAttributes:@{NSFontAttributeName : self.subtitleLabel.font}];
    [self setWidth:titleSize.width + 2 * kPortraitMargin];
    [self.titleLabel setWidth:titleSize.width + 2 * kPortraitMargin];
    [self.subtitleLabel setWidth:titleSize.width + 2 * kPortraitMargin];
    
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


@end

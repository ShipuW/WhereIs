//
//  MoveWidget.m
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MoveWidget.h"

@implementation MoveWidget

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initMoveAttributes];
}


- (void) initMoveAttributes{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:_panGesture];

}

- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    
    [self.delegate beginMove: point.y];
    //NSLog(@"%f,%f",point.x,point.y);
    //rec.view.center = CGPointMake(rec.view.center.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
}



@end

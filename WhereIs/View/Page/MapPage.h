//
//  MapPage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"
#import "MapWidget.h"
#import "PositionTableWidget.h"
#import "MoveWidget.h"


@interface MapPage : BaseNavPage <PositionTableDelegate,CalloutDelegate,MoveWidgetDelegate> {
    MapWidget               *_mapWidget;
    IBOutlet UIView         *_mapView;

    MoveWidget              *_moveWidget;
    IBOutlet UIView         *_moveView;
    
    PositionTableWidget     *_positionTableWidget;
    IBOutlet UIView         *_positionTableView;
    
    IBOutlet UIButton       *_searchButton;
    IBOutlet UIButton       *_pathButton;
    IBOutlet UIButton       *_locationButton;
    IBOutlet UIButton       *_loginButton;

}

@property (nonatomic) NSString *searchKeyword;




@end

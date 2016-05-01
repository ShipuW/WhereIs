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

@interface MapPage : BaseNavPage <PositionTableDelegate> {
    IBOutlet UIView         *_mapView;
    MapWidget               *_mapWidget;
    
    IBOutlet UIButton       *_searchButton;
    
    PositionTableWidget     *_positionTableWidget;
    IBOutlet UIView         *_positionTableView;
}

@end

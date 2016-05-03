//
//  SearchWidget.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "SearchWidget.h"

@interface SearchWidget ()

@end

@implementation SearchWidget

- (void)viewDidLoad {
    [self initAttributes];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initAttributes{
    _keyword = @"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    //_keyword = searchText;
    if ([searchText isEqualToString: @""])    [_searchBar setShowsCancelButton:NO animated:YES];
    else    [_searchBar setShowsCancelButton:YES animated:YES];
    
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:NO animated:YES];
    //[self searchBar:_searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
    _keyword = searchBar.text;
    [self.delegate searchString:_keyword];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    if([searchBar.text isEqualToString:@""])
        [_searchBar setShowsCancelButton:NO animated:YES];
    //[self searchBar:_searchBar textDidChange:nil];
    [_searchBar resignFirstResponder];
}



@end

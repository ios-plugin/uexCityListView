//
//  SearchView.h
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-22.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchTableViewCellDelegate
@optional
-(BOOL)cutomSearchBarShouldBeginEditing:(UISearchBar *)searchBar;
-(BOOL)cutomSearchBarShouldEndEditing:(UISearchBar *)searchBar;
- (void)cutomSearchBarCancelButtonClicked:(UISearchBar *)searchBar;
- (BOOL)cutomSearchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString;
- (BOOL)cutomSearchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption;
-(void)cutomSearchBarSearchButtonClicked:(UISearchBar *)searchBar;
@end
@interface SearchView : UIView<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>{
    id<SearchTableViewCellDelegate>delegate;
}
@property(nonatomic,retain)UISearchBar *mySearchBar;
@property(nonatomic,retain)UISearchDisplayController *mySearchDisplayController;
@property(nonatomic,assign)id<SearchTableViewCellDelegate>delegate;
- (id)initWithFrame:(CGRect)frame ctrller:(UIViewController *)ctrller;
@end

//
//  SearchView.m
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-22.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
@synthesize delegate;
@synthesize mySearchBar;
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame ctrller:(UIViewController *)ctrller{
    if (self = [super initWithFrame:frame]) {
        if (!mySearchBar) {
            UISearchBar *tempmySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
            self.mySearchBar = tempmySearchBar;
            [tempmySearchBar release];
            
            mySearchBar.showsScopeBar = NO;
            mySearchBar.showsCancelButton = YES;
            mySearchBar.delegate = self;
            mySearchBar.backgroundColor = [UIColor clearColor];
            [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
            [mySearchBar sizeToFit];
            mySearchBar.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth);
            [self addSubview:mySearchBar];
        }
        if (!_mySearchDisplayController) {
            _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:ctrller];
            [_mySearchDisplayController setDelegate:self];
            [_mySearchDisplayController setSearchResultsDataSource:self];
            [_mySearchDisplayController setSearchResultsDelegate:self];
        }
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
-(void)dealloc{
    if (mySearchBar) {
        self.mySearchBar = nil;
    }
    if (_mySearchDisplayController) {
        [_mySearchDisplayController release];
        _mySearchDisplayController = nil;
    }
    [super dealloc];
}
#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [delegate cutomSearchBarShouldBeginEditing:searchBar];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [delegate cutomSearchBarShouldEndEditing:searchBar];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [delegate cutomSearchBarCancelButtonClicked:searchBar];
    [searchBar resignFirstResponder];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [delegate cutomSearchDisplayController:controller shouldReloadTableForSearchString:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [delegate cutomSearchDisplayController:controller shouldReloadTableForSearchScope:searchOption];
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [delegate cutomSearchBarSearchButtonClicked:searchBar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    return cell;
}
@end

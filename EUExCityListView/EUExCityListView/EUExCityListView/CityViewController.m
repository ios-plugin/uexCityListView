//
//  CityViewController.m
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-21.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import "CityViewController.h"
#import "FirstView.h"
#import "EUtility.h"
#import "ChineseString.h"
@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,FirstViewBtnClickedDelegate>{
}
@property(nonatomic,retain)UISearchBar *mySearchBar;
@property(nonatomic,retain)UISearchDisplayController *mySearchDisplayController;
@property(nonatomic,retain)NSArray *searchResults;
@property(nonatomic,retain)NSDictionary *dataDict;
@property(nonatomic,retain)NSMutableArray *universalArray;
@end

@implementation CityViewController
@synthesize dataDict;
@synthesize delegate;
@synthesize universalArray;
@synthesize dataCities,mySearchBar,mySearchDisplayController;
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
//        [self initData];
    }
    return self;
}
-(void)releaseDealloc{
    delegate = nil;
    if (self.dataCities) {
        self.dataCities = nil;
    }
    if (self.mySearchBar) {
        self.mySearchBar = nil;
    }
    if (self.mySearchDisplayController) {
        [mySearchDisplayController release];
        mySearchDisplayController = nil;
    }
    if (_tableView) {
        [_tableView removeFromSuperview];
        [_tableView release];
        _tableView = nil;
    }
    if (self.keys) {
        self.keys = nil;
    }
    if (self.arrayHotCity) {
        self.arrayHotCity = nil;
    }
    if (self.arrayCitys) {
        self.arrayCitys = nil;
    }
    if (self.cities) {
        self.cities = nil;
    }
    if (self.searchResults) {
        self.searchResults = nil;
    }
    if (self.dataDict) {
        self.dataDict = nil;
    }
}
-(void)backBtnClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        [self releaseDealloc];
    }];
}
-(void)initBackBar{
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
//    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/4);
//    backBtn.transform = at;
//    [backBtn setTitle:@"+" forState:UIControlStateNormal];
//    [backBtn setTitle:@"+" forState:UIControlStateHighlighted];
//    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [[backBtn titleLabel] setFont:[UIFont systemFontOfSize:18.0]];
//    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backBarItem;
//    [backBarItem release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initBackBar];
}
-(void)initData{
//    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
    self.keys = [NSMutableArray array];
    self.arrayCitys = [NSMutableArray array];
    [self.keys insertObject:@"🔍" atIndex:0];
    [self.keys insertObject:@"#" atIndex:1];
    [self.arrayCitys insertObject:@"🔍" atIndex:0];
    [self.arrayCitys insertObject:@"#" atIndex:1];
    NSUserDefaults *standors = [NSUserDefaults standardUserDefaults];
    NSArray *array = [standors objectForKey:@"universlCity"];
    if ([array count]>0) {
        if (![self.keys containsObject:@"$"]) {
            [self.keys insertObject:@"$" atIndex:2];
        }
    }
    if (!self.universalArray) {
        self.universalArray = [NSMutableArray arrayWithCapacity:1];
    }
    [self.universalArray addObjectsFromArray:array];
    [self getCityData];
}
-(void)initView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = [UIColor redColor];
        [self.view addSubview:_tableView];
    }else{
        
    }
    
//    CGRect rect = [UIScreen mainScreen].bounds;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 300)];
//    [headerView setBackgroundColor:[UIColor redColor]];
//    [headerView addSubview:_mySearchBar];
//    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 45.0, 80.0, 35.0)];
//    [locationLabel setText:@"定位城市"];
//    [headerView addSubview:locationLabel];
//    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 62.0, rect.size.width-100-80, 1.0)];
//    [lineLabel setBackgroundColor:[UIColor lightGrayColor]];
//    [headerView addSubview:lineLabel];
//    _tableView.tableHeaderView = _mySearchDisplayController.searchBar;
//    [headerView release];
//    [_tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self initData];
    [self initView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [self releaseDealloc];
    [super dealloc];
}
#pragma mark - 获取城市数据
-(void)getCityData
{
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
//                                                   ofType:@"plist"];
//    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!self.cities) {
        self.cities = [NSMutableDictionary dictionaryWithCapacity:1.0];
    }
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}
-(void)setViewStyle:(NSDictionary *)dict{
    if (!self.dataDict) {
        self.dataDict = [NSDictionary dictionaryWithDictionary:dict];
    }
//    NSDictionary *searchBarDict = [dict objectForKey:@"searchBar"];
//    NSString *placehoderText = [searchBarDict objectForKey:@"placehoderText"];
//    NSString *bgColorText = [searchBarDict objectForKey:@"bgColor"];
//    UIColor *bgColor = [EUtility ColorFromString:bgColorText];
//    NSString *textColorText = [searchBarDict objectForKey:@"textColor"];
//    UIColor *textColor = [EUtility ColorFromString:textColorText];
//    NSString *inputBgColorText = [searchBarDict objectForKey:@"inputBgColor"];
//    UIColor *inputBgColor = [EUtility ColorFromString:inputBgColorText];
//    self.mySearchBar.text = placehoderText;
//    self.mySearchBar.backgroundColor=bgColor;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.mySearchBar.frame];
//    imageView.backgroundColor = bgColor;
//    [self.mySearchBar insertSubview:imageView atIndex:1];
//    [imageView release];
//    
//    UITextField *searchField = [self.mySearchBar valueForKey:@"_searchField"];
//    // Change search bar text color
//    searchField.textColor = textColor;
//    searchField.backgroundColor = inputBgColor;
//    // Change the search bar placeholder text color
//    [searchField setValue:textColor forKeyPath:@"_placeholderLabel.textColor"];
//    
//    NSDictionary *sheaderViewDict = [dict objectForKey:@"headerView"];
//    bgColorText = [sheaderViewDict objectForKey:@"bgColor"];
//    bgColor = [EUtility ColorFromString:bgColorText];
//    [firstView setBackgroundColor:bgColor];
//   NSString *separatorLineColorText = [sheaderViewDict objectForKey:@"separatorLineColor"];
//    UIColor *separatorLineColor = [EUtility ColorFromString:separatorLineColorText];
//    firstView.lineLabel.backgroundColor = separatorLineColor;
//    NSString *locationLabelText = [sheaderViewDict objectForKey:@"sectionHeaderTitleColor"];
//    UIColor *sectionHeaderTitleColor = [EUtility ColorFromString:locationLabelText];
//    firstView.lineLabel.textColor = sectionHeaderTitleColor;
//    
//    [secondView setBackgroundColor:bgColor];
//    [thirdView setBackgroundColor:bgColor];
    [self.tableView reloadData];
}
#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return 0;
    }
    NSString *key = [_keys objectAtIndex:section];
    switch (section) {
        case 0:
            return 45.0;
            break;
        case 1:
            return 75.0;
            break;
        case 2:
            if ([key rangeOfString:@"$"].location != NSNotFound||[key rangeOfString:@"热"].location != NSNotFound){
                return 75.0;
            }else{
                return 20.0;
            }
        case 3:{
            NSArray *array =[self.cities objectForKey:@"hotCity"];
            if (array&&[array count]>0&&[key rangeOfString:@"热"].location != NSNotFound) {
                return [self hotCityView:array].frame.size.height;
            }else{
                return 20.0;
            }
        }
            break;
        default:
            break;
    }
    return 20.0;
}
-(UISearchBar *)searchBar{
    CGRect rect = [UIScreen mainScreen].bounds;
    if (!mySearchBar) {
       UISearchBar *temp_mySearchBar= [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 45)];
        self.mySearchBar = temp_mySearchBar;
        [temp_mySearchBar release];
        
        mySearchBar.showsScopeBar = NO;
        mySearchBar.showsCancelButton = NO;
        mySearchBar.delegate = self;
        mySearchBar.backgroundColor = [UIColor clearColor];
        [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//        [_mySearchBar sizeToFit];
//        _mySearchBar.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth);
        mySearchBar.placeholder = @"请输入城市中文名或拼音";
    }
    if (!mySearchDisplayController) {
      UISearchDisplayController  *temp_mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
        self.mySearchDisplayController = temp_mySearchDisplayController;
        [temp_mySearchDisplayController release];
        [mySearchDisplayController setDelegate:self];
        [mySearchDisplayController setSearchResultsDataSource:self];
        [mySearchDisplayController setSearchResultsDelegate:self];
    }
    if (self.dataDict) {//设置searchBar颜色
        NSDictionary *searchBarDict = [self.dataDict objectForKey:@"searchBar"];
        NSString *placehoderText = [searchBarDict objectForKey:@"placehoderText"];
        NSString *bgColorText = [searchBarDict objectForKey:@"bgColor"];
        UIColor *bgColor = [EUtility ColorFromString:bgColorText];
        NSString *textColorText = [searchBarDict objectForKey:@"textColor"];
        UIColor *textColor = [EUtility ColorFromString:textColorText];
        NSString *inputBgColorText = [searchBarDict objectForKey:@"inputBgColor"];
        UIColor *inputBgColor = [EUtility ColorFromString:inputBgColorText];
        self.mySearchBar.text = placehoderText;
        self.mySearchBar.backgroundColor=bgColor;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.mySearchBar.frame];
        imageView.backgroundColor = bgColor;
        [self.mySearchBar insertSubview:imageView atIndex:1];
        [imageView release];
        
        UITextField *searchField = [self.mySearchBar valueForKey:@"_searchField"];
        // Change search bar text color
        searchField.textColor = textColor;
        searchField.backgroundColor = inputBgColor;
        // Change the search bar placeholder text color
        [searchField setValue:textColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return mySearchBar;
}
//FirstViewBtnClickedDelegate
-(void)FirstViewBtnClicked:(NSString *)title{
    if ([delegate respondsToSelector:@selector(CityViewBtnClicked:)]) {
        [delegate CityViewBtnClicked:title];
    }
    if (![self.keys containsObject:@"$"]) {
        [self.keys insertObject:@"$" atIndex:2];
    }    NSUserDefaults *standors = [NSUserDefaults standardUserDefaults];
    if (!self.universalArray) {
        self.universalArray = [NSMutableArray arrayWithCapacity:1];
    }
    if ([self.universalArray count]==3) {
//        [self.universalArray removeLastObject];
    }
    if ([self.universalArray containsObject:title]) {
        [self.universalArray removeObject:title];
    }
   [self.universalArray insertObject:title atIndex:0];
    NSArray *array = [NSArray arrayWithArray:self.universalArray];
    [standors setObject:array forKey:@"universlCity"];
    [self.tableView reloadData];
}
-(UIView *)locationView:(NSString *)city{
    CGRect rect = [UIScreen mainScreen].bounds;
    if (city == nil) {
        city = @"定位中..";
    }
    NSArray *array = [NSArray arrayWithObjects:city,nil];
    NSDictionary *_dataDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"定位城市",nil];
    FirstView *first = [[FirstView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width, 95)data:_dataDict];
    [first setDelegate:self];
    if (self.dataDict) {
        NSDictionary *sheaderViewDict = [self.dataDict objectForKey:@"headerView"];
        [first setHeaderViewColor:sheaderViewDict];
    }
    return first;
}
-(UIView *)searchCityView{
    CGRect rect = [UIScreen mainScreen].bounds;
    NSUserDefaults *standors = [NSUserDefaults standardUserDefaults];
    NSArray *array = [standors objectForKey:@"universlCity"];
//    NSArray *array = [NSArray arrayWithObjects:@"唐山市",@"北京市",@"广州市",nil];
    NSDictionary *_dataDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"最近搜索城市",nil];
    FirstView *first = [[FirstView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width, 95)data:_dataDict];
    [first setDelegate:self];
    if (self.dataDict) {
        NSDictionary *sheaderViewDict = [self.dataDict objectForKey:@"headerView"];
        [first setHeaderViewColor:sheaderViewDict];
    }
    return first;
}
-(UIView *)hotCityView:(NSArray *)hotCityArray{
    CGRect rect = [UIScreen mainScreen].bounds;
//    NSArray *array = [NSArray arrayWithObjects:@"唐山市",@"北京市",@"广州市",@"上海市",@"唐山市",@"北京市",@"广州市",@"上海市",@"天津市",nil];
    NSDictionary *_dataDict = [NSDictionary dictionaryWithObjectsAndKeys:hotCityArray,@"热门城市",nil];
    FirstView *first = [[FirstView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width, 95)data:_dataDict];
    [first setDelegate:self];
    if (self.dataDict) {
        NSDictionary *sheaderViewDict = [self.dataDict objectForKey:@"headerView"];
        [first setHeaderViewColor:sheaderViewDict];
    }
    return first;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *key = [_keys objectAtIndex:section];
    NSLog(@"self.citise:%@",self.cities);
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return nil;
    }
    if (section == 0) {
        return [self searchBar];
    }
    if (section == 1){
        NSString *city =[self.cities objectForKey:@"city"];
        return [self locationView:city];
    }
//    else if(section == 2){
//        return [self searchCityView];
//    }
    if ([key rangeOfString:@"$"].location != NSNotFound){
        return [self searchCityView];
    }
    if ([key rangeOfString:@"热"].location != NSNotFound){
        NSArray *array =[self.cities objectForKey:@"hotCity"];
        if (array&&[array count]>0) {
            return [self hotCityView:array];
        }
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.alpha = 0.8;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    if (self.dataDict) {
        NSDictionary *listViewDict = [self.dataDict objectForKey:@"listView"];
        NSString  *sectionHeaderBgColorText = [listViewDict objectForKey:@"sectionHeaderBgColor"];
        UIColor *sectionHeaderBgColor = [EUtility ColorFromString:sectionHeaderBgColorText];
        titleLabel.backgroundColor = sectionHeaderBgColor;
        bgView.backgroundColor = sectionHeaderBgColor;
        NSString  *sectionHeaderTitleColorText = [listViewDict objectForKey:@"sectionHeaderTitleColor"];
        UIColor *sectionHeaderTitleColor = [EUtility ColorFromString:sectionHeaderTitleColorText];
        titleLabel.textColor = sectionHeaderTitleColor;
    }else{
        bgView.backgroundColor = [UIColor lightGrayColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
    }
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    [titleLabel release];
    return [bgView autorelease];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return nil;
    }
    return _keys;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return 1;
    }
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return [self.searchResults count];
    }
    // Return the number of rows in the section.
    if(section==0||section==1){
        return 0;
    }
    NSString *key = [_keys objectAtIndex:section];
    if (section==2&&[key rangeOfString:@"$"].location != NSNotFound){
        return 0.0;
    }else if (section==2&&[key rangeOfString:@"热"].location != NSNotFound){
        return 0.0;
    }else if (section==3&&[key rangeOfString:@"热"].location != NSNotFound){
        return 0.0;
    }
    NSArray *citySection = [self.arrayCitys objectAtIndex:section];
    return [citySection count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return 45.0;
    }
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 0;
    }
    return 45;
}
- (UITableViewCell *)searchResultsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"resultCell";
    UITableViewCell *cell = [mySearchDisplayController.searchResultsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if ([mySearchDisplayController.searchResultsTableView isEqual:tableView]) {
        return [self searchResultsTableView:tableView cellForRowAtIndexPath:indexPath];
    }
//    NSString *key = [_keys objectAtIndex:indexPath.section];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    if (self.dataDict) {
        NSDictionary *listViewDict = [self.dataDict objectForKey:@"listView"];
        NSString  *bgColorText = [listViewDict objectForKey:@"bgColor"];
        UIColor *bgColor = [EUtility ColorFromString:bgColorText];
        cell.backgroundColor = bgColor;
        cell.contentView.backgroundColor = bgColor;
        NSString  *itemTextText = [listViewDict objectForKey:@"itemTextColor"];
        UIColor *itemTextColor = [EUtility ColorFromString:itemTextText];
        [cell.textLabel setTextColor:itemTextColor];
        
        NSString  *separatorLineColorText = [listViewDict objectForKey:@"separatorLineColor"];
        UIColor *separatorLineColor = [EUtility ColorFromString:separatorLineColorText];
        [self.tableView setSeparatorColor:separatorLineColor];
        NSDictionary *indexBarDict = [self.dataDict objectForKey:@"indexBar"];
        NSString  *indexBarColorText = [indexBarDict objectForKey:@"indexBarTextColor"];
        UIColor *indexBarColor = [EUtility ColorFromString:indexBarColorText];
        self.tableView.sectionIndexColor = indexBarColor;
    }else{
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.textLabel setTextColor:[UIColor blackColor]];
    }
//    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:row];
    NSArray *arr = [self.arrayCitys objectAtIndex:section];
    ChineseString *str = (ChineseString *)[arr objectAtIndex:row];
    cell.textLabel.text = str.string;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *title = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    if (![self.keys containsObject:@"$"]) {
        [self.keys insertObject:@"$" atIndex:2];
    }
    NSUserDefaults *standors = [NSUserDefaults standardUserDefaults];
    if (!self.universalArray) {
        self.universalArray = [NSMutableArray arrayWithCapacity:1];
    }
    if ([self.universalArray count]==3) {
        [self.universalArray removeLastObject];
    }
    if ([self.universalArray containsObject:title]) {
        [self.universalArray removeObject:title];
    }
    [self.universalArray insertObject:title atIndex:0];
    NSArray *array = [NSArray arrayWithArray:self.universalArray];
    [standors setObject:array forKey:@"universlCity"];
    [self.tableView reloadData];
    
    if ([delegate respondsToSelector:@selector(CityViewBtnClicked:)]) {
        [delegate CityViewBtnClicked:title];
    }
}
#pragma mark UISearchBar and UISearchDisplayController Delegate Methods
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [_mySearchDisplayController setActive:YES animated:YES];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    return YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText scope:0];
    [mySearchDisplayController.searchResultsTableView reloadData];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)filterContentForSearchText:(NSString*)searchText  scope:(NSString*)scope {
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
//    NSArray *array = [self.cities allValues];
//    NSMutableArray *allCities = [[NSMutableArray alloc] initWithCapacity:1];
//    for (NSArray *arry in self.dataCities) {
//        [allCities addObjectsFromArray:arry];
//    }
    self.searchResults = [self.dataCities filteredArrayUsingPredicate:resultPredicate];
    if ([self.searchResults count] == 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
- (BOOL)schDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:0];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
     [self filterContentForSearchText:[controller.searchBar text] scope:0];
    return YES;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@""]) {
        return;
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end

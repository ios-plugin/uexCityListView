//
//  EUExCityListView.m
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-18.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import "EUExCityListView.h"
#import "CityViewController.h"
#import "EUtility.h"
#import "JSON.h"
#import "pinyin.h"
#import "ChineseString.h"
@interface EUExCityListView()<CityViewDelegate>{
    CityViewController *cityVC;
    UINavigationController *nav;
}
@property(nonatomic,retain)NSMutableArray *sectionHeadsKeys;
@end
@implementation EUExCityListView
@synthesize sectionHeadsKeys;
-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
        
    }
    return self;
}
-(void)open:(NSMutableArray *)array{
    if ([array count] ==0) {
        NSLog(@"paragms is error!!");
        return;
    }
    NSDictionary *dict = [[array objectAtIndex:0] JSONValue];
    CGFloat x = [[dict objectForKey:@"x"] floatValue];
    CGFloat y = [[dict objectForKey:@"y"] floatValue];
    CGFloat width = [[dict objectForKey:@"w"] floatValue];
    CGFloat height = [[dict objectForKey:@"h"] floatValue];
    if (!cityVC) {
        cityVC = [[CityViewController alloc] init];
        cityVC.view.backgroundColor = [UIColor whiteColor];
        cityVC.delegate = self;
    }
    if (!nav) {
        nav = [[UINavigationController alloc] initWithRootViewController:cityVC];
        [nav.view setFrame:CGRectMake(x, y, width, height)];
    }
//    [EUtility brwView:self.meBrwView presentModalViewController:nav animated:YES];
    [EUtility brwView:self.meBrwView addSubview:nav.view];
}
-(void)close:(NSMutableArray *)array{
    if (cityVC) {
        [cityVC.view removeFromSuperview];
        [cityVC release];
        cityVC = nil;
    }
    if (nav) {
        [nav.view removeFromSuperview];
        [nav release];
        nav = nil;
    }
    if(self.sectionHeadsKeys){
        self.sectionHeadsKeys = nil;
    }
}
-(void)setLocalCity:(NSMutableArray *)array{
    if ([array count]==0) {
        NSLog(@"paragms is error!!");
        return;
    }
    NSString *jsonStr = [array objectAtIndex:0];
    NSDictionary *dict = [jsonStr JSONValue];
    NSString *city = [dict objectForKey:@"city"];
    if (cityVC) {
        [cityVC.cities setObject:city forKey:@"city"];
    }
    [cityVC.tableView reloadData];
}
-(void)setHotCity:(NSMutableArray *)array{
    if ([array count]==0) {
        NSLog(@"paragms is error!!");
        return;
    }
    NSString *jsonStr = [array objectAtIndex:0];
    NSDictionary *dict = [jsonStr JSONValue];
    NSString *hotCity = [dict objectForKey:@"hotCity"];
    if (cityVC) {
        if (![cityVC.keys containsObject:@"热"]) {
            NSUserDefaults *standors = [NSUserDefaults standardUserDefaults];
            NSArray *array = [standors objectForKey:@"universlCity"];
            if ([array count]>0) {
                [cityVC.keys insertObject:@"热" atIndex:3];
                [cityVC.arrayCitys insertObject:@"热" atIndex:3];
            }else{
                [cityVC.keys insertObject:@"热" atIndex:2];
                [cityVC.arrayCitys insertObject:@"热" atIndex:2];
            }
            [cityVC.cities setObject:hotCity forKey:@"hotCity"];
        }
    }
    [cityVC.tableView reloadData];
}
- (NSMutableArray *)getChineseStringArr:(NSMutableArray *)arrToSort {
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string=[NSString stringWithString:[arrToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            //join the pinYin
            NSString *pinYinResult = [NSString string];
            for(int j = 0;j < chineseString.string.length; j++) {
                NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                 pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin = pinYinResult;
        } else {
            chineseString.pinYin = @"";
        }
        [chineseStringsArray addObject:chineseString];
        [chineseString release];
    }
    
    //sort the ChineseStringArr by pinYin
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    
    NSMutableArray *arrayForArrays = [NSMutableArray array];
    BOOL checkValueAtIndex= NO;  //flag to check
    NSMutableArray *TempArrForGrouping = nil;
    
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        ChineseString *chineseStr = (ChineseString *)[chineseStringsArray objectAtIndex:index];
        NSMutableString *strchar= [NSMutableString stringWithString:chineseStr.pinYin];
        NSString *sr= [strchar substringToIndex:1];
        NSLog(@"%@",sr);        //sr containing here the first character of each string
        if(![self.sectionHeadsKeys containsObject:[sr uppercaseString]])//here I'm checking whether the character already in the selection header keys or not
        {
            [self.sectionHeadsKeys addObject:[sr uppercaseString]];
            TempArrForGrouping = [[[NSMutableArray alloc] initWithObjects:nil] autorelease];
            checkValueAtIndex = NO;
        }
        if([self.sectionHeadsKeys containsObject:[sr uppercaseString]])
        {
            [TempArrForGrouping addObject:[chineseStringsArray objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    return arrayForArrays;
}
-(void)setAllCity:(NSMutableArray *)array{
    if ([array count]==0) {
        NSLog(@"paragms is error!!");
        return;
    }
    NSString *jsonStr = [array objectAtIndex:0];
    NSDictionary *dict = [jsonStr JSONValue];
    NSMutableArray *_dataArr = [dict objectForKey:@"city"];
    NSLog(@"_sectionHeadsKeys:%@",self.sectionHeadsKeys);
    if ([self.sectionHeadsKeys count]>0) {
        [self.sectionHeadsKeys removeAllObjects];
    }
    if (!self.sectionHeadsKeys) {
        self.sectionHeadsKeys = [NSMutableArray arrayWithCapacity:1];
    }
    NSMutableArray *sortedArrForArrays = [self getChineseStringArr:_dataArr];
    if (cityVC) {
//        [cityVC.cities addEntriesFromDictionary:dict];
//        [cityVC.keys addObjectsFromArray:[[dict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        [cityVC.arrayCitys addObjectsFromArray:sortedArrForArrays];
        [cityVC.keys addObjectsFromArray:[sectionHeadsKeys sortedArrayUsingSelector:@selector(compare:)]];
        cityVC.dataCities = [NSMutableArray arrayWithArray:_dataArr];
    }
    [cityVC.tableView reloadData];
}
-(void)setViewStyle:(NSMutableArray *)array{
    NSString *jsonStr = [array objectAtIndex:0];
    NSDictionary *dict = [jsonStr JSONValue];
    if (cityVC) {
        [cityVC setViewStyle:dict];
    }
}
//CityViewDelegate
-(void)CityViewBtnClicked:(NSString *)dataStr{
//    NSDictionary *jsonDict = [NSDictionary dictionaryWithObject:dataStr forKey:@"city"];
    NSString *jsonStr = [NSString stringWithFormat:@"{\"city\":\"%@\"}",dataStr];
    NSString *json = [NSString stringWithFormat:@"uexCityListView.onItemClick('%@')",jsonStr];
    [self.meBrwView stringByEvaluatingJavaScriptFromString:json];
}
//当前窗口调用uexWindow.close()接口的时候 插件的clean方法会被调用
-(void)clean{
    [self close:nil];
    [super clean];
}
@end


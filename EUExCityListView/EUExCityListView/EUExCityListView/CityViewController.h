//
//  CityViewController.h
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-21.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CityViewController;
@protocol CityViewDelegate <NSObject>
-(void)CityViewBtnClicked:(NSString *)data;
@end
@interface CityViewController : UIViewController{
    id<CityViewDelegate>delegate;
}
@property (nonatomic, retain) NSMutableDictionary *cities;//所有城市列表数组
@property (nonatomic, retain) NSMutableArray *keys; //城市首字母
@property (nonatomic, retain) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, retain) NSMutableArray *arrayHotCity;//热门城市
@property(nonatomic,retain)NSMutableArray *dataCities;
@property(nonatomic,retain)UITableView *tableView;
@property(nonatomic,assign) id<CityViewDelegate>delegate;
-(void)getCityData;
-(void)setViewStyle:(NSDictionary *)dict;
@end

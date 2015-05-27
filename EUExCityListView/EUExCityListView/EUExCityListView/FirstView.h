//
//  FirstView.h
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-21.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstView;
@protocol FirstViewBtnClickedDelegate <NSObject>
-(void)FirstViewBtnClicked:(NSString *)firstView;
@end
@interface FirstView : UIView{
    id<FirstViewBtnClickedDelegate>delegate;
}
@property(nonatomic,retain)UILabel *locationLabel;
@property(nonatomic,retain)UILabel *lineLabel;
@property(nonatomic,assign)id<FirstViewBtnClickedDelegate>delegate;
- (id)initWithFrame:(CGRect)frame data:(NSDictionary *)dataDict;
-(void)setHeaderViewColor:(NSDictionary *)colorDict;
@end

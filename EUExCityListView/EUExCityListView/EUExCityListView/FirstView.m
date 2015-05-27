//
//  FirstViewFirstCell.m
//  AppCanPlugin
//
//  Created by hongbao.cui on 14-12-21.
//  Copyright (c) 2014年 zywx. All rights reserved.
//

#import "FirstView.h"
#import "EUtility.h"
@implementation FirstView
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
}
-(void)cityButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(FirstViewBtnClicked:)]) {
        [delegate FirstViewBtnClicked:sender.titleLabel.text];
    }
}
-(UIImage *)getLocalImage:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}
- (id)initWithFrame:(CGRect)frame data:(NSDictionary *)dataDict{
    if (self = [super initWithFrame:frame]) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 25)];
        NSString *key = [[dataDict allKeys] objectAtIndex:0];
        [_locationLabel setText:key];
        [_locationLabel setTextColor:[EUtility ColorFromString:@"#8f8e94"]];
        _locationLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_locationLabel];
        CGRect rect = [UIScreen mainScreen].bounds;
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, rect.size.width-120, 1)];
        [_lineLabel setBackgroundColor:[EUtility ColorFromString:@"#cccccc"]];
        [self addSubview:_lineLabel];
        NSArray *dataArray = [dataDict objectForKey:key];
        int iCount = [dataArray count]%3;
        int jCount = [dataArray count]/3;
        int count = 0;
        int aCount = 0;
        if (iCount ==0) {
            count = jCount;
            aCount = 3;
        }else{
            count = jCount+1;
            aCount = iCount;
        }
        int index=0;
        for (int i= 0 ; i<count; i++) {
            if ((i==count-1)&&iCount) {
                aCount = iCount;
            }else{
                aCount =3;
            }
            for (int j=0; j<aCount; j++) {
                NSString *title = [dataArray objectAtIndex:index];
                UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [cityButton setFrame:CGRectMake(10.0+j*(80+10), 35+(30+10)*i, 80, 30)];
                [cityButton setTitle:title forState:UIControlStateNormal];
                [cityButton setTitle:title forState:UIControlStateHighlighted];
                [cityButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [cityButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//                [cityButton setBackgroundImage:[self getLocalImage:@"uexCityListView/blank"] forState:UIControlStateNormal];
//                [cityButton setBackgroundImage:[self getLocalImage:@"uexCityListView/blank"] forState:UIControlStateHighlighted];
                [cityButton.layer setMasksToBounds:YES];
                [cityButton.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
                [cityButton.layer setBorderWidth:1.0]; //边框宽度
                cityButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [cityButton addTarget:self action:@selector(cityButton:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:cityButton];
                index++;
            }
        }
        self.frame = CGRectMake(0, 0, frame.size.width,  35+(30+10)*count+10);
    }
    return self;
}
-(void)setHeaderViewColor:(NSDictionary *)colorDict{
   NSString  *bgColorText = [colorDict objectForKey:@"bgColor"];
   UIColor *bgColor = [EUtility ColorFromString:bgColorText];
    [self setBackgroundColor:bgColor];
    NSString *separatorLineColorText = [colorDict objectForKey:@"separatorLineColor"];
    UIColor *separatorLineColor = [EUtility ColorFromString:separatorLineColorText];
    _lineLabel.backgroundColor = separatorLineColor;
    NSString *locationLabelText = [colorDict objectForKey:@"sectionHeaderTitleColor"];
    UIColor *sectionHeaderTitleColor = [EUtility ColorFromString:locationLabelText];
    _locationLabel.textColor = sectionHeaderTitleColor;
    NSString *itemTextColorText = [colorDict objectForKey:@"itemTextColor"];
    UIColor *itemTextColor = [EUtility ColorFromString:itemTextColorText];
    
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            [subBtn setTitleColor:itemTextColor forState:UIControlStateNormal];
            [subBtn setTitleColor:itemTextColor forState:UIControlStateHighlighted];
            subBtn.layer.borderColor = itemTextColor.CGColor;
        }
    }
}
-(void)dealloc{
    if (_locationLabel) {
        [_locationLabel release];
    }
    if (_lineLabel) {
        [_lineLabel release];
    }
    delegate = nil;
    [super dealloc];
}
@end

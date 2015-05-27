//
//  Beqtucontent.m
//  WBPlam
//
//  Created by Leilei Xu on 12-7-23.
//  Copyright (c) 2012年 zywx. All rights reserved.
//

#import "Beqtucontent.h"

@implementation Beqtucontent

static NSString *html5appcandemo = @"26cf1a0e-6d52-41aa-bb54-f4efe8a35d33";

+(NSString*)getContentPath{
    if (!html5appcandemo) {
        return @"";
    }
return html5appcandemo;
}
@end

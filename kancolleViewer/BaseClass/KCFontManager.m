//
//  KCFontManager.m
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import "KCFontManager.h"

@implementation KCFontManager

+ (UIFont *)rFontOfSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];//这个是9.0以后自带的平方字体
    if(!font){
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

@end

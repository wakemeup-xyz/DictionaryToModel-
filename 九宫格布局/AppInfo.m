//
//  AppInfo.m
//  九宫格布局
//
//  Created by Zhang Xiangyu on 16/4/5.
//  Copyright © 2016年 Zhang Xiangyu. All rights reserved.
//

#import "AppInfo.h"

@interface AppInfo ()
{
    UIImage *_imageExtra;
    
}

@end

@implementation AppInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (UIImage *)image
{
    if (!_imageExtra) {
        _imageExtra = [UIImage imageNamed:self.icon];
    }
    return _imageExtra;
}


@end

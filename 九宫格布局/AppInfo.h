//
//  AppInfo.h
//  九宫格布局
//
//  Created by Zhang Xiangyu on 16/4/5.
//  Copyright © 2016年 Zhang Xiangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppInfo : NSObject

//应用程序名称
@property (nonatomic, copy) NSString *name;

//应用程序图标名称
@property (nonatomic, copy) NSString *icon;

//图像
//使用 readonly 防止误操作修改 image
//定义属性时，会生成 getter & setter 方法，还会生成一个带下划线的成员变量
//使用 readonly 时只有 getter 方法，没有带下划线的成员变量
//解决方法，自己在 .m 文件中添加一个私有扩展变量。
@property (nonatomic, strong, readonly) UIImage *image;


//instancetype 会让编译器检查实例化对象的准确类型
//instancetype 只能用于返回类型，不能当作参数使用
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)appInfoWithDict:(NSDictionary *)dict;

@end

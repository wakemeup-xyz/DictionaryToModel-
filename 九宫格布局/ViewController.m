//
//  ViewController.m
//  九宫格布局
//
//  Created by Zhang Xiangyu on 16/4/2.
//  Copyright © 2016年 Zhang Xiangyu. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"


@interface ViewController ()

@property(strong, nonatomic)NSArray *appList;

@end

@implementation ViewController

- (NSArray *)appList{
    if (!_appList) {
        NSBundle *bundle = [NSBundle mainBundle]; //用于从 Navigator 中获取文件
        NSString *path = [bundle pathForResource:@"app.plist" ofType:nil];
//        _appList = [NSArray arrayWithContentsOfFile:path];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        //将数组转换为模型，意味着self.appList 中存储的是AppInfo 对象
           //1.便利数组，将数组中的字典一次转换成 AppInfo 对象，添加到一个临时数组
           //2. self.appList = 临时数组
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array){
            [arrayM addObject:[AppInfo appInfoWithDict:dict]];
        }
        _appList = arrayM;
        //相比而言 array 中 存的是字典，而 arrayM 中存的是 Appinfo
        
    }
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat viewWidth = 100;
    CGFloat viewHeight = 120;
    int totalCol = 3; //表示 3 列
    CGFloat marginX = (self.view.bounds.size.width - totalCol * viewWidth) / (totalCol + 1);
    CGFloat marginY = 10;
    
    for (int i = 0; i < self.appList.count; i++) {
        
    //行数 row （从 0 开始算）
        int row = i / totalCol;
    //列数 col
        int col = i % totalCol;
    
    //x 值
        CGFloat x = marginX + (viewWidth + marginX) * col;
    //y 值
        CGFloat y = marginY + (viewHeight + marginY) * row + 20;
        
        UIView * appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
  
        [self.view addSubview:appView];
    
//创建appView 内部的控件细节
    //0. 读取数组中的字典
        //NSDictionary *dict = self.appList[i];
        AppInfo *appInfo = self.appList[i];
    //1. UIImageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,viewWidth,80)]; //为相对于父控件的坐标  即相对于 appView
        
        //从字典加载图像
        //imageView.image = [UIImage imageNamed:appInfo.icon];
        
        //直接加载图像
        imageView.image = appInfo.image;
        
        //按比例显示图像
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [appView addSubview:imageView];
    //2. UILabel
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,imageView.bounds.size.height, viewWidth,20)];
        //设置文字
        label.text = appInfo.name;
        //设置字体
        label.font = [UIFont systemFontOfSize:12];
        //设置居中
        label.textAlignment = NSTextAlignmentCenter;
        
        [appView addSubview:label];
        
    //3. UIButton
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; //UIButton 是唯一有类方法创建的 UI 控件。 同时 [[UIButton alloc] init] 生成的也是自定义类型。
        button.frame = CGRectMake(0, imageView.bounds.size.height + label.bounds.size.height, viewWidth, 20);
        
        //设置文字
        [button setTitle:@"下载" forState:UIControlStateNormal];
        
        //设置文字大小：
            //在 UIButton 中其实会有一个 UILabel 来存储显示的文字,为 titleLabel
            //这里 titile 声明是 @property(nullable, nonatomic,readonly,strong) UILabel     *titleLabel NS_AVAILABLE_IOS(3_0);
            // @property中的readonly 表示 titleLabel 指针只能指向这个 label，但是label的内容我们是可以修改的
            //但是设置文字内容不能这么搞，因为不知道针对于哪种状态
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //可能要设置文字颜色！！默认的文字颜色是白色的所以看不到
        //[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"button_highlighted"] forState:UIControlStateHighlighted];
        
        //设置 tag
        button.tag = i;
        //添加响应事件
        [button addTarget:self action:@selector(downloadClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [appView addSubview:button];
        
    }
   
}

- (void)downloadClick:(UIButton *)button{
    NSLog(@"%d",button.tag);
    
    //实例化一个 UILabel 显示在视图上，提示用户下载完成 ,居中显示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 80,self.view.bounds.size.height / 2  - 20, 160, 40)];
    
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    //NSDictionary *dict = self.appList[button.tag];
    AppInfo *appInfo = self.appList[button.tag];
    label.text = [NSString stringWithFormat:@"下载%@完成",appInfo.name];
    label.font = [UIFont systemFontOfSize:13];
    label.alpha = 0;
    [self.view addSubview:label];

//    //首位式动画效果 思路：利用透明的 alpha 从 0 变为 1
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    label.alpha = 1;
//    [UIView commitAnimations];
    
    //动画效果完成之后，将label 从视图中删除，另外一种动画效果
    [UIView animateWithDuration:2.0 animations:^{
        label.alpha = 0.6;
    } completion:^(BOOL finished){
        //删除 label
        [label removeFromSuperview];
        
    }];
    
}



@end

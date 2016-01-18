//
//  ViewController.m
//  UI26_Animation
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewOfRed;

@property (weak, nonatomic) IBOutlet UIView *viewOfGray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 知识点1 UIview 实现动画(1/2)
- (IBAction)handleView1:(id)sender {
    
    
    /** API 1 **/
    
//        [UIView animateWithDuration:2 animations:^{
//          //设置空间属性值
//            self.viewOfGray.frame = CGRectMake(0, 550, self.viewOfGray.frame.size.width, 120);
//            self.viewOfGray.backgroundColor = [UIColor cyanColor];
//        }];
    
    
    
    
    /** API 2 **/
    
//        [UIView animateWithDuration:2 animations:^{
//    
//            self.viewOfGray.frame = CGRectMake(0, 550, self.viewOfGray.frame.size.width, 120);
//    
//    
//        } completion:^(BOOL finished) {
//    
//            self.viewOfGray.backgroundColor = [UIColor blueColor];
//     
//        }];

    
    
    /** API 3 options参数  控制动画效果  **/

//    
//        [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionAutoreverse |UIViewAnimationOptionRepeat animations:^{
//    
//            self.viewOfGray.frame = CGRectMake(0, 550, self.viewOfGray.frame.size.width, 120);
//        } completion:^(BOOL finished) {
//    
//        }];
//    

    
 /** API 4 **/
    
        [UIView animateWithDuration:10 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:1 options:UIViewAnimationOptionRepeat animations:^{
    
            self.viewOfGray.frame = CGRectMake(0, 550, self.viewOfGray.frame.size.width, 80);
        } completion:^(BOOL finished) {
            
        }];
}


#pragma mark -- 知识点2 


- (IBAction)handleview2:(id)sender {
    
       //准备开始动画
    
        [UIView beginAnimations:@"abc" context:nil];

        // 设置动画参数
    
        [UIView setAnimationDuration:2];
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
    
        [UIView setAnimationRepeatAutoreverses:YES];
    
        //控件属性的更改
    
        self.viewOfGray.frame = CGRectMake(0, 550, self.viewOfGray.frame.size.width, 120);
    
        self.viewOfGray.backgroundColor = [UIColor redColor];

        // 提交动画
        
        
        [UIView commitAnimations];
}






#pragma mark  知识点 3  CABasicAnimation

- (IBAction)handleBasic:(id)sender {
    
    // 创建动画对象
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    
    // 动画对象的设置
    basic.fromValue = @1;
    basic.toValue = @0.5;
    
    basic.duration = 1;
    basic.autoreverses = YES;
    basic.repeatCount = CGFLOAT_MAX;
    
    //layer 层 上添加动画
    [self.viewOfGray.layer addAnimation:basic forKey:@"basic"];
}


#pragma mark - 知识点 4 : CAAnimationGroup

- (IBAction)handleAnimationGroup:(id)sender {
    
    // 创建动画组对象
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    
    CABasicAnimation *basic1 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    basic1.fromValue = @1;
    basic1.toValue = @0.5;
    
    CABasicAnimation *basic2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    
    basic2.fromValue = @0;
    basic2.toValue = @(M_PI *2);
    
    group.animations = @[basic1, basic2];
    
    group.duration = 1;
    group.autoreverses = NO;// 返回
    group.repeatCount = CGFLOAT_MAX;

    
    // layer 层添加 动画对象

    [self.viewOfGray.layer addAnimation:group forKey:@"group"];
    

    
}


#pragma mark -- 知识点 5 : CAKeyFrameAnimation

- (IBAction)handleKeyFrame:(id)sender {
    
    // 创建动画对象
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    // 设置动画的 API
    
    
    
    // 通过函数创建 CGPathRef 结构体 (创建点 开始点 创建路径 CGPathCreateMutable())
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //起始点
    
    CGPathMoveToPoint(path, nil, self.viewOfRed.center.x  , self.viewOfRed.center.y);
    
    /** 路径经过的点 **/
    
    /** 直线移动 */
//    CGPathAddLineToPoint (path, nil , 150,150);
//    CGPathAddLineToPoint (path, nil , 200,300);
//    CGPathAddLineToPoint (path, nil , 200,300);
    
    
    /** 曲线移动 */
    CGPathAddCurveToPoint(path, nil, self.viewOfRed.center.x, self.viewOfRed.center.y, self.viewOfRed.center.x, self.viewOfRed.center.y + 100, self.viewOfRed.center.x + 100, self.viewOfRed.center.y + 100);
    
    
    
    keyFrame.path = path;
    keyFrame.duration = 2;
    keyFrame.repeatCount = CGFLOAT_MAX;
    keyFrame.autoreverses = YES;
    
    // layer 层添加动画
    
    [self.viewOfRed.layer addAnimation:keyFrame forKey:@"KeyFrame"];
    
    
    
    
}

#pragma mark -- 知识点 6 :CATranstion


- (IBAction)handleTranstion:(id)sender {
    
    // 创建动画对象
    
    CATransition *sition = [CATransition animation];
    
    
    
    // 设置动画 API 属性
    
    sition.type = @"cameraIrisHollowOpen";
    sition.repeatCount = CGFLOAT_MAX;
    sition.autoreverses = NO;
    sition.duration = 10;
    
    
    
    
    // layer 上添加动画
    
    [self.viewOfGray.layer addAnimation:sition forKey:@"sition"];
    

    
    
    
    
}



/** type
 *
 *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于私有的API.
 *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
 *  @"cube"                     立方体翻滚效果
 *  @"moveIn"                   新视图移到旧视图上面
 *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
 *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
 *  @"pageCurl"                 向上翻一页
 *  @"pageUnCurl"               向下翻一页
 *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
 *  @"rippleEffect"             滴水效果,(不支持过渡方向)
 *  @"oglFlip"                  上下左右翻转效果
 *  @"rotate"                   旋转效果
 *  @"push"
 *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
 *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
 */

/** type
 *
 *  kCATransitionFade            交叉淡化过渡
 *  kCATransitionMoveIn          新视图移到旧视图上面
 *  kCATransitionPush            新视图把旧视图推出去
 *  kCATransitionReveal          将旧视图移开,显示下面的新视图
 */







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

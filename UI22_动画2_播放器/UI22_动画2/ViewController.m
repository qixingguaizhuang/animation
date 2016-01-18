//
//  ViewController.m
//  UI22_动画2
//
//  Created by yutao on 15/11/9.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,retain)UIView *aView;

@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)BOOL isRotation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.aView = [[UIView alloc] initWithFrame:CGRectMake(170, 150, 80, 40)];
    self.aView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.aView];


    self.myImageView.image = [UIImage imageNamed:@"liuJD.jpg"];
    //裁掉边框
    self.myImageView.layer.masksToBounds = YES;
    //设置半径
    self.myImageView.layer.cornerRadius = 150;
    self.myImageView.layer.borderWidth = 3;
    self.myImageView.layer.borderColor = [UIColor greenColor].CGColor;

    //改变view z轴值
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转的起始值,从0点开始旋转
    animation.fromValue = [NSNumber numberWithInt:0];
    //最终旋转的角度是360度
    animation.toValue = [NSNumber numberWithInt:M_PI * 2];
    
    /* 旋转时长 */
    
    // 旋转速度
    animation.duration = 10;
    
    //重复次数,NSIntegerMax为无限旋转
    animation.repeatCount = NSIntegerMax;
    //旋转结束后是否要逆向返回原位置
    animation.autoreverses = NO;
    //是否按照结束位置继续旋转
    animation.cumulative = YES;
    //给view的layer层添加动画,key是标记随便起名字
    [self.myImageView.layer addAnimation:animation forKey:@"basicAnimation"];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.myImageView addGestureRecognizer:tap];
    self.myImageView.userInteractionEnabled = YES;



    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(60, 150, 50, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"IconGood.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.adjustsImageWhenHighlighted = NO;


    UILongPressGestureRecognizer *longPGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.aView addGestureRecognizer:longPGR];

    self.isSelected = NO;
    self.isRotation = NO;

}

//音乐播放旋转动画
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.isRotation == NO) {
        //每一个view的layer层系统都设置了记录时间的属性,通过改变view动画时间来控制动画效果
        
        //获得到当前旋转的时间点  CACurrentMediaTime 返回当前的绝对时间
        
        CFTimeInterval stopTime = [self.myImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        
        //设置播放速度为0,即停止
        self.myImageView.layer.speed = NO;
        //记录当前时间偏移量
        self.myImageView.layer.timeOffset = stopTime;
        
    } else
    {
        //获得上次停止的时间偏移量
        CFTimeInterval stopTime = self.myImageView.layer.timeOffset;
        //设置速度1.0
        self.myImageView.layer.speed = YES;
        //设置偏移量为0
        self.myImageView.layer.timeOffset = 0;
        self.myImageView.layer.beginTime = 0;
        //设置开始时间
        self.myImageView.layer.beginTime = [self.myImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - stopTime;
        
    }
    self.isRotation = !self.isRotation;
    
}







//长按抖动动画
-(void)longPress:(UILongPressGestureRecognizer *)longPress
{

    //旋转 rotation
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    float top = M_PI / 18;
    float bom = -M_PI / 18;
    keyAnimation.values = @[@(top),@(0),@(bom),@(0),@(top)];
    keyAnimation.repeatCount = NSIntegerMax;
    keyAnimation.duration = 0.3;
    [self.aView.layer addAnimation:keyAnimation forKey:@"key"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //停止动画
        [self.aView.layer removeAnimationForKey:@"key"];
    });
    
}

//点赞动画
-(void)buttonAction:(UIButton *)btn
{
    //关键帧动画,改变view缩放属性
    CAKeyframeAnimation *keyAnimtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //设置关键帧的值,values是数组类型
    keyAnimtion.values = @[@(0.1),@(1.0),@(1.5)];
//    NSNumber *num = [NSNumber numberWithFloat:0.1];
//    keyAnimtion.values = [NSArray arrayWithObjects:num, nil];
    keyAnimtion.duration = 0.2;
    [btn.layer addAnimation:keyAnimtion forKey:@"key"];


    if (self.isSelected == NO) {

        [btn setBackgroundImage:[UIImage imageNamed:@"IconHgood.png"] forState:UIControlStateNormal];
    }else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"IconGood.png"] forState:UIControlStateNormal];

    }
    self.isSelected = !self.isSelected;
}




- (IBAction)transFormButton:(UIButton *)sender {
    //transform是view的一个属性,是用来改变view的形态的,通过设置transform属性值可以实现view的形态变化,比如旋转,缩放,移动等
    //Rotate:旋转的意思 M_PI是180度
//    self.aView.transform = CGAffineTransformRotate(self.aView.transform, M_PI_4);

    //每次缩放原来的0.9倍
//    self.aView.transform = CGAffineTransformScale(self.aView.transform, 0.9, 0.9);
    //移动 正数代表往右下方移动  负数代表往左上方移动
//    self.aView.transform = CGAffineTransformTranslate(self.aView.transform, 5, 5);
    

}

- (IBAction)layerButton:(UIButton *)sender {
    //layer层,每个view视图都有一个layer层,是用来设置view上的内容,比如背景颜色,frame,文字等内容.而view只是用来负责显示layer层的.
    //我们可以通过改变layer层的内容来实现一些动画效果





}
@end














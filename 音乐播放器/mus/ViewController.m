//
//  ViewController.m
//  mus
//
//  Created by dllo on 16/1/18.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageForPlayer;
@property (nonatomic, assign) BOOL *isRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self creatImageForPlayer];
  [self createGestureRecognizer];

}

- (void)creatImageForPlayer{

    self.ImageForPlayer.layer.cornerRadius = 120;
    self.ImageForPlayer.layer.masksToBounds = YES;
    self.ImageForPlayer.layer.borderWidth = 3;
    self.ImageForPlayer.layer.borderColor = [UIColor redColor].CGColor;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue= @(M_PI *2);
    
    /* 旋转速度 */
    
    animation.duration = 10;
    animation.repeatCount = NSIntegerMax;//无限旋转
    animation.autoreverses = NO;//是否要逆向返回原位置
    animation.cumulative = YES; //是否按照结束位置继续旋转
    [self.ImageForPlayer.layer addAnimation:animation forKey:@"basicAnimation"];
   
    

}


- (void)createGestureRecognizer{

    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.ImageForPlayer addGestureRecognizer:tap];
    self.ImageForPlayer.userInteractionEnabled = YES;
    

}

- (void)tapAction:(UIGestureRecognizer *) tap{

    
    if (self.isRotation == NO) {
        
        CFTimeInterval stopTime = [self.ImageForPlayer.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.ImageForPlayer.layer.speed = 0;
        self.ImageForPlayer.layer.timeOffset = stopTime;
        
    } else {
        
        CFTimeInterval stopTime = self.ImageForPlayer.layer.timeOffset;
        self.ImageForPlayer.layer.speed = 1.0;
        self.ImageForPlayer.layer.timeOffset = 0;
        self.ImageForPlayer.layer.beginTime = 0;
        
        self.ImageForPlayer.layer.beginTime = [self.ImageForPlayer.layer convertTime:CACurrentMediaTime() fromLayer:nil] - stopTime;

    }
    
    NSLog(@"ddd");
    

}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

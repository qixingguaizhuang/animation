//
//  ViewController.h
//  UI22_动画2
//
//  Created by yutao on 15/11/9.
//  Copyright © 2015年 yutao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

- (IBAction)transFormButton:(UIButton *)sender;
- (IBAction)layerButton:(UIButton *)sender;

@end


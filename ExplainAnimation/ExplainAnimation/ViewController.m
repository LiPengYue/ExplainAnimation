//
//  ViewController.m
//  ExplainAnimation
//
//  Created by 李鹏跃 on 17/1/18.
//  Copyright © 2017年 13lipengyue. All rights reserved.
//

#import "ViewController.h"
#import "PropertyAnimation.h"
#import "CKShimmerLabel.h"
@interface ViewController () <CAAnimationDelegate>
@property (nonatomic,strong)CALayer *imageLayer;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
 [super viewDidLoad];
    PropertyAnimation *propertyAnimation = [[PropertyAnimation alloc]initPropertyAnimation];
    propertyAnimation.frame = self.view.bounds;
    [self.view addSubview:propertyAnimation];
  
    [propertyAnimation animation];
    
    
    //----------------新年快乐
    CKShimmerLabel *shimmerLabel = [[CKShimmerLabel alloc]init];
    shimmerLabel.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 250,100,25);
    shimmerLabel.text = @"新年快乐~";
    shimmerLabel.font = [UIFont fontWithName:@"新年好" size:20];
    shimmerLabel.shimmerColor = [UIColor redColor];
    [shimmerLabel startShimmer];
    [self.view addSubview:shimmerLabel];
    

    
}
//完成动画的回调
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  //  if ([self.view.layer animationForKey:@"animation"] == anim) {
    //    [self.view removeFromSuperview];
    //}
//}

@end;

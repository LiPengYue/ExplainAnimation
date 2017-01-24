//
//  PropertyAnimation.m
//  ExplainAnimation
//
//  Created by 李鹏跃 on 17/1/18.
//  Copyright © 2017年 13lipengyue. All rights reserved.
//

#import "PropertyAnimation.h"
@interface PropertyAnimation ()
@property (nonatomic,strong) UIImageView *imageView;
@end
@implementation PropertyAnimation

- (instancetype)initPropertyAnimation {
    PropertyAnimation *propertyAnimation = [[PropertyAnimation alloc]init];
    
    return propertyAnimation;
}

- (void)animation {
    // 创建一个CALayer对象
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
    self.imageView.frame =CGRectMake(30,30, 100, 135);
    [self addSubview:_imageView];
    
    //设置该CALayer的边框、大小、位置等属性
    self.imageView.layer.cornerRadius =6;
    self.imageView.layer.borderWidth =1;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.masksToBounds =YES;
    
    // 设置该imageLayer显示的图片
    //_imageLayer.contents = (id)[[UIImage imageNamed:@"2"]CGImage];
    
    NSArray* bnTitleArray = [NSArray arrayWithObjects:@"平移", @"旋转" ,@"缩放" ,@"动画组" ,nil];
    //获取屏幕的内部高度
    CGFloat totalHeight = [UIScreen mainScreen].bounds.size.height;
    NSMutableArray* bnArray = [[NSMutableArray alloc] init];
    //采用循环创建4个按钮
    for(int i =0 ; i < 4 ; i++){
        UIButton* bn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        bn.frame =CGRectMake(5 + i *80, totalHeight - 45 - 20 , 70 ,35);
        [bn setTitle:[bnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [bnArray addObject:bn];
        [self addSubview:bn];
    }
    //为4个按钮绑定不同的事件处理方法
    [[bnArray objectAtIndex:0]addTarget:self action:@selector(move:)forControlEvents:UIControlEventTouchUpInside];
    [[bnArray objectAtIndex:1]addTarget:self action:@selector(rotate:)forControlEvents:UIControlEventTouchUpInside];
    [[bnArray objectAtIndex:2]addTarget:self action:@selector(scale:)forControlEvents:UIControlEventTouchUpInside];
    [[bnArray objectAtIndex:3]addTarget:self action:@selector(group:)forControlEvents:UIControlEventTouchUpInside];
}


-(void) move:(id)sender
{
    CGPoint fromPoint = _imageView.layer.position;
    CGPoint toPoint =CGPointMake(fromPoint.x +80 , fromPoint.y);
    // 创建不断改变CALayer的position属性的属性动画
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"position"];
    //设置动画开始的属性值
    anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    //设置动画结束的属性值
    anim.toValue = [NSValue valueWithCGPoint:toPoint];
    anim.duration =0.5;
    _imageView.layer.position = toPoint;//设置移动后图片的位置。
    anim.removedOnCompletion =YES;
    // 为imageLayer添加动画
    [ _imageView.layer addAnimation:anim forKey:nil];
}
-(void) rotate:(id)sender
{
    // 创建不断改变CALayer的transform属性的属性动画
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = _imageView.layer.transform;
    //设置动画开始的属性值
    anim.fromValue = [NSValue valueWithCATransform3D:fromValue];
    // 绕X轴旋转180度
    CATransform3D toValue =CATransform3DRotate(fromValue, M_PI , 1 , 0 , 0);
    // 绕Y轴旋转180度
    // CATransform3D toValue = CATransform3DRotate(fromValue, M_PI , 0 , 1 , 0);
    // // 绕Z轴旋转180度
    // CATransform3D toValue = CATransform3DRotate(fromValue, M_PI , 0 , 0 , 1);
    //设置动画结束的属性值
    anim.toValue = [NSValue valueWithCATransform3D:toValue];
    anim.duration =0.5;
    _imageView.layer.transform = toValue;
    anim.removedOnCompletion =YES;
    // 为imageLayer添加动画
    [ _imageView.layer addAnimation:anim forKey:nil];
}
-(void) scale:(id)sender
{
    // 创建不断改变CALayer的transform属性的属性动画
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    // 设置CAKeyframeAnimation控制transform属性依次经过的属性值
    anim.values = [NSArray arrayWithObjects:
                   [NSValue valueWithCATransform3D: _imageView.layer.transform],
                   [NSValue valueWithCATransform3D:CATransform3DScale(_imageView.layer.transform ,0.2, 0.2, 1)],
                   [NSValue valueWithCATransform3D:CATransform3DScale(_imageView.layer.transform,2, 2 , 1)],
                   [NSValue valueWithCATransform3D:_imageView.layer.transform],nil];
    anim.duration =5;
    anim.removedOnCompletion =YES;
    // 为imageLayer添加动画
    [_imageView.layer addAnimation:anim forKey:nil];
}
-(void) group:(id)sender
{
    CGPoint fromPoint =_imageView.layer.position;
    CGPoint toPoint =CGPointMake(280 , fromPoint.y +300);
    // 创建不断改变CALayer的position属性的属性动画
    CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    //设置动画开始的属性值
    moveAnim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    //设置动画结束的属性值
    moveAnim.toValue = [NSValue valueWithCGPoint:toPoint];
    moveAnim.removedOnCompletion =YES;
    // 创建不断改变CALayer的transform属性的属性动画
    CABasicAnimation* transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue =_imageView.layer.transform;
    //设置动画开始的属性值
    transformAnim.fromValue = [NSValue valueWithCATransform3D: fromValue];
    //创建缩放为X、Y两个方向上缩放为0.5的变换矩阵
    CATransform3D scaleValue =CATransform3DScale(fromValue , 0.5 , 0.5, 1);
    //绕X,Y,Z轴旋转180度的变换矩阵
    CATransform3D rotateValue =CATransform3DRotate(fromValue, M_PI , 1 , 1 , 1);
    //计算两个变换矩阵的和
    CATransform3D toValue =CATransform3DConcat(scaleValue, rotateValue);
    //设置动画技术的属性值
    transformAnim.toValue = [NSValue valueWithCATransform3D:toValue];
    //动画效果累加
    transformAnim.cumulative =YES;
    //动画重复执行2次，旋转360度
    transformAnim.repeatCount =2;
    transformAnim.duration =3;
    //位移、缩放、旋转组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, transformAnim ,nil];
    animGroup.duration =6;
    // 为imageLayer添加动画
    [_imageView.layer addAnimation:animGroup forKey:nil];
}


- (void)drawRect:(CGRect)rect {
    
//1.获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建色彩空间
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    //3.创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, (CGFloat[]) {
        1.0f,0.8f,0.5f,1.0f,//第一个颜色RGB 和透明度
        0.6f,0.5f,0.6f,1.0f,//第二个颜色RGB 和透明度
        0.3f,0.2f,0.f,1.0f,//第三个颜色RGB 和透明度
        .0f,0.0f,0.3f,1.0f
    }, (CGFloat []) {
        0.0f,0.3f,.6f,1//四个颜色的比例
    }, 4);//颜色的个数
    
    //释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    //绘制
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(rect.size.width,rect.size.height), 0);
    
    //释放变色对象
    CGGradientRelease(gradientRef);
}



@end

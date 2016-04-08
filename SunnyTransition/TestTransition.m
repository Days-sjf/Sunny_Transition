//
//  TestTransition.m
//  SunnyTransition
//
//  Created by slyao on 16/4/7.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import "TestTransition.h"

@interface TestTransition()

@property(nonatomic, strong)UIView *toView;
@property(nonatomic, strong)UIView *fromView;
@property(nonatomic, assign)CGPoint originCenter;
@property(nonatomic, strong)id<UIViewControllerContextTransitioning> context;

@end

@implementation TestTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    self.context = transitionContext;
    
    self.toView = [self toView:transitionContext];
    self.fromView = [self fromView:transitionContext];

    if (self.transitionType == TransitionTypePush) {
        self.originCenter = self.fromView.center;
        CGPoint toCenter = self.fromView.center;
        self.toView.center = CGPointMake(Sunny_ScreenWidth+Sunny_ScreenWidth/2,  0);
        
        [containerView addSubview:self.toView];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D scale1 = CATransform3DMakeScale(0.0, 0.0, 1);
        CATransform3D scale2 = CATransform3DMakeScale(1, 1, 1);
        
        NSArray *frameValues = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:scale1],
                                [NSValue valueWithCATransform3D:scale2],
                                
                                nil];
        [animation setValues:frameValues];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAKeyframeAnimation *pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:self.toView.center];
        [path addQuadCurveToPoint:toCenter controlPoint:self.toView.center];
        pathAnim.path = path.CGPath;
        
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        rotation.toValue = [NSNumber numberWithFloat:12 * M_PI]; // 终止角度
        rotation.cumulative = NO;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[animation,rotation,pathAnim];
        group.duration = self.duration;
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.repeatCount = 1;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.toView.layer addAnimation:group forKey:@"pushAnimation"];
        
    }else if (self.transitionType == TransitionTypePop){
        CGPoint startPoint = self.fromView.center;
        self.originCenter = self.fromView.center;
        CGPoint toCenter = CGPointMake(-Sunny_ScreenWidth/2, 0);
        
        [containerView insertSubview:self.toView belowSubview:self.fromView];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D scale1 = CATransform3DMakeScale(1, 1, 1);
        CATransform3D scale2 = CATransform3DMakeScale(0.1, 0.1, 1);
        
        NSArray *frameValues = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:scale1],
                                [NSValue valueWithCATransform3D:scale2],
                                
                                nil];
        [animation setValues:frameValues];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAKeyframeAnimation *pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:startPoint];
        [path addQuadCurveToPoint:toCenter controlPoint:startPoint];
        pathAnim.path = path.CGPath;
        
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        rotation.toValue = [NSNumber numberWithFloat:12 * M_PI]; // 终止角度
        rotation.cumulative = NO;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[animation,rotation,pathAnim];
        group.duration = self.duration;
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.repeatCount = 1;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.fromView.layer addAnimation:group forKey:@"popAnimation"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.toView.layer.animationKeys containsObject:@"pushAnimation"]) {
        [self.toView.layer removeAllAnimations];
        self.toView.center = self.originCenter;
        [self.context completeTransition:![self.context transitionWasCancelled]];
    }else{
        [self.fromView.layer removeAllAnimations];
        self.fromView.center = CGPointMake(-Sunny_ScreenWidth/2, 0);
        [self.context completeTransition:![self.context transitionWasCancelled]];
    }
}

@end

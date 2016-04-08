//
//  SunnyBaseTransition.m
//  SunnyTransition
//
//  Created by slyao on 16/4/7.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import "SunnyBaseTransition.h"

@implementation SunnyBaseTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 0.5;
    }
    return self;
}

#pragma mark-  UIViewControllerAnimatedTransitioning
/**
 @brief 动画执行时间
 
 @param transitionContext 转场动画上下文
 
 @return 时间
 
 @since 0
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

/**
 @brief 子类实现
 
 @return void
 
 @since 0
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //TODO 用来实现转场动画  子类实现
}

#pragma mark- UINavigationControllerDelegate

/**
 @brief pop和push的转场动画使用导航栏的代理
 
 @param id<UIViewControllerAnimatedTransitioning> 跳转动画
 
 @return 实现转场动画协议的对象
 
 @since 0
 */
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        self.transitionType = TransitionTypePush;
    }else if(operation == UINavigationControllerOperationPop){
        self.transitionType = TransitionTypePop;
    }
    return self;
}

#pragma mark- UIViewControllerTransitioningDelegate
/**
 @brief present转场动画使用UIViewControllerTransitioningDelegate
 
 @param presented 执行转场动画的vc
 @param presenting 被执行转场动画的vc
 @param source     
 
 @return 实现转场动画协议的对象
 
 @since 0
 */
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transitionType = TransitionTypePresent;
    return self;
}

/**
 @brief dismiss转场动画
 
 @param dismissed  执行转场动画的vc
 
 @return 实现转场动画协议的对象
 
 @since 0
 */

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transitionType = TransitionTypeDismiss;
    return self;
}

/**
 @brief 获取目标vc的view
 
 @param transitionContext 转场动画上下文
 
 @return 需要展示的view
 
 @since 0
 */
- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = nil;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        toView = toVC.view;
    }
    
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    
    return toView;
}

/**
 @brief 获取当前view
 
 @param transitionContext 转场动画上下文
 
 @return 当前view
 
 @since --
 */
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = nil;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    } else {
        fromView = fromVC.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    
    return fromView;
}

@end

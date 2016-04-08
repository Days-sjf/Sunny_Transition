//
//  TestModelTransition.m
//  SunnyTransition
//
//  Created by slyao on 16/4/8.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import "TestModelTransition.h"

@implementation TestModelTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = [self toView:transitionContext];
    UIView *fromView = [self fromView:transitionContext];
    
    if(self.transitionType == TransitionTypePresent){
        [containerView addSubview:toView];
        toView.frame = CGRectMake(0, Sunny_ScreenHeight, Sunny_ScreenWidth, Sunny_ScreenHeight);
        toView.alpha = 0.0f;
        toView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        [UIView animateWithDuration:0.5 animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            fromView.alpha = 0.0f;
            toView.alpha = 1.0f;
            toView.transform = CGAffineTransformIdentity;
            toView.frame = CGRectMake(0, 0, Sunny_ScreenWidth, Sunny_ScreenHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if(self.transitionType == TransitionTypeDismiss){
        [containerView addSubview:toView];
        toView.frame = CGRectMake(0, Sunny_ScreenHeight, Sunny_ScreenWidth, Sunny_ScreenHeight);
        fromView.alpha = 1.0f;
        toView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        toView.alpha = 0.0f;
        
        [UIView animateWithDuration:0.5 animations:^{
            fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            fromView.alpha = 0.0f;
            toView.transform = CGAffineTransformIdentity;
            toView.alpha = 1.0f;
            toView.frame = CGRectMake(0, 0, Sunny_ScreenWidth, Sunny_ScreenHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end

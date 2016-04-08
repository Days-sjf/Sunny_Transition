//
//  SunnyBaseTransition.h
//  SunnyTransition
//
//  Created by slyao on 16/4/7.
//  Copyright © 2016年 slyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Sunny_ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define Sunny_ScreenHeight   [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, TransitionType){
    TransitionTypeNone,
    TransitionTypePush,
    TransitionTypePop,
    TransitionTypePresent,
    TransitionTypeDismiss,
};

@class SunnyBaseTransition;

typedef void(^TransitionCompleteBlock)(UIViewController *fromViewController, UIViewController *toViewController,SunnyBaseTransition *transition);

@interface SunnyBaseTransition : NSObject<UIViewControllerAnimatedTransitioning,
UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@property (assign, nonatomic)NSTimeInterval duration;
@property (assign, nonatomic)TransitionType transitionType;
@property (copy, nonatomic)TransitionCompleteBlock completeBlock;

- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext ;
- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext ;

@end

//
//  LeafMenuViewController.m
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "LeafMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#define OPENDISTANCE 280.0f
#define OPENSWITCH 160.0f
#define ANIMATIONDURATION 0.3f //动画时间
#define SPRINGBOUNCINESS 15
#define SPRINGSPEED 15

@interface LeafMenuViewController ()
@property (nonatomic,assign,getter = isOpened) BOOL opened;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIViewController *currentVC;
@end

static LeafMenuViewController *_menu = nil;

@implementation LeafMenuViewController
+(instancetype)shareInstance{
    return _menu;
}
-(void)prepare{
    _menu = self;
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.opened = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [self.contentView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    tap.delegate = self;
    [tap setDelaysTouchesEnded:YES];
    [self.contentView addGestureRecognizer:tap];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self prepare];
    }
    return self;
}
- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        [self prepare];
    }
    return self;
}
-(void)setShadow:(BOOL)shadow{
    _shadow = shadow;
    if(shadow){
        self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
        [self.contentView.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.contentView.layer setShadowOpacity:0.3];
    }else{
        [self.contentView.layer setShadowOpacity:0];
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if(self.isOpened){
        return NO;
    }
    return YES;
}
-(void)tapHandle:(UITapGestureRecognizer *)tap{
    if(!self.isOpened){
        [self openWithAnimation:YES];
    }
    
}
-(void)panHandle:(UIPanGestureRecognizer *)pan{
    CGFloat translationX = [pan translationInView:self.view].x;
    if(translationX+pan.view.frame.origin.x>0){
        if(pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged){
            
            pan.view.center = CGPointMake(pan.view.center.x+translationX, pan.view.center.y);
            [pan setTranslation:CGPointZero inView:self.view];
        }else if(pan.state == UIGestureRecognizerStateFailed || pan.state == UIGestureRecognizerStateEnded){
            if(pan.view.frame.origin.x<OPENSWITCH){
                [self openWithAnimation:YES];//就是内容全部展现
            }else{
                [self closeWithAnimation:YES];//就是内容移到侧边
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma custom method
-(instancetype)initWithLeftVC:(UIViewController *)leftVC centerVCs:(NSArray *)centerVCs{
    if([self init]){
        self.leftVC = leftVC;
        self.viewControllers = centerVCs;
        //
        [self.view addSubview:self.leftVC.view];
        [self.view addSubview:self.contentView];
        
        [self setViewControllers:centerVCs];
        
        //默认显示第一个
        self.currentVC = (UIViewController *)centerVCs.firstObject;
        [self.contentView addSubview:self.currentVC.view];
        [self addChildViewController:self.currentVC];

       
    }
    return self;
}
//-(void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion{
//    LOGCMD;
//}
/**
 *  内容移到侧边
 *
 *  @param animated
 */
-(void)closeWithAnimation:(BOOL)animated{
    if(animated){
        if(self.isSpringAnimation){
            
            POPSpringAnimation *anim = [self.contentView.layer pop_animationForKey:@"springclose"];
            if(!anim){
                anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                anim.springBounciness = SPRINGBOUNCINESS;
                anim.springSpeed = SPRINGSPEED;
                [self.contentView.layer pop_addAnimation:anim forKey:@"springclose"];
            }
            anim.toValue = @(self.view.bounds.size.width/2+OPENDISTANCE);
            self.opened = NO;
            
            
        }else{
            CGFloat duration = ANIMATIONDURATION * (OPENDISTANCE - self.contentView.frame.origin.x)  / self.view.bounds.size.width;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.contentView.frame;
                frame.origin.x = OPENDISTANCE;
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                self.opened = NO;
            }];
        }
    }else{
        CGRect frame = self.contentView.frame;
        frame.origin.x = OPENDISTANCE;
        self.contentView.frame = frame;
        self.opened = NO;
    }
}
/**
 *  内容全部展现
 *
 *  @param animated
 */
-(void)openWithAnimation:(BOOL)animated{
    if(animated){
        if(self.isSpringAnimation){
            POPSpringAnimation *anim = [self.contentView.layer pop_animationForKey:@"springopen"];
            if(!anim){
                anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
                anim.springBounciness = SPRINGBOUNCINESS;
                anim.springSpeed = SPRINGSPEED;
                [anim setCompletionBlock:^(POPAnimation *pop, BOOL finished) {
                    NSLog(@"90000909");
                    self.opened = YES;
                }];
                [self.contentView.layer pop_addAnimation:anim forKey:@"springopen"];
            }
           
            anim.toValue = @(self.view.bounds.size.width/2);
            
            
        }else{
            CGFloat duration = ANIMATIONDURATION * (self.contentView.frame.origin.x)  / self.view.bounds.size.width;
            [UIView animateWithDuration:duration animations:^{
                CGRect frame = self.contentView.frame;
                frame.origin.x = 0;
                self.contentView.frame = frame;
            } completion:^(BOOL finished) {
                self.opened = YES;
            }];
        }
    }else{
        CGRect frame = self.contentView.frame;
        frame.origin.x = 0;
        self.contentView.frame = frame;
        self.opened = YES;
    }

}
-(void)openAtIndex:(NSInteger)index animated:(BOOL)animated{
    if(index<self.viewControllers.count){
        UIViewController *newVC = self.viewControllers[index];
        if(newVC!=self.currentVC){
            [self addChildViewController:newVC];
            [self.currentVC willMoveToParentViewController:nil];
            
            [self transitionFromViewController:self.currentVC toViewController:newVC duration:0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:^(BOOL finished) {
                [newVC didMoveToParentViewController:self];
                [self.currentVC removeFromParentViewController];//不用再调用didMoveTo nil
                
                self.currentVC = newVC;
                [self openWithAnimation:animated];
            }];
          
        }else{
            [self openWithAnimation:animated];
        }
        
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

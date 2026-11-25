#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSInteger const kCCGlassBlurViewTag = 0xCCB10;

%group CCGlassBlurOverlay

%hook CCUIModularControlCenterOverlayViewController

- (void)viewDidLayoutSubviews {
    %orig;

    UIViewController *overlayController = (UIViewController *)self;
    UIView *rootView = overlayController.view;
    if (!rootView) return;

    UIView *existing = [rootView viewWithTag:kCCGlassBlurViewTag];
    UIVisualEffectView *blurView = nil;

    if ([existing isKindOfClass:[UIVisualEffectView class]]) {
        blurView = (UIVisualEffectView *)existing;
    } else {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
        blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        blurView.tag = kCCGlassBlurViewTag;
        blurView.userInteractionEnabled = NO;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [rootView insertSubview:blurView atIndex:0];
    }

    blurView.frame = rootView.bounds;
    [rootView sendSubviewToBack:blurView];
}

%end

%end

%ctor {
    @autoreleasepool {
        Class overlayClass = NSClassFromString(@"CCUIModularControlCenterOverlayViewController");
        if (overlayClass && class_getInstanceMethod(overlayClass, @selector(viewDidLayoutSubviews))) {
            %init(CCGlassBlurOverlay);
        }
    }
}


//
//  WXShotModule.m
//  AFNetworking
//
//  Created by 郑江荣 on 2019/2/15.
//

#import "WXShotModule.h"
#import "Weex.h"
#import "farwolf.h"
#import "farwolf_weex.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
@implementation WXShotModule
WX_PlUGIN_EXPORT_MODULE(shot, WXShotModule)
@synthesize weexInstance;
WX_EXPORT_METHOD(@selector(shot:callback:))
-(void)shot:(NSString*)ref  callback:(WXModuleCallback)callback{
    [Weex findComponent:ref instance:weexInstance block:^(WXComponent *comp) {
         UIImage *img=  [comp.view toImage];
         NSString *path= [img saveToDisk:@"shot.png"];
         path=[PREFIX_SDCARD add:path];
         callback(@{@"path":path});
    }];
}
- (UIImage *)snapsHotView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,[UIScreen mainScreen].scale);
    [[UIApplication sharedApplication].keyWindow  drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

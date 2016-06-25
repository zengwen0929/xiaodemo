//
//  XHLaunchAd.h

//  Copyright (c) 2016 XHLaunchAd (https://github.com/CoderZhuXH/XHLaunchAd)

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIImageView+XHWebCache.h"

typedef void(^XHLaunchAdClickBlock)();

@interface XHLaunchAd : UIView

/**
 *  广告点击事件回调
 */
@property(nonatomic,copy)XHLaunchAdClickBlock clickBlock;

/**
 *  广告frame
 */
@property (nonatomic, assign) CGRect adFrame;

/**
 *  初始化启动页广告
 *
 *  @param frame    广告frame
 *  @param duration 广告停留时间
 *
 *  @return 启动页广告
 */
- (instancetype)initWithFrame:(CGRect)frame andDuration:(CGFloat)duration;

/**
 *  设置广告图片urlString
 *
 *  @param imgUrlString   图片urlString
 *  @param completedBlock 异步加载图片完成回调
 */
-(void)imgUrlString:(NSString *)imgUrlString completed:(XHWebImageCompletionBlock)completedBlock;

/**
 *  清除图片本地缓存
 */
+(void)clearDiskCache;

/**
 *  获取缓存图片占用总大小
 */
+ (unsigned long long)imagesCacheSize;

@end

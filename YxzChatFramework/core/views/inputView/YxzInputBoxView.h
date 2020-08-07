//
//  YxzInputBoxView.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYTextView.h>
#import "YxzFaceItem.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YxzInputStatus) {
    YxzInputStatus_nothing=0,//正常状态 默认 进入界面状态没有输入聚焦没有弹出键盘、没有打开选择表情、没有选择跟多
    YxzInputStatus_keyborad,//弹出键盘状态
    YxzInputStatus_showFace,//展示 表情选择界面
    YxzInputStatus_showMore,//展示更多，里面可能有选择图片 选择视频等。
    YxzInputStatus_voice//后续可能支持语音新增预留
};
@class YxzInputBoxView;
@protocol YxzInputViewDelegate <NSObject>

-(void)inputBoxStatusChange:(YxzInputBoxView *)boxView changeFromStatus:(YxzInputStatus)fromStatus toStatus:(YxzInputStatus)toStatus changeHight:(CGFloat)hight;

/// 文字输入时 输入框高度变化
/// @param boxView 输入框容器
/// @param inputHight 输入框高度 0 为变回变回前高度
@optional
-(void)inputBoxHightChange:(YxzInputBoxView *)boxView inputViewHight:(CGFloat)inputHight;

-(void)sendText:(NSString *)msgText faceImage:(NSString *)faceImageUrlStr;
@optional
-(void)clientInputing:(BOOL)inputing;
@end

@interface YxzInputBoxView : UIView

@property(nonatomic,weak)id<YxzInputViewDelegate> delegate;
@property(nonatomic,assign)YxzInputStatus inputStatus;
@property(nonatomic,strong)UITextField *textView;
-(void)setFaceList:(NSArray<YxzFaceItem *> *)faceList;
-(void)clickFace;
-(void)clickTextField;
-(void)hiddenInput;
-(void)hiddenFace;
@end

NS_ASSUME_NONNULL_END

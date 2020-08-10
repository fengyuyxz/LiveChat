//
//  YxzChatCompleteComponent.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YxzFaceItem.h"
#import "YxzInputBoxView.h"
#import "RongCloudTokenResult.h"
@protocol ChateCompletionDelegate <NSObject>

-(void)showKeyBorad:(BOOL)isShow;

@end


@interface YxzChatCompleteComponent : UIView
@property(nonatomic,assign)int btn_type;//发送按钮样式，1星星，2海豚
@property(nonatomic,assign,readonly)YxzInputStatus inputStatus;
@property(nonatomic,assign)id<ChateCompletionDelegate> delegate;
@property(nonatomic,assign)BOOL isFull;
typedef void(^HiddenKeyboardAndFaceViewCompletion)(void);
-(void)hiddenTheKeyboardAndFace:(HiddenKeyboardAndFaceViewCompletion)block;

-(void)setFaceList:(NSArray<YxzFaceItem *> *)faceList;

/// 加入聊天室
/// @param model token model
-(void)joinRoom:(ChatRoomUserInfoAndTokenModel *)model userToken:(NSString *)userToken liveId:(NSString *)liveId;
@end



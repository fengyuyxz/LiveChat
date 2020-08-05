//
//  YxzChatCompleteComponent.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/23.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChateCompletionDelegate <NSObject>

-(void)showKeyBorad:(BOOL)isShow;

@end


@interface YxzChatCompleteComponent : UIView

@property(nonatomic,assign)id<ChateCompletionDelegate> delegate;
@property(nonatomic,assign)BOOL isFull;
typedef void(^HiddenKeyboardAndFaceViewCompletion)(void);
-(void)hiddenTheKeyboardAndFace:(HiddenKeyboardAndFaceViewCompletion)block;
@end



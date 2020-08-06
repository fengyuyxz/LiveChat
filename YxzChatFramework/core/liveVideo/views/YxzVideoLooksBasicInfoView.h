//
//  YxzVideoLooksBasicInoView.h
//  YxzChatFramework
//  该类为视频观看基本信息 如观看人数、点赞书、收藏等数据
//  Created by 颜学宙 on 2020/7/26.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YxzVideoLooksBasicInfoView : UIView
-(void)roomTitle:(NSString *)roomTitle viewNum:(NSString *)viewNum zanNum:(NSString *)zanNum commentNum:(NSString *)commentNum;
@end

NS_ASSUME_NONNULL_END

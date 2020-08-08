//
//  VoteItemModelResult.h
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/8/8.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface VoteItemModel : NSObject
@property(nonatomic,assign)int voteId;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)int percent;
@end


@interface VoteItemModelResult : NSObject
@property(nonatomic,copy)NSString *voteId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *roomid;
@property(nonatomic,strong)NSArray<VoteItemModel *> *items;



@end

@interface VoteNetResult : NSObject
@property(nonatomic,assign)int code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)VoteItemModelResult *data;
@end

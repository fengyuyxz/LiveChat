//
//  FirstVC.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/27.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "FirstVC.h"
#import "RoomBaseInfo.h"
#import "YxzChatController.h"
//#import "LiveRoomViewController.h"
@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    // Do any additional setup after loading the view.
}
- (IBAction)pushRoom:(id)sender {
    
    RoomPlayUrlModel *pM=[[RoomPlayUrlModel alloc]init];
    pM.title=@"高清";
    pM.playUrl=@"http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f30.mp4";
    RoomPlayUrlModel *pM2=[[RoomPlayUrlModel alloc]init];
    pM2.title=@"标清";
    pM2.playUrl=@"http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f20.mp4";
    RoomPlayUrlModel *pM3=[[RoomPlayUrlModel alloc]init];
    pM3.title=@"流畅";
    pM3.playUrl=@"http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4";
    
    
    
    RoomBaseInfo *info=[[RoomBaseInfo alloc]init];
//    info.payLiveUrl=@"rtmp://3891.liveplay.myqcloud.com/live/3891_user_0f8c29be_1da0";
    info.payLiveUrl=@"http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f30.mp4";
    info.playList=@[pM,pM2,pM3];
    YxzChatController *vc=[[YxzChatController alloc]init];
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    vc.roomBaseInfo=info;
//    LiveRoomViewController *vc=[[LiveRoomViewController alloc]init];
//    vc.modalPresentationStyle=UIModalPresentationFullScreen;
//    vc.roomBaseInfo=info;
//    
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

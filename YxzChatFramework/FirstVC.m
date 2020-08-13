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
#import "YxzLevelManager.h"
#import "HttpHostManager.h"
//#import "LiveRoomViewController.h"
@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor greenColor];
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 40, 20)];
    view.image=[[YxzLevelManager sharedInstance]imageForLevel:1];
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}
- (IBAction)pushRoom:(id)sender {
    
    [HttpHostManager shareInstance].host=@"http://www.pts.ifanteam.com";
    YxzChatController *vc=[[YxzChatController alloc]init];
    vc.modalPresentationStyle=UIModalPresentationFullScreen;
    vc.liveId=@"93";
//    vc.token=@"32339c97-ff67-4421-93f8-47222d6f8596";
    vc.token=@"a62e9c8c-c904-49e1-96df-3e389b04c44d";
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

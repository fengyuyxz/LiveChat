//
//  YxzChatListTableView.m
//  YXZChatFramework
//
//  Created by 颜学宙 on 2020/7/22.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "YxzChatListTableView.h"
#import <Masonry/Masonry.h>
#import "YxzChatBaseCell.h"
#import <pthread/pthread.h>
#import "UIView+Frame.h"
#import <Masonry/Masonry.h>
#import "YxzAdjustPositionButton.h"

// 最小刷新时间间隔
#define reloadTimeSpan 0.5

#define RoomMsgScroViewTag      1002


@interface YxzListViewInputView()
@property(nonatomic,strong)UIButton *faceBut;
@property(nonatomic,strong)UIButton *inputBut;
@property(nonatomic,strong)UILabel *inputTextLabel;
@property(nonatomic,strong)UIView *containerView;
@end
@implementation YxzListViewInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.userInteractionEnabled=YES;
    self.backgroundColor=[UIColor clearColor];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.faceBut];
    [self.containerView addSubview:self.inputTextLabel];
    [self.containerView addSubview:self.inputBut];
    [self layoutSubViewConstraint];
}
-(void)layoutSubViewConstraint{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.right.equalTo(self.mas_right);
    }];
    [self.faceBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView.mas_centerY);
        make.left.equalTo(self.containerView.mas_left).offset(10);
        make.width.height.equalTo(@(25));
    }];
    [self.inputTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView.mas_centerY);
        make.left.equalTo(self.faceBut.mas_right).offset(10);
    }];
    [self.inputBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.faceBut.mas_right).offset(10);
        make.top.equalTo(self.containerView.mas_top);
        make.bottom.equalTo(self.containerView.mas_bottom);
        make.right.equalTo(self.containerView.mas_right);
    }];
}
-(void)faceButPressed:(UIButton *)b{
    if ([self.delegate respondsToSelector:@selector(faceClick)]) {
        [self.delegate faceClick];
    }
}
-(void)inputbutTap:(UIButton *)but{
    if ([self.delegate respondsToSelector:@selector(inputClick)]) {
        [self.delegate inputClick];
    }
     
}
-(UIView *)containerView{
    if(!_containerView){
        _containerView=[[UIView alloc]init];
        _containerView.backgroundColor=RGBA_OF(0x34343B);
        _containerView.layer.cornerRadius=4;
    }
    return _containerView;
}
-(UILabel *)inputTextLabel{
    if (!_inputTextLabel) {
        _inputTextLabel=[[UILabel alloc]init];
        _inputTextLabel.font=[UIFont systemFontOfSize:12];
        _inputTextLabel.textAlignment=NSTextAlignmentLeft;
        _inputTextLabel.textColor=RGBA_OF(0x9a9a9d);
        _inputTextLabel.text=@"请进行对话";
    }
    return _inputTextLabel;;
}
-(UIButton *)inputBut{
    if (!_inputBut) {
           _inputBut=[UIButton buttonWithType:UIButtonTypeCustom];
           
           
           [_inputBut addTarget:self action:@selector(inputbutTap:) forControlEvents:UIControlEventTouchUpInside];
       }
       return _inputBut;
}
-(UIButton *)faceBut{
    if (!_faceBut) {
        _faceBut=[UIButton buttonWithType:UIButtonTypeCustom];
        [_faceBut setBackgroundImage:YxzSuperPlayerImage(@"faceTool") forState:UIControlStateNormal];
        _faceBut.imageEdgeInsets=UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
        [_faceBut addTarget:self action:@selector(faceButPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceBut;
}
@end




@interface YxzChatListTableView()<UITableViewDelegate, UITableViewDataSource,MsgCellGesDelegate>{
    pthread_mutex_t _mutex; // 互斥锁
    /** 正在滚动(滚动时禁止执行插入动画) */
    BOOL _inAnimation;
    CGFloat _AllHeight;
}
/** 消息数组(数据源) */
@property (nonatomic, strong) NSMutableArray<YXZMessageModel *> *msgArray;
/** 用于存储消息还未刷新到tableView的时候接收到的消息 */
@property (nonatomic, strong) NSMutableArray<YXZMessageModel *> *tempMsgArray;
/** 是否处于爬楼状态 */
@property (nonatomic, assign) BOOL inPending;
/** 刷新定时器 */
@property (nonatomic, strong) NSTimer *refreshTimer;

/** 底部更多未读按钮 */
@property (nonatomic, strong) YxzAdjustPositionButton *moreButton;

@property(nonatomic,strong)UITapGestureRecognizer *tapRecognizer;
@end
@implementation YxzChatListTableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self reset];
}
-(void)setupUI{
    self.userInteractionEnabled=YES;
    //_mutex = PTHREAD_MUTEX_INITIALIZER;
           pthread_mutex_init(&_mutex, NULL);
           _AllHeight = 15;
           
           
           [self startTimer];
    self.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    [self addSubview:self.listInputView];
    [self addSubview:self.moreButton];
    [self.listInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(49));
        make.width.mas_equalTo(219);
//        make.right.equalTo(self.mas_right);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.listInputView.mas_top);
        
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_bottom);
        make.left.mas_equalTo(0);
        if (self.moreButton.layoutStyle==AdjustPositionButtonStyleLeftTitleRightImage||self.moreButton.layoutStyle==AdjustPositionButtonStyleLeftImageRightTitle) {
            make.height.mas_equalTo(25);
        }else{
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(60);
        }
        
    }];
    if (self.moreButton.layoutStyle==AdjustPositionButtonStyleLeftTitleRightImage||self.moreButton.layoutStyle==AdjustPositionButtonStyleLeftImageRightTitle) {
         YxzViewRadius(self.moreButton, 25/2);
    }else{
        YxzViewRadius(self.moreButton, 20);
    }
    self.tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:self.tapRecognizer];
    [self.tableView  addGestureRecognizer:self.tapRecognizer];
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.tableView.frame=self.bounds;
    
}
-(void)tapClick{
    if ([self.delegate respondsToSelector:@selector(tapBackgroundView)]) {
        [self.delegate tapBackgroundView];
    }
}

#pragma mark - 消息追加
- (void)addNewMsg:(YXZMessageModel *)msgModel {
    if (!msgModel) return;
    
    pthread_mutex_lock(&_mutex);
    // 消息不直接加入到数据源
    [self.tempMsgArray addObject:msgModel];
    pthread_mutex_unlock(&_mutex);
    
    if (_reloadType == YxzReloadLiveMsgRoom_Direct) {
        [self tryToappendAndScrollToBottom];
    }
}
/** 添加数据并滚动到底部 */
- (void)tryToappendAndScrollToBottom {
    // 处于爬楼状态更新更多按钮
    [self updateMoreBtnHidden];
    if (!self.inPending) {
        // 如果不处在爬楼状态，追加数据源并滚动到底部
        [self appendAndScrollToBottom];
    }
}

/** 追加数据源 */
- (void)appendAndScrollToBottom {
    if (self.tempMsgArray.count < 1) {
        return;
    }
    pthread_mutex_lock(&_mutex);
    // 执行插入
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (YXZMessageModel *item in self.tempMsgArray) {
        _AllHeight += item.attributeModel.msgHeight;
        
        [self.msgArray addObject:item];
        [indexPaths addObject:[NSIndexPath indexPathForRow:self.msgArray.count - 1 inSection:0]];
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tempMsgArray removeAllObjects];
    
    pthread_mutex_unlock(&_mutex);
    /*
    if (_AllHeight > MsgTableViewHeight) {
        if (self.tableView.height < MsgTableViewHeight) {
            self.tableView.y = 0;
            self.tableView.height = MsgTableViewHeight;
        }
    } else {
        self.tableView.y = MsgTableViewHeight - _AllHeight;
        self.tableView.height = _AllHeight;
    }*/
    
    //执行插入动画并滚动
    [self scrollToBottom:NO];
}
/** 执行插入动画并滚动 */
- (void)scrollToBottom:(BOOL)animated {
    NSInteger s = [self.tableView numberOfSections];  //有多少组
    if (s<1) return;
    NSInteger r = [self.tableView numberOfRowsInSection:s-1]; //最后一组行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}
- (void)setInPending:(BOOL)inPending {
    _inPending = inPending;
    
    // 新消息按钮可见状态
    [self updateMoreBtnHidden];
}
/** 新消息按钮可见状态 */
- (void)updateMoreBtnHidden {
    if (self.inPending && self.tempMsgArray.count > 0) {
        self.moreButton.hidden = NO;
    } else {
        self.moreButton.hidden = YES;
    }
}
//清空消息重置
- (void)reset {
    pthread_mutex_lock(&_mutex);
    
    _AllHeight = 15;
    [self stopTimer];
    [self.msgArray removeAllObjects];
    [self.tempMsgArray removeAllObjects];
    [self.tableView reloadData];
    self.moreButton.hidden = YES;
    
    pthread_mutex_unlock(&_mutex);
}
#pragma mark - Timer
- (void)startTimer {
    [self stopTimer];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:reloadTimeSpan target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
}

- (void)timerEvent {
    [self tryToappendAndScrollToBottom];
}

- (void)stopTimer {
    [self.refreshTimer invalidate];
    [self setRefreshTimer:nil];
}
#pragma mark - MsgCellGesDelegate
- (void)longPressGes:(YXZMessageModel *)msgModel {
    
}

- (void)userClick:(YxzUserModel *)user {
    if (user) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didUser:)]) {
            [self.delegate didUser:user];
        }
    }
}

- (void)touchMsgCellView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchSelfView)]) {
        [self.delegate touchSelfView];
    }
}
// 提示关注 分享 送礼物点击
- (void)remindCellFollow:(YXZMessageModel *)msgModel {

}
- (void)remindCellShare {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRemindShare)]) {
        [self.delegate didRemindShare];
    }
}
- (void)remindCellGifts {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRemindGifts)]) {
        [self.delegate didRemindGifts];
    }
}

/** 消息属性文字发生变化（更新对应cell） */
- (void)msgAttrbuiteUpdated:(YXZMessageModel *)msgModel {
    NSInteger row = [self.msgArray indexOfObject:msgModel];
    if (row >= 0) {
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        if (row == self.msgArray.count - 1) {
            [self scrollToBottom:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag != RoomMsgScroViewTag) return;
    // 开始滚动（自动|手动）
    _inAnimation = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 静止（自动）
    _inAnimation = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 手动拖拽开始
    self.inPending = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(startScroll)]) {
        [self.delegate startScroll];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 手动拖拽结束（decelerate：0松手时静止；1松手时还在运动,会触发DidEndDecelerating方法）
    if (!decelerate) {
        [self finishDraggingWith:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 静止后触发（手动）
    [self finishDraggingWith:scrollView];
}

/** 手动拖拽动作彻底完成(减速到零) */
- (void)finishDraggingWith:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(endScroll)]) {
        [self.delegate endScroll];
    }
    
    _inAnimation = NO;
    CGFloat contentSizeH = scrollView.contentSize.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat sizeH = scrollView.frame.size.height;
    
    self.inPending = contentSizeH - contentOffsetY - sizeH > 20.0;
    // 如果不处在爬楼状态，追加数据源并滚动到底部
    [self tryToappendAndScrollToBottom];
//    NSLog(@"Offset：%f，contentSize：%f, frame：%f", contentOffsetY, contentSizeH, sizeH);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXZMessageModel *msgModel = self.msgArray[indexPath.row];
    
    YxzChatBaseCell *cell = [YxzChatBaseCell tableView:tableView cellForMsg:msgModel indexPath:indexPath delegate:self];
    if (cell) {
        return cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YXZMessageModel *msgModel = self.msgArray[indexPath.row];
    return msgModel.attributeModel.msgHeight + cellLineSpeing;
}
// 新消息按钮
- (void)moreClick:(YxzAdjustPositionButton *)button {
    [self appendAndScrollToBottom];
    self.inPending = NO;
}

-(UITableView *)tableView{
    if (!_tableView) {
       _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled=YES;
        //_tableView.estimatedRowHeight = 40;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive|UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.bounces = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tag = RoomMsgScroViewTag;
    }
    return _tableView;
}

- (NSMutableArray<YXZMessageModel *> *)msgArray {
    if(!_msgArray){
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

- (NSMutableArray<YXZMessageModel *> *)tempMsgArray {
    if(!_tempMsgArray){
        _tempMsgArray = [NSMutableArray array];
    }
    return _tempMsgArray;
}
-(YxzListViewInputView *)listInputView{
    if (!_listInputView) {
        _listInputView=[[YxzListViewInputView alloc]init];
    }
    return _listInputView;
}
-(YxzAdjustPositionButton *)moreButton{
    if (!_moreButton) {
        _moreButton=[YxzAdjustPositionButton buttonWithType:UIButtonTypeCustom];
        _moreButton.layoutStyle=AdjustPositionButtonStyleLeftTitleRightImage;
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moreButton setTitle:@"新消息" forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"message_more"] forState:UIControlStateNormal];
        
        
        [_moreButton setTitleColor:RGBA_OF(0xfee324) forState:normal];
        _moreButton.backgroundColor = [UIColor purpleColor];
        _moreButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        _moreButton.hidden=YES;
        [_moreButton addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
@end

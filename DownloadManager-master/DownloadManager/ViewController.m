//
//  ViewController.m
//  DownloadManager
//
//  Created by huangyibiao on 16/5/23.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBVideoModel.h"
#import "HYBVideoCell.h"
#import "HYBVideoManager.h"

#define kBaseURL @"http://downmp413.ffxia.com/mp413/%E6%99%A8%E7%86%99-%E4%B8%A4%E4%B8%AA%E4%BA%BA%E7%9A%84%E7%97%9B%E4%B8%80%E4%B8%AA%E4%BA%BA%E8%83%8C[68mtv.com].mp4"

static NSString *kCellIdentifier = @"HYBVideoCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSArray *urls = @[@"27", @"15", @"26", @"19", @"25", @"17",
                    @"23", @"22", @"18", @"20", @"16", @"24",
                    @"14"];
  NSMutableArray *videoModels = [[NSMutableArray alloc] init];
  for (NSString *uid in urls) {
    HYBVideoModel *model = [[HYBVideoModel alloc] init];
   // model.videoUrl = [NSString stringWithFormat:@"%@/pages/mnks23/voide/1/course2/%@.MP4",kBaseURL, uid];
      model.videoUrl = kBaseURL;
      model.imageUrl = [NSString stringWithFormat:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];

    model.videoId = uid;
    model.title = [NSString stringWithFormat:@"测试下载视频标题：%@", uid];
    [videoModels addObject:model];
  }
  [[HYBVideoManager shared] addVideoModels:videoModels];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:self.tableView];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[HYBVideoCell class] forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [HYBVideoManager shared].videoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                       forIndexPath:indexPath];
 
  HYBVideoModel *model = [HYBVideoManager shared].videoModels[indexPath.row];
  cell.model = model;
  
  model.onStatusChanged = ^(HYBVideoModel *changedModel) {
    cell.model = changedModel;
  };
  
  model.onProgressChanged = ^(HYBVideoModel *changedModel) {
    cell.model = changedModel;
  };
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   HYBVideoModel *model = [HYBVideoManager shared].videoModels[indexPath.row];
  
  switch (model.status) {
    case kHYBVideoStatusNone: {
      [[HYBVideoManager shared] startWithVideoModel:model];
      break;
    }
    case kHYBVideoStatusRunning: {
      [[HYBVideoManager shared] suspendWithVideoModel:model];
      break;
    }
    case kHYBVideoStatusSuspended: {
     [[HYBVideoManager shared] resumeWithVideoModel:model];
      break;
    }
    case kHYBVideoStatusCompleted: {
      NSLog(@"已下载完成，可以播放了，播放路径：%@", model.localPath);
      break;
    }
    case kHYBVideoStatusFailed: {
      [[HYBVideoManager shared] resumeWithVideoModel:model];
      break;
    }
    case kHYBVideoStatusWaiting: {
      [[HYBVideoManager shared] startWithVideoModel:model];
      break;
    }
  }
  
}

@end

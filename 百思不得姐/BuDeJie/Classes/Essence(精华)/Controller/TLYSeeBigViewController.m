//
//  TLYSeeBigViewController.m
//  百思不得姐
//
//  Created by jack_tang on 17/4/19.
//  Copyright © 2017年 jack_tang. All rights reserved.
//

#import "TLYSeeBigViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TLYTopicItem.h"
#import <Photos/Photos.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface TLYSeeBigViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak,nonatomic) UIScrollView *scrollview;
@property (weak,nonatomic) UIImageView *imageV;

@end

@implementation TLYSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollview =scrollView;

    
   UIImageView *imageV = [[UIImageView alloc]init];
    NSURL *url = [NSURL URLWithString:self.item.image1];
    [imageV sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!image)return ;
        self.saveBtn.enabled = YES;
    }];
    [self.scrollview addSubview:imageV];
    
    imageV.tly_width = TLYScreenW;
    imageV.tly_height = imageV.tly_width*self.item.height/self.item.width;
    imageV.tly_x = 0;
    
    if(imageV.tly_height>TLYScreenH){
        imageV.tly_y = 0;
        self.scrollview.contentSize = CGSizeMake(0, imageV.tly_height);
    }else{
        imageV.center_y = TLYScreenH*0.5;
    }
    self.imageV =imageV;
    
   
   CGFloat maxScale = self.item.width/self.imageV.tly_width;
    if(maxScale>1){
     scrollView.delegate = self;
        self.scrollview.minimumZoomScale = maxScale;
        
    }
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imageV;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    //1.请求的权限
  PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(status == PHAuthorizationStatusDenied){//用户拒绝访问
                if(oldStatus != PHAuthorizationStatusNotDetermined){
                    NSLog(@"提醒用户打开开关");
                }
            }else if(status == PHAuthorizationStatusAuthorized){//同意访问
                [self saveImageIntoAlbum];
            }else if(status == PHAuthorizationStatusRestricted){//无法访问
                [SVProgressHUD showErrorWithStatus:@"因系统原因,无法访问相册"];
            }
            
        });
    }];
    
}

/**
    将图片保存到相册,只是将图片保存保存到系统相册中
 */
- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageV.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}



-(void)saveImageIntoAlbum{
    // 获得相片,只是将图片保存保存到系统相册中.
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    /**如果要创建自定义的相册,还需要继续执行下面的方法*/
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }
}

#pragma mark - 获得当前App对应的自定义相册
- (PHAssetCollection *)createdCollection
{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HHPhotoTool.m
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#import "HHPhotoTool.h"
#import <HXPhotoPicker/HXPhotoPicker.h>
#import "HHToastTool.h"
#import "HHDefine.h"
#import "HHUIImagePicker.h"

@implementation HHPhotoTool

+ (NSInteger)getLanaguage {
    HHLanguageType type = [[[NSUserDefaults standardUserDefaults] valueForKey:HHLanguageTypeKey] integerValue];
    return type;
}

+ (void)getPhoto:(HXPhotoModel *)model success:(void(^)(HHPhotoModel *photo))success failed:(HXModelFailedBlock)failed {
    if (model.subType == HXPhotoModelMediaSubTypePhoto) {
        
        [model getImageWithSuccess:^(UIImage * _Nullable image, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
            
            HHPhotoModel *pModel = [HHPhotoModel modelWithImage:image video:nil isVideo:NO];

            if (success) {
                success(pModel);
            }
            
        } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
            NSLog(@"failed: %@", info);
            if (failed) {
                failed(info, model);
            }
        }];
    } else {
        [model getAssetURLWithSuccess:^(NSURL * _Nullable URL, HXPhotoModelMediaSubType mediaType, BOOL isNetwork, HXPhotoModel * _Nullable model) {
            
            HHPhotoModel *pModel = [HHPhotoModel modelWithImage:nil video:URL isVideo:YES];
            
            if (success) {
                success(pModel);
            }
            
        } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
            NSLog(@"failed: %@", info);
            if (failed) {
                failed(info, model);
            }
        }];
    }
    
}

+ (void)sheetPortraitWithController:(UIViewController *)vc title:(NSString *)title completion:(HHPhotoToolCompletion)completion {
    
    HXPhotoBottomViewModel *model1 = [[HXPhotoBottomViewModel alloc] init];
    model1.title = title;
    model1.titleColor = [UIColor hx_colorWithHexStr:@"#999999"];
    model1.cellHeight = 40.f;
    model1.titleFont = [UIFont systemFontOfSize:13];
    model1.canSelect = NO;
    
    HXPhotoBottomViewModel *model2 = [[HXPhotoBottomViewModel alloc] init];
    model2.title = GetLocalLanguageTextValue(@"TakePicture");
    
    HXPhotoBottomViewModel *model3 = [[HXPhotoBottomViewModel alloc] init];
    model3.title = GetLocalLanguageTextValue(@"SelectFromPhoneAlbum");
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhoto];
    
    photoManager.configuration.type = HXConfigurationTypeWXChat;
    photoManager.configuration.languageType = [self getLanaguage];
    
    photoManager.configuration.singleJumpEdit = YES;
    photoManager.configuration.singleSelected = YES;
    photoManager.configuration.lookGifPhoto = NO;
    photoManager.configuration.lookLivePhoto = NO;
    photoManager.configuration.openCamera = NO;
    photoManager.configuration.photoEditConfigur.aspectRatio = HXPhotoEditAspectRatioType_1x1;
    photoManager.configuration.photoEditConfigur.onlyCliping = YES;
    
    [HXPhotoBottomSelectView showSelectViewWithModels:@[model1, model2, model3] selectCompletion:^(NSInteger index, HXPhotoBottomViewModel * _Nonnull model) {
        
        if (index == 1) {
            // 拍照
            [vc hx_presentCustomCameraViewControllerWithManager:photoManager done:^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
                
                [self getPhoto:model success:completion failed:nil];

            } cancel:nil];
        } else if (index == 2) {
            // 相册
            [vc hx_presentSelectPhotoControllerWithManager:photoManager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
                
                [self getPhoto:allList.firstObject success:completion failed:nil];

            } cancel:nil];
        }
    } cancelClick:nil];
    
}

+ (void)sheetImagePickerWithController:(UIViewController *)vc title:(NSString *)title count:(NSInteger)count edit:(BOOL)edit completion:(HHPhotoToolMultipleCompletion)completion {
    
    HXPhotoBottomViewModel *model1 = [[HXPhotoBottomViewModel alloc] init];
    model1.title = title;
    model1.titleColor = [UIColor hx_colorWithHexStr:@"#999999"];
    model1.cellHeight = 40.f;
    model1.titleFont = [UIFont systemFontOfSize:13];
    model1.canSelect = NO;
    
    HXPhotoBottomViewModel *model2 = [[HXPhotoBottomViewModel alloc] init];
    model2.title = GetLocalLanguageTextValue(@"TakePicture");
    
    HXPhotoBottomViewModel *model3 = [[HXPhotoBottomViewModel alloc] init];
    model3.title = GetLocalLanguageTextValue(@"SelectFromPhoneAlbum");
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhoto];
    
    photoManager.configuration.type = HXConfigurationTypeWXChat;
    photoManager.configuration.languageType = [self getLanaguage];
    
    photoManager.configuration.lookGifPhoto = NO;
    photoManager.configuration.lookLivePhoto = NO;
    photoManager.configuration.openCamera = NO;
    
    photoManager.configuration.maxNum = count;
    photoManager.configuration.singleSelected = count == 1;
    
    photoManager.configuration.photoCanEdit = edit;

    [HXPhotoBottomSelectView showSelectViewWithModels:@[model1, model2, model3] selectCompletion:^(NSInteger index, HXPhotoBottomViewModel * _Nonnull model) {
        
        if (index == 1) {
            // 拍照
            [vc hx_presentCustomCameraViewControllerWithManager:photoManager done:^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
                
                HHPhotoModel *pModel = [HHPhotoModel modelWithImage:model.previewPhoto video:nil isVideo:NO];
                if (completion) {
                    completion(@[pModel]);
                }
                
                [self getPhoto:model success:^(HHPhotoModel *photo) {
                    if (completion) {
                        completion(@[photo]);
                    }
                } failed:nil];

            } cancel:nil];
        } else if (index == 2) {
            // 相册
            [vc hx_presentSelectPhotoControllerWithManager:photoManager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
                
                NSMutableArray *mArr = [NSMutableArray array];
                for (int i = 0; i < allList.count; i++) {
                    [self getPhoto:allList[i] success:^(HHPhotoModel *photo) {
                        
                        [mArr addObject:photo];
                        
                        if (mArr.count == allList.count) {
                            if (completion) {
                                completion(mArr);
                            }
                        }
                        
                    } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                        // TODO
                    }];
                }
                
            } cancel:nil];
        }
    } cancelClick:nil];
    
}

+ (void)imagePickerSingleWithController:(UIViewController *)vc seletedVideo:(BOOL)seletedVideo edit:(BOOL)edit completion:(HHPhotoToolCompletion)completion {
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:seletedVideo?HXPhotoManagerSelectedTypePhotoAndVideo:HXPhotoManagerSelectedTypePhoto];
    photoManager.configuration.maxNum = 1;
    photoManager.configuration.singleSelected = YES;
    photoManager.configuration.openCamera = NO;
    photoManager.configuration.videoAutoPlayType = YES;
    photoManager.configuration.photoCanEdit = edit;
    photoManager.configuration.videoCanEdit = edit;
    
    photoManager.configuration.type = HXConfigurationTypeWXChat;
    photoManager.configuration.languageType = [self getLanaguage];

    [vc hx_presentSelectPhotoControllerWithManager:photoManager didDone:^(NSArray<HXPhotoModel *> * _Nullable allList, NSArray<HXPhotoModel *> * _Nullable photoList, NSArray<HXPhotoModel *> * _Nullable videoList, BOOL isOriginal, UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        
        NSSLog(@"block - all - %@", allList);

        HXPhotoModel *model = allList.firstObject;

        [self getPhoto:model success:completion failed:nil];
                
    } cancel:^(UIViewController * _Nullable viewController, HXPhotoManager * _Nullable manager) {
        
    }];
    
}

+ (void)imagePickerMultipleWithController:(UIViewController *)vc count:(NSInteger)count seletedVideo:(BOOL)seletedVideo completion:(HHPhotoToolMultipleCompletion)completion {
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:seletedVideo?HXPhotoManagerSelectedTypePhotoAndVideo:HXPhotoManagerSelectedTypePhoto];
    
    photoManager.configuration.type = HXConfigurationTypeWXChat;
    photoManager.configuration.languageType = [self getLanaguage];

    photoManager.configuration.videoAutoPlayType = YES;
    photoManager.configuration.maxNum = count;
    photoManager.configuration.openCamera = NO;
    photoManager.configuration.singleSelected = count == 1;

    [vc hx_presentSelectPhotoControllerWithManager:photoManager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
        
        NSSLog(@"block - all - %@", allList);

        NSMutableArray *mArr = [NSMutableArray array];
        for (int i = 0; i < allList.count; i++) {
            [self getPhoto:allList[i] success:^(HHPhotoModel *photo) {
                
                [mArr addObject:photo];
                
                if (mArr.count == allList.count) {
                    if (completion) {
                        completion(mArr);
                    }
                }
                
            } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                // TODO
                
            }];
        }
        
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        NSSLog(@"block - 取消了");
    }];
}


/// 拍照
+ (void)cameraWithController:(UIViewController *)vc video:(BOOL)video system:(BOOL)system completion:(HHPhotoToolCompletion)completion {
    [self cameraWithController:vc video:video edit:YES system:system completion:completion];
}


+ (void)cameraWithController:(UIViewController *)vc video:(BOOL)video edit:(BOOL)edit system:(BOOL)system completion:(HHPhotoToolCompletion)completion {
    
    if (system) {
        
        [[HHUIImagePicker shareInstance] presentPicker:(video?PickerType_Take:PickerType_Camera) target:vc callBackBlock:^(NSDictionary * _Nullable infoDict, BOOL isCancel) {
            
            if (isCancel) {
                return;
            }
            
            if (video) {
                NSURL *url = [infoDict objectForKey:UIImagePickerControllerMediaURL]; // 视频路径
                if (completion && url) {
                    HHPhotoModel *pModel = [HHPhotoModel modelWithImage:nil video:url isVideo:YES];
                    completion(pModel);
                }
            } else {
                UIImage *image = [infoDict valueForKey:UIImagePickerControllerOriginalImage];
                if (completion && image) {
                    HHPhotoModel *pModel = [HHPhotoModel modelWithImage:image video:nil isVideo:NO];
                    completion(pModel);
                }
            }
            
        }];
        
        return;
    }
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:video?HXPhotoManagerSelectedTypePhotoAndVideo:HXPhotoManagerSelectedTypePhoto];
    
    photoManager.configuration.type = HXConfigurationTypeWXChat;
    photoManager.configuration.languageType = [self getLanaguage];
    
    photoManager.configuration.photoCanEdit = edit;
    photoManager.configuration.videoCanEdit = edit;

    [vc hx_presentCustomCameraViewControllerWithManager:photoManager done:^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
        
        [self getPhoto:model success:completion failed:nil];

    } cancel:nil];
}


/// 预览图片|视频
+ (void)showImageWithController:(UIViewController *)vc source:(NSArray *)source previews:(NSArray *)previews index:(NSInteger)index {
    
    NSMutableArray *arrImages = [NSMutableArray array];

    for (int i = 0; i < source.count; i ++) {
        id obj = source[i];
        if ([obj isKindOfClass:[NSURL class]]) {
            // 网络图片
            HXCustomAssetModel *model = [HXCustomAssetModel assetWithNetworkImageURL:obj selected:YES];
            [arrImages  addObject:model];
            
        } else if ([obj isKindOfClass:[NSString class]]) {
            // 路径
            HXCustomAssetModel *model = [HXCustomAssetModel assetWithImagePath:[NSURL fileURLWithPath:obj] selected:YES];
            [arrImages addObject:model];
            
        } else if ([obj isKindOfClass:[UIImage class]]) {
            HXCustomAssetModel *model = [HXCustomAssetModel assetWithLocalImage:obj selected:YES];
            [arrImages addObject:model];
        }
    }
    
    if (arrImages.count == 0) {
        return;
    }
    
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    photoManager.configuration.saveSystemAblum = YES;
    photoManager.configuration.photoMaxNum = 0;
    photoManager.configuration.videoMaxNum = 0;
    photoManager.configuration.maxNum = 10;
    photoManager.configuration.selectTogether = YES;
    photoManager.configuration.photoCanEdit = NO;
    photoManager.configuration.videoCanEdit = NO;
    photoManager.configuration.videoAutoPlayType = YES;

    photoManager.configuration.languageType = [self getLanaguage];
    
    // 长按事件
    photoManager.configuration.previewRespondsToLongPress = ^(UILongPressGestureRecognizer *longPress, HXPhotoModel *photoModel, HXPhotoManager *manager, HXPhotoPreviewViewController *previewViewController) {
        HXPhotoBottomViewModel *model = [[HXPhotoBottomViewModel alloc] init];
        model.title = GetLocalLanguageTextValue(@"Save");
        [HXPhotoBottomSelectView showSelectViewWithModels:@[model] headerView:nil cancelTitle:nil selectCompletion:^(NSInteger index, HXPhotoBottomViewModel * _Nonnull model) {
            if (index == 0) {
                // 保存
                if (photoModel.subType == HXPhotoModelMediaSubTypePhoto) {
                    // 图片
                    [HXPhotoTools savePhotoToCustomAlbumWithName:nil photo:photoModel.previewPhoto location:nil complete:^(HXPhotoModel * _Nullable model, BOOL success) {
                        if (success) {
                            [HHToastTool showAtCenter:GetLocalLanguageTextValue(@"SaveSuccess")];
                        } else {
                            [HHToastTool showAtCenter:GetLocalLanguageTextValue(@"SaveFailed")];
                        }
                    }];

                } else {
                    // 视频
                    [HXPhotoTools saveVideoToCustomAlbumWithName:nil videoURL:photoModel.videoURL location:nil complete:^(HXPhotoModel * _Nullable model, BOOL success) {
                        if (success) {
                            [HHToastTool showAtCenter:GetLocalLanguageTextValue(@"SaveSuccess")];
                        } else {
                            [HHToastTool showAtCenter:GetLocalLanguageTextValue(@"SaveFailed")];
                        }
                    }];
                }
                
            }
        } cancelClick:nil];
    };
    
    [photoManager addCustomAssetModel:arrImages];
    
    // 跳转预览界面时动画起始的view
    photoManager.configuration.customPreviewFromView = ^UIView *(NSInteger currentIndex) {
        if (!previews || previews.count <= currentIndex || ![previews[currentIndex] isKindOfClass:[UIView class]]) {
            return nil;
        }
        return previews.count > currentIndex ? previews[currentIndex] : nil;
    };
    // 跳转预览界面时展现动画的image
    photoManager.configuration.customPreviewFromImage = ^UIImage *(NSInteger currentIndex) {
        if (!previews || previews.count <= currentIndex || ![previews[currentIndex] isKindOfClass:[UIView class]]) {
            return nil;
        }
        if ([previews[currentIndex] isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)previews[currentIndex];
            return imageView.image;
        }
        return nil;
    };
    // 退出预览界面时终点view
    photoManager.configuration.customPreviewToView = ^UIView *(NSInteger currentIndex) {
        if (!previews || previews.count <= currentIndex || ![previews[currentIndex] isKindOfClass:[UIView class]]) {
            return nil;
        }
        return previews.count > currentIndex ? previews[currentIndex] : nil;
    };

    [vc hx_presentPreviewPhotoControllerWithManager:photoManager
                                         previewStyle:HXPhotoViewPreViewShowStyleDark
                                         currentIndex:index
                                            photoView:nil];
}


/// 编辑图片|视频
+ (void)editImageWithController:(UIViewController *)vc source:(id)source isVideo:(BOOL)isVideo completion:(HHPhotoToolCompletion)completion {
        
    // 照片  视频url
    
    HXPhotoModel *model = nil;
    if (isVideo) {
        model = [HXPhotoModel photoModelWithVideoURL:source];
    } else {
        if ([source isKindOfClass:[UIImage class]]) {
            model = [HXPhotoModel photoModelWithImage:source];
        } else if ([source isKindOfClass:[NSURL class]]) {
            model = [HXPhotoModel photoModelWithImage:source];
        }
    }
    
    if (!model) {
        return;
    }
    
    // 使用仿微信编辑功能
    HXPhotoManager *photoManager = [HXPhotoManager managerWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    photoManager.configuration.languageType = [self getLanaguage];

    [vc hx_presentWxPhotoEditViewControllerWithConfiguration:photoManager.configuration.photoEditConfigur photoModel:model delegate:nil finish:^(HXPhotoEdit * _Nonnull photoEdit, HXPhotoModel * _Nonnull photoModel, HX_PhotoEditViewController * _Nonnull viewController) {
        
        if (completion) {
            
            [self getPhoto:photoModel success:completion failed:nil];

        }
        
    } cancel:^(HX_PhotoEditViewController * _Nonnull viewController) {
        // 取消
    }];

}

@end


@implementation HHPhotoModel

+ (instancetype)modelWithImage:(UIImage *)image video:(NSURL *)video isVideo:(BOOL)isVideo {
    HHPhotoModel *model = [[HHPhotoModel alloc] init];
    model.image = image;
    model.videoURL = video;
    model.isVideo = isVideo;
    return model;
}

@end

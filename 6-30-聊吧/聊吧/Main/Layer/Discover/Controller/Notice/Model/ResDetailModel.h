//
//  ResDetailModel.h
//  聊吧
//
//  Created by m on 16/6/27.
//  Copyright © 2016年 m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResDetailModel : NSObject


/*
 {
 ApproveResult = "<null>";
 ApproveTime = "<null>";
 ApproveUser = "<null>";
 ChangeEndTime = "<null>";
 ChangeStartTime = "<null>";
 Clicks = "<null>";
 CollectCount = 0;
 Com1 = "<null>";
 Com2 = "\U5bf9\U5634.mp3";
 Com3 = "<null>";
 Com4 = "<null>";
 Com5 = "<null>";
 CourseName = "\U6570\U5b66";
 CourseType = 1020;
 "Create_at" = "0000-00-00 00:00:00";
 Favoriter = "<null>";
 FromType = 3;
 GradePhaseId = "<null>";
 HitGoodCount = 0;
 Hits = "<null>";
 Id = 7618;
 ImgUrl = "<null>";
 ModifyTime = "<null>";
 ModifyUser = "<null>";
 OpenStatue = 1;
 Phase = 2;
 PhaseName = "\U4e03\U5e74\U7ea7\U4e0b\U518c\Uff082013\U5e7412\U6708\U7b2c1\U7248\Uff09";
 PhaseTextBook = 3399;
 Posts = "<null>";
 Price = 5;
 QuestionId = "<null>";
 QuestionType = "<null>";
 Recommand = "<null>";
 ResCollectCount = 0;
 ResDownCount = 6;
 ResFileChangeCloudUrl = "<null>";
 ResFileChangeUrl = "<null>";
 ResFileIsChange = 0;
 ResFileSize = 1073714;
 ResFileType = mp3;
 ResHitBadCount = 0;
 ResHitGoodCount = 0;
 ResMimeType = "audio/mp3";
 ResNewFileName = "RES201606241116514475.mp3";
 ResPushCount = 5;
 ResViewCount = 5;
 ResourceIntro = "\U6682\U65e0\U7b80\U4ecb";
 ResourceType = 4;
 SaveSubDir = "RES20160624/";
 Status = 0;
 TempUrl = "RES20160624/RES201606241116514475.mp3";
 Term = "<null>";
 TextBookChapter = "<null>";
 TextBookVersion = 1297;
 Title = "\U5bf9\U5634.mp3";
 UploadTempPath = "/tmp/phpODNJK1";
 UploadTime = "2016-06-24 11:16:51";
 Url = "RES20160624/RES201606241116514475.mp3";
 UserId = 5126;
 UserName = 5126;
 }
 );
 errorCode = "";
 errorFlag = 0;
 errorMsg = "";
 pageCount = 9;
 pageInfo =     {
 count = 171;
 pages =         {
 pageVar = page;
 params = "<null>";
 route = "";
 validateCurrentPage = 1;
 };
 };
 */

@property (nonatomic,copy) NSString *dataURL;
@property (nonatomic,copy) NSString *resourceIntro;
@property (nonatomic,copy) NSString *fileType;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) BOOL isCollect;

/**
 *  {
 errorCode = "";
 errorFlag = 0;
 errorMsg = "";
 resData =     {
 UserName = "";
 UserPic = "";
 beginCount = 0;
 commentList =         (
 );
 dataURL = "/uploads/tempfiles/resources/PRES20160622_1/RESP201606220420468980.ppt";
 error = 0;
 fileType = ppt;
 imgURL = "<null>";
 isCollect = 0;
 isHitGood = 0;
 isLoginUser = 1;
 mimetype = "application/vnd.ms-powerpoint";
 pdfURL = "/uploads/tempfiles/resources/";
 recommendCount = 1;
 recommendResList =         (
 );
 resFileIsChange = 3;
 resId = 85914;
 resType = 3;
 resViewCount = 2;
 resourceIntro = "\U6b66\U5937\U5c71\U548c\U963f\U91cc\U5c71\U7684\U4f20\U8bf4";
 title = "\U6b66\U5937\U5c71\U548c\U963f\U91cc\U5c71\U7684\U4f20\U8bf4";
 };
 }
 */

@end

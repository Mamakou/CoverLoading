//
//  BDLoadingConst.h
//  CoverLoadingDemo
//
//  Created by goviewtech on 2018/11/14.
//  Copyright © 2018 goviewtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


/**这里的各项处理请求的错误结果后期可以扩展*/
typedef NS_ENUM(NSInteger,BDRequestErrorType){
    
    /**其他情况*/
    BDRequestErrorOther = -1,
    
    BDRequestErrorNone,
    /**网络差*/
    BDRequestErrorNetLow,
    /**请求超时*/
    BDRequestErrorTimeOut,
    /**接口请求失败*/
    BDRequestErrorDataFail,
    /**token失效，目前只有异地登录*/
    BDRequestErrorTokenInvalid,
    /**当前app版本过低*/
    BDRequestErrorVersionLow,
    /**当前的app功能未开发*/
    BDRequestErrorFuncUnopened,
    /**数据被删除*/
    BDRequestErrorDataDeleted,
    /**数据异常 一般用户已知数据出现问题，此时页面不再提供继续操作*/
    BDRequestErrorDataException,
    /**数据被下线*/
    BDRequestErrorDownlined = 101,//后台返回的错误码
    /**用户不存在*/
    BDRequestErrorUserNoExist = 102,
    /**用户被禁封*/
    BDRequestErrorUserSealUp = 103,
    
};


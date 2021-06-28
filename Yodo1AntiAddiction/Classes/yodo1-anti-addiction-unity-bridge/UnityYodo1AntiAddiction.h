//
//  UnityYodo1AntiAddiction.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

typedef enum: NSInteger {
    ResulTypeInit = 8001,
    ResulTypeTimeLimit = 8002,
    ResulTypeCertification = 8003,
    ResulTypeVerifyPurchase = 8004,
    ResulTypeVerifyDisconnected = 8005,//(玩家从防沉迷掉线时回调事件
    ResulTypeVerifyBehaviorReult = 8006,//玩家上下线行为回调事件
} BridgeEventCode;

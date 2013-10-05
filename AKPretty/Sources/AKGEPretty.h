//
//  AKGEPretty.h
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import "AKPretty0.h"

/**
 R言語で使用されるge_pretty関数のOjbective-C版。
 軸を内側に作成する。
 */
@interface AKGEPretty : AKPretty0

/**
 調整後の最小値、最大値、分割数およびステップ幅を求める。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 */
+ (void)gePrettyWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit;

/**
 調整後の最小値、最大値、分割数およびステップ幅を求め、調整後の最小値から最大値までステップ幅ごとの値を格納した配列を返す。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 
 @return 調整後の最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)getGEPrettyArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit;

@end

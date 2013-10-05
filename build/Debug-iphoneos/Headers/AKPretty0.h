//
//  AKPretty0.h
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ROUNDING_EPS        1e-7
/// 許容する計算誤差
#define PRECISION           1e-6

/**
 R言語で使われるpretty関数のObjective-C版。
 pretty.cを参考にしている。
 */
@interface AKPretty0 : NSObject

/**
 調整後の最小値、最大値、分割数およびステップ幅を求める。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param minN 最小の分割数
 @param shrinkSml 最大値と最小値の差が微小な場合に、最大値・最小値それぞれの絶対値で大きい方の値を拡大するスケール
 @param highUFact ステップ幅を調整するファクター
 @param epsCorrection ?
 @param returnBounds ?
 */
+ (void)pretty0WithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit minN:(int)minN shrinkSml:(double)shrinkSml highUFact:(double *)highUFact epsCorrection:(int)epsCorrection returnBounds:(int)returnBounds;

/**
 調整後の最小値、最大値、分割数およびステップ幅を求め、調整後の最小値から最大値までステップ幅ごとの値を格納した配列。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param minN 最小の分割数
 @param shrinkSml 最小値と最大値の差が微小な場合に、最小値・最大値それぞれの絶対値で大きい方の値を拡大するスケール
 @param highUFact ステップ幅を調整するファクター
 @param epsCorrection ?
 @param returnBounds ?
 
 @return 調整後の最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)getPretty0ArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit minN:(int)minN shrinkSml:(double)shrinkSml highUFact:(double *)highUFact epsCorrection:(int)epsCorrection returnBounds:(int)returnBounds;

/**
 調整後の最小値から最大値までステップ幅ごとの値を格納した配列を返す。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param unit ステップ幅のポインタ
 
 @return 調整後の最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)makePrettyArrayWithLo:(double *)lo up:(double *)up unit:(double *)unit;

@end

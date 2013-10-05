//
//  AKSimplePretty.h
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import "AKPretty0.h"

/**
 R言語のpretty関数の簡略版。
 highUFactのデフォルト値を[1.5, 2.75]としている。
 */
@interface AKSimplePretty : AKPretty0

/**
 調整後の最小値、最大値、分割数およびステップ幅を求める。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param highUFact
 */
+ (void)simplePrettyWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit highUFact:(double *)highUFact;

/**
 調整後の最小値、最大値、分割数およびステップ幅を求め、調整後の最小値から最大値までステップ幅ごとの値を格納した配列を返す。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param highUFact
 
 @return 調整後の最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)getSimplePrettyArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit highUFact:(double *)highUFact;

@end

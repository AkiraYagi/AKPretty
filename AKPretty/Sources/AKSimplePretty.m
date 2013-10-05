//
//  AKSimplePretty.m
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import "AKSimplePretty.h"

@implementation AKSimplePretty

/**
 外側に分割線を作成する最小値、最大値、分割数およびステップ幅を求める。
 highUFactのデフォルト値は[1.5, 2.75]としている。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param highUFact ステップ幅を調整するファクター
 */
+ (void)simplePrettyWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit highUFact:(double *)highUFact
{
    if (ndiv == NULL) {
        *ndiv = 5;
    }
    
    double h = 1.5;
    double h5 = 2.75;
    if (highUFact != NULL) {
        h = highUFact[0];
        h5 = highUFact[1];
    }
    
    double cell = (*up-*lo) / *ndiv;
    double base = pow(10, floor(log10(cell)));
    
    if (cell <= (2+h)/(1+h) * base) {
        *unit = base;
    } else if (cell <= (5+2*h5)/(1+h5) * base) {
        *unit = 2*base;
    } else if (cell <= (10+5*h)/(1+h) * base) {
        *unit = 5*base;
    } else {
        *unit = 10*base;
    }
    
    double loPerUnit = floor(*lo / *unit);
    double upPerUnit = ceil(*up / *unit);
    
    *lo = loPerUnit * *unit;
    *up = upPerUnit * *unit;
    *ndiv = (upPerUnit - loPerUnit);
}

/**
 自身のsimplePrettyWithLo:up:ndiv:unit:highUFact:から、外側に分割線を作成するように調整した最小値、最大値、分割数およびステップ幅を求め、
 親クラスのmakePrettyArrayWithLo:up:unit:から配列を作成し返す。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param highUFact ステップ幅を調整するファクター
 
 @return 調整した最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)getSimplePrettyArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit highUFact:(double *)highUFact
{
    [self simplePrettyWithLo:lo up:up ndiv:ndiv unit:unit highUFact:highUFact];
    
    return [super makePrettyArrayWithLo:lo up:up unit:unit];
}

@end

//
//  AKGEPretty.m
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import "AKGEPretty.h"

@implementation AKGEPretty

/**
 内側に分割線を作成する最小値、最大値、分割数およびステップ幅を求める。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 */
+ (void)gePrettyWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit
{
    double ns, nu;
    double highUFact[2] = {0.8, 1.7};
    
    if (*ndiv <= 0) {
        NSLog(@"[Error]invalid axis extents [GEPretty(., ., n = %d)", *ndiv);
        return;
    }
    
    if (*lo == INFINITY || *up == INFINITY || *lo == -INFINITY || *up == -INFINITY) {
        NSLog(@"[Error]infinite axis extents [GEPretty(%g,%g,%d)]", *lo, *up, *ndiv);
        return;
    }
    
    ns = *lo; nu = *up;
    
    [super pretty0WithLo:&ns up:&nu ndiv:ndiv unit:unit minN:1 shrinkSml:0.25 highUFact:highUFact epsCorrection:2 returnBounds:0];
    
    if (nu >= ns + 1) {
        if (ns * *unit < *lo - ROUNDING_EPS * *unit) ns++;
        if ((nu > ns + 1) && (nu * *unit > *up + ROUNDING_EPS * *unit)) nu--;
        *ndiv = (int)(nu - ns);
    }
    *lo = ns * *unit;
    *up = nu * *unit;
}

/**
 自身のクラスの-(void)gePrettyWithLo:up:ndiv:unit:から各パラメータの値を求め、親クラスのmakePrettyArrayWithLo:up:unit:で
 配列を作成し返す。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 
 @return 調整後の最小値から最大値までステップ幅ごとの値を格納した配列
 */
+ (NSArray *)getGEPrettyArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit
{
    [self gePrettyWithLo:lo up:up ndiv:ndiv unit:unit];
    
    return [super makePrettyArrayWithLo:lo up:up unit:unit];
}

@end

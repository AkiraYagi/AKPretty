//
//  AKPretty0.m
//  AKPretty
//
//  Created by AkiraYagi on 2013/10/05.
//  Copyright (c) 2013年 AkiraYagi. All rights reserved.
//

#import "AKPretty0.h"

@implementation AKPretty0

/**
 調整後の最小値、最大値、分割数およびステップ幅を求める。
 @param lo 最小値のポインタ
 @param up 最大値のポインタ
 @param ndiv 想定する分割数のポインタ
 @param unit ステップ幅のポインタ
 @param minN 最小の分割数
 @param shrinkSml 最小値と最大値の差が微小な場合に、最小値・最大値それぞれの絶対値で大きい方の値を拡大するスケール
 @param highUFact ステップ幅を調整するファクター
 @param epsCorrection
 @param returnBounds
 */
+ (void)pretty0WithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit minN:(int)minN shrinkSml:(double)shrinkSml highUFact:(double *)highUFact epsCorrection:(int)epsCorrection returnBounds:(int)returnBounds
{
    double h = highUFact[0];
    double h5 = highUFact[1];
    
    double dx, cell, base, U;
    double ns, nu;
    int k;
    BOOL iSmall;
    
    dx = *up - *lo;
    /* cell := "scale"	here */
    if (dx == 0 && *up == 0) { /*  up == lo == 0	 */
        cell = 1;
        iSmall = YES;
    } else {
        cell = fmax(fabs(*lo), fabs(*up));
        /* U = upper bound on cell/unit */
        U = 1 + ((h5 >= 1.5*h+0.5) ? 1/(1 + h) : 1.5 / (1+h5));
        /* added times 3, as several calculations here */
        iSmall = dx < (cell * U * fmax(1, *ndiv) * DBL_EPSILON * 3) ? YES : NO;
    }
    
    /*OLD: cell = FLT_EPSILON+ dx / *ndiv; FLT_EPSILON = 1.192e-07 */
    if (iSmall) {
        if (cell > 10) cell = 9 + cell/10;
        cell *= shrinkSml;
        if (minN > 1) cell /= minN;
    } else {
        cell = dx;
        if (*ndiv > 1) cell /= *ndiv;
    }
    
    if (cell < 20*DBL_MIN) {
        NSLog(@"[Warning]Internal(pretty()): very small range.. corrected");
        cell = 20*DBL_MIN;
    } else if (cell*10 > DBL_MAX) {
        NSLog(@"[Warning]Internal(pretty()): very large range.. corrected");
        cell = 0.1*DBL_MAX;
    }
    base = pow(10.0, floor(log10(cell))); /* base <= cell < 10*base */
    
    /* unit : from { 1,2,5,10 } * base
     *	 such that |u - cell| is small,
     * favoring larger (if h > 1, else smaller)  u  values;
     * favor '5' more than '2'  if h5 > h  (default h5 = .5 + 1.5 h) */
    *unit = base;
    if ((U = 2*base)-cell < h*(cell-*unit)) {
        *unit = U;
        if ((U = 5*base)-cell < h5*(cell-*unit)) {
            *unit = U;
            if ((U = 10*base)-cell < h*(cell-*unit)) {
                *unit = U;
            }
        }
    }
    
    /* Result: c := cell,  u := unit,  b := base
     *	c in [	1,	      (2+ h) /(1+h) ] b ==> u=  b
     *	c in ( (2+ h)/(1+h),  (5+2h5)/(1+h5)] b ==> u= 2b
     *	c in ( (5+2h)/(1+h), (10+5h) /(1+h) ] b ==> u= 5b
     *	c in ((10+5h)/(1+h),	         10 ) b ==> u=10b
     *
     *	===>	2/5 *(2+h)/(1+h)  <=  c/u  <=  (2+h)/(1+h)	*/
    ns = floor(*lo / *unit + ROUNDING_EPS);
    nu = ceil(*up / *unit - ROUNDING_EPS);
    if (epsCorrection && (epsCorrection > 1 || !iSmall)) {
        if (*lo) *lo *= (1-DBL_EPSILON); else *lo = -DBL_MIN;
        if (*up) *up *= (1+DBL_EPSILON); else *up = +DBL_MIN;
    }
    while (ns * *unit > *lo + ROUNDING_EPS * *unit) ns--;
    while (nu * *unit < *up - ROUNDING_EPS * *unit) nu++;
    
    k = (int)(0.5 + nu - ns);
    if (k < minN) {
        /* ensure that	nu - ns	 == min_n */
        k = minN - k;
        if (ns >= 0) {
            nu += k/2;
            ns -= k/2 + k%2; /* ==> nu-ns = old(nu-ns) + min_n -k = min_n */
        } else {
            ns -= k/2;
            nu += k/2 + k%2;
        }
        *ndiv = minN;
    } else {
        *ndiv = k;
    }
    
    if (returnBounds) { /* if()'s to ensure that result covers original range */
        if (ns * *unit < *lo) *lo = ns * *unit;
        if (nu * *unit > *up) *up = nu * *unit;
    } else {
        *lo = ns;
        *up = nu;
    }
}

/**
 自身のpretty0WithLo:up:ndiv:unit:minN:shirinkSml:highUFact:epsCorrection:returnBounds:から、調整後の最小値、最大値、分割数およびステップ幅を求め、
 makePrettyArrayWithLo:up:unit:から配列を作成し返す。
 */
+ (NSArray *)getPretty0ArrayWithLo:(double *)lo up:(double *)up ndiv:(int *)ndiv unit:(double *)unit minN:(int)minN shrinkSml:(double)shrinkSml highUFact:(double *)highUFact epsCorrection:(int)epsCorrection returnBounds:(int)returnBounds
{
    [self pretty0WithLo:lo up:up ndiv:ndiv unit:unit minN:minN shrinkSml:shrinkSml highUFact:highUFact epsCorrection:epsCorrection returnBounds:returnBounds];
    
    return [self makePrettyArrayWithLo:lo up:up unit:unit];
}

/**
 調整後の最小値、最大値およびステップ幅を受け取り、最小値から最大値までステップ幅ごとの値を格納した配列を作成し返す。
 PRECISIONは許容する計算誤差でQRPretty0.hに定義している。
 */
+ (NSArray *)makePrettyArrayWithLo:(double *)lo up:(double *)up unit:(double *)unit
{
    NSMutableArray *res = [NSMutableArray array];
    double i = *lo;
    while (i-*up < PRECISION) {
        [res addObject:[NSNumber numberWithDouble:i]];
        i += *unit;
    }
    return [NSArray arrayWithArray:res];
}

@end

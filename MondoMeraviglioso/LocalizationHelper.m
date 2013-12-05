//
//  LocalizationHelper.m
//  MondoMeraviglioso
//
//  Created by Cristiano Degiorgis on 05/12/13.
//  Copyright (c) 2013 WebProfessor. All rights reserved.
//

#import "LocalizationHelper.h"

#include <math.h>
#define KmPerDegree		111.12000071117
#define	DegreesPerKm	(1.0/KmPerDegree)
#define PI				M_PI
#define TwoPI			(M_PI+M_PI)
#define HalfPI			M_PI_2
#define RadiansPerDegree	(PI/180.0)
#define	DegreesPerRadian	(180.0/PI)
#define copysign(x,y)		(((y)<0.0)?-fabs(x):fabs(x))
#define NGT1(x)		(fabs(x)>1.0?copysign(1.0,x):(x))
//#define ArcCos(x)	(fabs(x)>1?quiet_nan():acos(x)) //Hack
#define ArcCos(x)	(acos(x))
#define hav(x)		((1.0-cos(x))*0.5)		/* haversine */
#define ahav(x)		(ArcCos(NGT1(1.0-((x)*2.0))))	/* arc haversine */
#define sec(x)		(1.0/cos(x))			/* secant */
#define csc(x)		(1.0/sin(x))			/* cosecant */
@implementation LocalizationHelper


+(CLLocation*) moveLocation:(CLLocation*)startLocation :(double)movementInMeters :(double)movementBearing
{
	//http://iphonedevsdk.com/forum/iphone-sdk-development-advanced-discussion/36462-modifying-cllocations.html
	double	dist = (movementInMeters / 1000);	/* -> great-circle distance (km) */
	double	course = movementBearing;			/* -> initial great-circle course (degrees) */
	double	slt = startLocation.coordinate.latitude;	/* -> starting decimal latitude (-S) */
	double	slg = startLocation.coordinate.longitude;	/* -> starting decimal longitude(-W) */
	double	xlt = 0;	/* <- ending decimal latitude (-S) */
	double	xlg = 0;	/* <- ending decimal longitude(-W) */
	
	double	c, d, dLo, L1, L2, coL1, coL2, l;
    
	if (dist > KmPerDegree*180.0) {
		course -= 180.0;
		if (course < 0.0) course += 360.0;
		dist    = KmPerDegree*360.0-dist;
	}
	
	if (course > 180.0) course -= 360.0;
	c    = course*RadiansPerDegree;
	d    = dist*DegreesPerKm*RadiansPerDegree;
	L1   = slt*RadiansPerDegree;
	slg *= RadiansPerDegree;
	coL1 = (90.0-slt)*RadiansPerDegree;
	coL2 = ahav(hav(c)/(sec(L1)*csc(d))+hav(d-coL1));
	L2   = HalfPI-coL2;
	l    = L2-L1;
	if ((dLo=(cos(L1)*cos(L2))) != 0.0)
		dLo  = ahav((hav(d)-hav(l))/dLo);
	if (c < 0.0) dLo = -dLo;
	slg += dLo;
	if (slg < -PI)
		slg += TwoPI;
	else if (slg > PI)
		slg -= TwoPI;
    
	xlt = L2*DegreesPerRadian;
	xlg = slg*DegreesPerRadian;
    
	CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:xlt longitude:xlg];
	return tempLocation;
}

@end

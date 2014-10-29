//
//  Temperature.c
//  api weather
//
//  Created by George Francis on 15/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#include <stdio.h>

#include "Temperature.h"

float kelvinToCelsius(float kelvin){
    return kelvin - 273.15f;
}
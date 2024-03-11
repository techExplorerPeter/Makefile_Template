#include <stdio.h>
#include "sum.h"

int sum_function(int a, int b)
{
    printf("hello module1\n");
    printf("%s input a = %d b= %d\n",__func__, a, b);
    return a + b;
}
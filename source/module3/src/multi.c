#include <stdio.h>
#include "multi.h"

int multi_function(int a, int b)
{
    printf("hello module3\n");
    printf("%s input a = %d b= %d\n",__func__, a, b);
    return a * b;
}
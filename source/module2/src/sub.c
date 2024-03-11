#include <stdio.h>
#include "sub.h"

int sub_function(int a, int b)
{
    printf("hello module2\n");
    printf("%s input a = %d b= %d\n",__func__, a, b);
    return a - b;
}
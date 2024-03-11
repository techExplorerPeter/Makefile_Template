/*
 * @Author: Pengteng Zhu pengteng.zhu@sinpro.ai
 * @Date: 2024-03-08 16:55:26
 * @LastEditors: Pengteng Zhu pengteng.zhu@sinpro.ai
 * @LastEditTime: 2024-03-08 16:55:26
 * @FilePath: /Makefile/project/source/main.c
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
#include <stdio.h>
#include "sum.h"
#include "sub.h"
#include "multi.h"

int main(int argc, char *argv[])
{
    printf("Hello mk_demo\n");
    int test_val = sum_function(1,1);
    printf("sum_function result is %d\n",test_val);
    test_val = sub_function(4,1);
    printf("sub_function result is %d\n",test_val);
    test_val = multi_function(6,6);
    printf("multi_function result is %d\n",test_val);
    return 0;
}

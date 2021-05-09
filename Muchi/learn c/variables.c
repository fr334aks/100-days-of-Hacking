#include <stdio.h>
#include <stdlib.h>
#include <math.h>
/*this is a multiline comment*/
//covers strings and concatination
int main() 
{
    char text1[]="john";
    int age=35;

    printf("There once was a man named %s\n", text1);
    printf("he was %d years old \n",age); 
    printf("he realy liked the name %s\n", text1);
    printf("but he did not like being %d\n", age); 
    //math
    printf("%f",4.5*27.11);
    printf("%f",floor(pow(23,20)));

    return 0;
}
#include <stdio.h>
#include <stdlib.h>
int main(){
    //strings are arrays
    int numbers[]= {22,33,44,5,6,6,4,3};
    numbers[1]=20;
    printf("%d",numbers[1]);
    return 0;
}
#include <stdio.h>
#include <stdlib.h>
int main(){
    float age =30;
    int *page= &age; 
    printf("%p\n",page);
    printf("%p\n",&age);

    return 0;
}
#include <stdlib.h>
#include <stdio.h>

int main(){
    int age;
    char name[20];
    char school[20];
    printf("Enter your age");
    scanf("%d",&age);
    printf("you are %d old \n",age);
    // printf("Enter your name : \t");
    // scanf("%s",name);
    printf("Enter your school : \t");
    fgets(school,20,stdin);
    printf("%s",school);


    return 0;
}
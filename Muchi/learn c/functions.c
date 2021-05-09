#include <stdio.h>
#include <stdlib.h>

int main(){
    sayhi();
    greet("mike");
    return 0;
}
void sayhi(){
    printf("hello user");
}
void greet(char name[]){
    printf("heloo %s\n",name);
}
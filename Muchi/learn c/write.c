#include <stdio.h>
#include <stdlib.h>
int main(){
    FILE *fpointer = fopen("text.txt","w");
    fprintf(fpointer,"lalala");
    fclose(fpointer);
    return 0;
}
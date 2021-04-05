#include <stdio.h>
#include <strings.h>

int main(int argc, char *argv[])
{
   char buffer[64];
   
   if (argc < 2 )
   { 
        printf("Error - you must supply at least one arguement\n");
        
        return 1;
      }
   
      strcpy(buffer, argv[1]);
   
   return 0;
}

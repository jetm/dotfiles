#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// limit number line to print
#define N_LINES (8)

int main(void) {
    char ss_line[220];

    // Open the command for reading
    FILE *fp = popen("/bin/ss -Hntup", "r");
    if (fp == NULL) {
        printf("Failed to run command\n");
        exit(1);
    }

    // count number of output lines
    int n_lines = 0;

    // Read the output a line at a time - output it
    while (fgets(ss_line, sizeof(ss_line) - 1, fp) != NULL &&
           ++n_lines <= N_LINES) {
        char **line = NULL;
        char *p = strtok(ss_line, " \n");

        // index of each string that no is a space
        int columns = 0;

        // split string and append tokens to 'line'
        while (p) {
            line = realloc(line, sizeof(char *) * ++columns);
            if (line == NULL) {
                exit(-1);  // memory allocation failed
            }

            line[columns - 1] = p;
            p = strtok(NULL, " \n");
        }

        // realloc one extra element for the last NULL
        line = realloc(line, sizeof(char *) * (columns + 1));
        line[columns] = NULL;

        //
        // print all lineult
        //
        // printf("columns = %d\n", columns);
        // for (int i = 0; i < (columns+1); ++i) {
        //     printf ("line[%d] = %s\n", i, line[i]);
        // }

        if (columns > 6 && line[0] && line[5] && line[6]) {
            // print network family
            printf("%s  ", line[0]);
            // printf ("line[%d] = %s\n", 0, line[0]);

            // print destination ip
            // xxx.xxx.xxx.xxx:yyyyy = 21 spaces
            printf("%s ", line[5]);
            for (uint8_t i = 0; i < (21 - strlen(line[5])); ++i) {
                printf(" ");
            }
            // printf ("line[%d] = %s\n", 5, line[5]);
  
            // print process name
            char process_name[20] = {0};
            // extract string between double quotes ""
            if (sscanf(line[6], "%*[^\"]\"%[^\"]\"", process_name) == 1) {
                printf("%s\n", process_name);
            }
            // printf ("line[%d] = %s\n", 6, line[6]);
        }

        // free the memory allocated
        free(line);
    }

    // printf("n_lines = %d\n", n_lines);

    // close
    pclose(fp);

    return 0;
}

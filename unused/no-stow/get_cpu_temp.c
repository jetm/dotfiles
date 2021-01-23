#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <stdbool.h>

bool print_temp(char *dev) {
    FILE *temp = fopen(dev, "r");
    if (temp == NULL) {
        return false;
    }

    double T;
    fscanf(temp, "%lf", &T);
    printf("%2.f", T/1000);
    fclose(temp);

    return true;
}

bool create_dev(char monitor, char *cpu) {
    char cpu_temp[60];

    sprintf(cpu_temp, "/sys/devices/platform/coretemp.0/hwmon/hwmon%c",
            monitor);
    strncat(cpu_temp, "/temp", 5);
    strncat(cpu_temp, cpu, 1);
    strncat(cpu_temp, "_input", 7);
    // printf("%s", cpu_temp);
    // exit(0);
    if (print_temp(cpu_temp)) {
        exit(0);
    } else {
        return false;
    }
}

int main(int argc, char **argv) { 
    if (argc < 2) {
        printf("00");
        exit(0);
    }

    if (create_dev('0', argv[1])) {
        return 0; 
    } else if (create_dev('1', argv[1])) {
        return 0;
    } else if (create_dev('2', argv[1])) {
        return 0;
    } else {
        printf("00");
    }

    return 0;
}

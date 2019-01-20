/************************************************************************\
*                  Copyright (C) Michael Kerrisk, 2017.                   *
*                                                                         *
* This program is free software. You may use, modify, and redistribute it *
* under the terms of the GNU General Public License as published by the   *
* Free Software Foundation, either version 3 or (at your option) any      *
* later version. This program is distributed without any warranty.  See   *
* the file COPYING.gpl-v3 for details.                                    *
\*************************************************************************/

/* Supplementary program for Chapter 3 */

#include "tlpi_hdr.h"
#include "time.h"
#include "sys/time.h"

static void print_time (void)
{
    struct timeval tv; 
    time_t time;
    char str_t[26] = {0};
 
    gettimeofday (&tv, NULL);
 
    time = tv.tv_sec;
 
    struct tm* p_time = localtime(&time); 
    strftime(str_t, 26, "%Y-%m-%d %H:%M:%S\n", p_time);  
 
    printf ("%s\n", str_t);
}

#define NOSYSCALL

#ifdef NOSYSCALL
static int myfunc() { return 1; }
#endif

int
main(int argc, char *argv[])
{
    int numCalls, j;

    numCalls = (argc > 1) ? getInt(argv[1], GN_GT_0, "num-calls") : 10000000;

#ifdef NOSYSCALL
        printf("Calling normal function\n");
#else
        printf("Calling getppid()\n");
#endif
    print_time();
    for (j = 0; j < numCalls; j++)
#ifdef NOSYSCALL
        myfunc();
#else
        getppid();
#endif
    print_time();
    exit(EXIT_SUCCESS);
}

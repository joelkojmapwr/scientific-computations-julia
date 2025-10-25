#include <stdio.h>
#include <float.h>

int main() {
#ifdef __FLT16_EPSILON__
    printf("Float16 epsilon = %.9g\n", (float) __FLT16_EPSILON__);
#else
    printf("Float16 not supported on this compiler.\n");
#endif
    printf("Float32 epsilon: %.9g\n", FLT_EPSILON);
    printf("Float64 epsilon: %.17g\n", DBL_EPSILON);
}
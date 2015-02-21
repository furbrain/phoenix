#include <stdio.h>
#include <string.h>
#include "debug.h"
#include "display.h"
#ifdef DEBUG
void debug(const char *format, ...)
{
    char text[17] = "                ";
    va_list args;
    va_start(args, format);
    vsnprintf(text,17,format, args);
    va_end(args);
    if (strlen(text)<16) {
        text[strlen(text)] = ' ';
    }
    display_write_text(0,0,text,&small_font,false);

}
#endif

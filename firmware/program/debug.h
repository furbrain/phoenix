#ifndef DEBUG_H
#define DEBUG_H
#ifdef DEBUG
void debug(const char *format, ...);
#else
#define debug(...) do{} while(0)
#endif
#endif

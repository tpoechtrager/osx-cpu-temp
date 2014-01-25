
TOOLCHAIN = 
CC        = $(TOOLCHAIN)clang
AR        = $(TOOLCHAIN)ar
TARGETS   = -arch i386 -arch x86_64
OSXMIN    = 10.5
CFLAGS    = -O2 -Wall -mmacosx-version-min=$(OSXMIN)
PREFIX    = /usr/local
EXEC      = osx-cpu-temp
LIB       = smc.a

build : $(EXEC) $(LIB)

clean : 
	rm -f $(EXEC) $(LIB)

$(EXEC) : smc.c
	$(CC) $(TARGETS) $(CFLAGS) -framework IOKit -o $@ $?

$(LIB) : smc.c
	$(CC) $(TARGETS) $(CFLAGS) -DSMCLIB -c -o smc.o $?
	rm -f smc.a
	$(AR) rcs smc.a smc.o

install : $(EXEC)
	install $(EXEC) $(PREFIX)/bin
	install smc.h $(PREFIX)/include
	install $(LIB) $(PREFIX)/lib

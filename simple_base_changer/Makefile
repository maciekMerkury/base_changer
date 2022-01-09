default: debug_build
run: debug_run

PROG_NAME = base6_converter

COMMON_CFLAGS = --edition 2018
DEBUG_CFLAGS = -Cdebug-assertions=yes -Cdebuginfo=2 -Copt-level=0 -Cpanic=unwind --cfg 'debug'
RELEASE_CFLAGS = -Cdebug-assertions=no -Cdebuginfo=0 -Copt-level=3 -Clink-dead-code=no -Clto=yes -Cprefer-dynamic=no

RUN_ARGS = 13521

.PHONY: debug_build debug_run release_build release_run release_object_build

debug_build:
	rustc ${COMMON_CFLAGS} ${DEBUG_CFLAGS} main.rs -o main

debug_run: debug_build
	./main ${RUN_ARGS}

release_build:
	rustc ${COMMON_CFLAGS} ${RELEASE_CFLAGS} main.rs -o main
	strip main

release_run: release_build
	./main ${RUN_ARGS}

full_build: debug_build release_build release_object_build

object_release_build:
	rustc ${COMMON_CFLAGS} ${RELEASE_CFLAGS} --emit obj main.rs -o ${PROG_NAME}.o


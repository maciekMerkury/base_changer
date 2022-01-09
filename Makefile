default: debug_build
run: debug_run

PROG_NAME = base6_converter

COMMON_CFLAGS = --edition 2021
DEBUG_CFLAGS = -Cdebug-assertions=yes -Cdebuginfo=2 -Copt-level=0 -Cpanic=unwind --cfg 'debug'
RELEASE_CFLAGS = -Cdebug-assertions=no -Cdebuginfo=0 -Copt-level=3 -Clink-dead-code=no -Clto=yes -Cprefer-dynamic=no

RUN_ARGS = 13521

SOURCE_DIR = sauce
TARGET_DIR = outputs

.PHONY: debug_build debug_run release_build release_run release_object_build

debug_build:
	rustc ${COMMON_CFLAGS} ${DEBUG_CFLAGS} ${SOURCE_DIR}/main.rs -o ${TARGET_DIR}/debug/main

debug_run: debug_build
	./${TARGET_DIR}/debug/main ${RUN_ARGS}

release_build:
	rustc ${COMMON_CFLAGS} ${RELEASE_CFLAGS} ${SOURCE_DIR}/main.rs -o ${TARGET_DIR}/release/main
	strip ${TARGET_DIR}/release/main

release_run: release_build
	./${TARGET_DIR}/release/main ${RUN_ARGS}

full_build: debug_build release_build release_object_build

clean:
	rm ${TARGET_DIR}/debug/*
	rm ${TARGET_DIR}/release/*

release_object_build:
	rustc ${COMMON_CFLAGS} ${RELEASE_CFLAGS} --emit obj ${SOURCE_DIR}/main.rs -o ${TARGET_DIR}/release/${PROG_NAME}.o


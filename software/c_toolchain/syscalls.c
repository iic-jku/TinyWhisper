// SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

#include "csr.h"
#include "mmio.h"
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

void *__dso_handle = 0;

int _write(int fd, char *ptr, int len) {
  /* if (fd != STDOUT_FILENO) { */
  /*   errno = ENOENT; */
  /*   return -1; */
  /* } */

  for (int i = 0; i < len; i++) {
    *UART_TX = *(ptr + i);
  }

  /* *UART_TX = 'C'; */
  return len;
}

int _read(int fd, char *ptr, int len) {
  /* if (fd != STDIN_FILENO) { */
  /*   errno = ENOENT; */
  /*   printf("Error in _read"); */
  /*   return -1; */
  /* } */

  uart_rx_enable();
  uart_interrupt_disable();
  uart_interrupt_clear();

  for (int i = 0; i < len; i++) {
    while (!uart_interrupt_pending()) {
      // Waiting....
    }
    ptr[i] = uart_data_read();
    uart_interrupt_clear();
  }

  return len;
}

void *_sbrk(int incr) {
  extern int heap_begin;
  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) {
    heap = (unsigned char *)&heap_begin;
  }
  prev_heap = heap;

  if ((int)heap + incr < (int)&heap_begin + 2000) {
    heap += incr;
  }

  return prev_heap;
}

int _fstat(int fd, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

int _lseek(int fd, int offset, int whence) { return 0; }

int _open(const char *name, int flags, int mode) {
  errno = ENOSYS;
  return -1;
}

int _close(int fd) { return -1; }

int _isatty(int fd) { return 1; }

void _exit(int status) {
  while (1) {
  }
}

int _kill(int pid, int sig) {
  errno = EINVAL;
  return -1;
}

int _getpid() { return -1; }

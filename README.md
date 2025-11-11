rtems 코드 확인할 것
src/rtems/cpukit/libcsupport/src/termios.c
src/rtems/bsps/shared/grlib/uart 파일들
src/rtems/cpulit/include/rtems/termiostypes.h 퓨ㅏ일 확인해서
uart데이터를 cfs로 가져올 수 있게끔 해보기 -> uart데이터를 char 형태로 가져오는데 이거를 
src/rtems/bsps/bfin/shared/dev/uart.c
src/rtems/bsps/include/grlib/apbuart~~팡ㄹ들 화ㅓㄱ인 

__asm__ __volatile__(a: s(S): "s"());

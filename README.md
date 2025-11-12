volatile unsigned int uaddr *base = (uaddr*) 0x800000000u
temp32 = base[0x000/4]
base[0x000/4] = temp32 | 0x00000800
& ~0x00000800


uint32 readbypasscache32 (uint32 addr){ 
uint32 temp =0;
__asm__ __volatile__(" lda[%1]1, %0 "
: "=r"(temp)
: "r"(addr));
retuen temp
}

void writebypasscache32 (uint32 addr, uint32 value){ 
uint32 temp =0;
uint16 chksum(uint32 len, volatile const uint8 *pData, uint16 syndrom){
register uint16 retval = syndrom
register int64 length = 0;
volatile const register uint8 *pointer = pData;

length = (int64) len;
while (length >0){
retval = ((retval<<8)^CRC_TAB[((retval >>8)^*(pointer)++)&0x00FF]);
length--;}
return retval;
}

__asm__ __volatile__(" sta%0, [%1]1 "
: 
: "r"(value)), "r"(addr));
}

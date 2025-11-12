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
__asm__ __volatile__(" sta%0, [%1]1 "
: 
: "r"(value)), "r"(addr));
}

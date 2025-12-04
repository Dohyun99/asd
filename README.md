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




============

Function crc_out = fcn(data_in)
    % data_in: uint8 배열 (예: 421x1)
    % crc_out: CRC가 붙은 uint8 배열 (예: 423x1)

    % CRC 파라미터 설정
    % Poly: 0x1021 (CCITT)
    POLY = uint16(0x1021); 
    % Initial: 0xFFFF
    crc = uint16(0xFFFF); 

    % 2. 바이트 단위 순회
    for k = 1:numel(data_in)
        % 현재 데이터를 상위 바이트로 올려 XOR
        % (MSB First, Direct Method 방식)
        current_byte = uint16(data_in(k));
        crc = bitxor(crc, bitshift(current_byte, 8));
        
        % 8비트 처리 (Shift & XOR)
        for i = 1:8
            % MSB가 1인지 확인 (0x8000 = 1000...0000)
            if bitand(crc, 0x8000)
                crc = bitshift(crc, 1);
                crc = bitxor(crc, POLY);
            else
                crc = bitshift(crc, 1);
            end
        end
    end
    
    crc_out = [data_in; crc_high; crc_low];
enda


하기 건에 대해 CRC-16/CCITT 로 반영하였습니다.
조건 및 결과는 아래와 같습니다.
 
CRC-16/CCITT info: 첨부파일 참조
SIM GEN Dummy data: Zeros([421 x 1], ‘uint8’)                   à total 421 bytes, data frame only
SIM Output: Zeros([421 x 1], ‘uint8’), [0xFA 0xCF]      à total 423 bytes, data + CRC
 
전체 421 바이트 0배열 에 대해 CRC 결과가 다르실 경우 알려주시면 확인토록 하겠습니다.

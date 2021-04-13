;使用jns条件跳转的方式，不会有后面多字的情况
jmp start
mytext 	db 'L',0x07,'a',0x07,'b',0x07,'e',0x07,'l',0x07,' ',0x07,'o',0x07
		db 'f',0x07,'f',0x07,'s',0x07,'e',0x07,'t',0x07,':',0x07
start:

;使用两个段寄存器访问内存
;es用于访问显存那段,起始物理地址：0xb8000
;ds用于访问加载主引导扇区那段,起始物理地址：0x07c00


;先显示静态的内容“Label offset:”


mov ax,0xb800 ;置初始段地址，不能直接赋值，下同
mov es,ax 

mov ax,0x7c0
mov ds,ax

;在使用movsw指令时需要做准备
;它传输内存中ds:si->es:di，其中标志位df表示传输的方向，默认为0，往高地址传输
xor di,di		;清零,目标的偏移地址
mov si,mytext   ;原数据的偏移地址

cld ;df标志位置0，与之相反的是std

mov cx,(start-mytext)/2 
rep movsw		;rep 通过cx控制重复的次数,cx为0不重复


;显示number
;抽取汇编地址的位放到number处,分解出来的位，是倒序的，这里采取放到另外的地方后，再放到显存

;准备工作：
mov ax,number ;作32位除法，但实际的数只在ax寄存器，商在ax，余数在dx
mov bx,ax	;bx保存number，作寻址
mov cx, 5	;cx 也可以控制 loop的循环次数
mov si,10	;si除数 


loop1:

xor dx,dx ;作32位除法，dx为高地址，实际的数只在ax，所以清空
div si		;32位除法，余数在dx中
add dx,30h ;根据ascii码表的关系，+30h，表示成数字
mov [bx],dx ;往内存中写入分解出的数
inc bx		;增1为下一次写入作准备
loop loop1	;循环，cx控制循环次数

;将分解出来的位写入显存
;mov cx,5

;loop2:
;dec bx ;承上，因从bx对应的内存地址获取分解出的位
;mov al,[bx];将分解出的位，从内存转移到寄存器
;mov ah,04;设置这个字符的属性
;mov [es:di],ax;写入显存
;add di,2; 下一个位置
;loop loop2

;另一种利用条件转实现循环
mov bx,number ;重新置为number
mov si,4
loop2:
mov al,[bx+si];寻址方式不能使用 ax+bx这种
mov ah,04;设置这个字符的属性
mov [es:di],ax;写入显存
add di,2;下一个位置

dec si;必须在这里
jns loop2 ;标志位sf如果不是1，则跳转，sf是最近一次运算结果的数的最左一位

db 0
number db 0,0,0,0,0

;$表示当前行汇编地址
;$$表示程序起始汇编地址

jmp $

times 510-($-$$) db 0 
db 0x55,0xaa

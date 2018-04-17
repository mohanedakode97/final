start:
bits 16
org 0x7C00

	cli
      mov ah ,0x02
      mov al ,8
      mov dl ,0x80
      mov dh ,0
      mov ch ,0
      mov cl ,2
      mov bx ,on
      int 0x13
      jmp on
      
times (510 - ($ - $$)) db 0
db 0x55, 0xAA
 
on: 
      cli
	xor ax,ax
	mov ss,ax
	mov sp,0xffff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      mov ah, 0   ; set display mode function.
      mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
      int 10h     ; set it!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;The Grid
;color
      mov al,1111b
      mov cx, 0; x-axis
      mov dx, 0; y-axis
      mov ah, 0ch ; put pixel
      int 10h

;first row
      mov cx, 70; x-axis
      mov dx, 70; y-axis
colcount:
      inc cx
      int 10h
      cmp cx, 250
      JNE colcount
      
;second row
      mov cx,70
      mov dx,130
colcount2:
      inc cx
      int 10h
      cmp cx, 250
      JNE colcount2

;first column
      mov cx,130
      mov dx,10
rowcount:
      inc dx
      int 10h
      cmp dx, 190
      jne rowcount

;second column
      mov cx,190
      mov dx,10
rowcount2:
      inc dx
      int 10h
      cmp dx, 190
      jne rowcount2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      mov ebp,0
      jmp check
       
first:
      mov edi,0
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,100
      mov dx,40
      inc ebp
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
second:
      mov edi,1
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,160
      mov dx,40
      inc ebp 
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
third:
      mov edi,2
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,220
      mov dx,40
      inc ebp 
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
fourth:
      mov edi,3
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,100
      mov dx,100
      inc ebp 
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
fifth:
      mov edi,4
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,160
      mov dx,100
      inc ebp 
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
sixth:
      mov edi,5
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,220
      mov dx,100
      inc ebp
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
seventh:
      mov edi,6
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,100
      mov dx,160
      inc ebp
      push ebp
      test ebp,0x01
      jz even
      jnz odd
         
eighth:
      mov edi,7
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,160
      mov dx,160
      inc ebp
      push ebp 
      test ebp,0x01
      jz even
      jnz odd
         
ninth:
      mov edi,8
      cmp byte[arr+edi],'0'
      jne check
      mov byte[arr+edi],'1'
      xor ecx,ecx
      xor edx,edx
      mov cx,220
      mov dx,160
      inc ebp
      push ebp
      test ebp,0x01
      jz even
      jnz odd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
odd:
      jmp drawx
         
even:
      jmp drawo
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
         
next:
         
row1:
      cmp byte[arr2],'X'
      jne row2
      cmp byte[arr2+1],'X'
      jne row2
      cmp byte[arr2+2],'X'
      jne row2
      mov byte[win],'X'
      jmp winrow1
         
row2:
      cmp byte[arr2+3],'X'
      jne row3
      cmp byte[arr2+4],'X'
      jne row3
      cmp byte[arr2+5],'X'
      jne row3
      mov byte[win],'X'
      jmp winrow2
         
row3:
      cmp byte[arr2+6],'X'
      jne column1
      cmp byte[arr2+7],'X'
      jne column1
      cmp byte[arr2+8],'X'
      jne column1
      mov byte[win],'X'
      jmp winrow3
         
column1:
      cmp byte[arr2],'X'
      jne column2
      cmp byte[arr2+3],'X'
      jne column2
      cmp byte[arr2+6],'X'
      jne column2
      mov byte[win],'X'
      jmp wincolumn1
         
column2:
      cmp byte[arr2+1],'X'
      jne column3
      cmp byte[arr2+4],'X'
      jne column3
      cmp byte[arr2+7],'X'
      jne column3
      mov byte[win],'X'
      jmp wincolumn2
         
column3:
      cmp byte[arr2+2],'X'
      jne diag1
      cmp byte[arr2+5],'X'
      jne diag1
      cmp byte[arr2+8],'X'
      jne diag1
      mov byte[win],'X'
      jmp wincolumn3
         
diag1:
      cmp byte[arr2],'X'
      jne diag2
      cmp byte[arr2+4],'X'
      jne diag2
      cmp byte[arr2+8],'X'
      jne diag2
      mov byte[win],'X'
      jmp windiag1
         
diag2:
      cmp byte[arr2+2],'X'
      jne row11
      cmp byte[arr2+4],'X'
      jne row11
      cmp byte[arr2+6],'X'
      jne row11
      mov byte[win],'X'
      jmp windiag2
         
row11:
      cmp byte[arr2],'O'
      jne row22
      cmp byte[arr2+1],'O'
      jne row22
      cmp byte[arr2+2],'O'
      jne row22
      mov byte[win],'O'
      jmp winrow1
         
row22:
      cmp byte[arr2+3],'O'
      jne row33
      cmp byte[arr2+4],'O'
      jne row33
      cmp byte[arr2+5],'O'
      jne row33
      mov byte[win],'O'
      jmp winrow2
         
row33:
      cmp byte[arr2+6],'O'
      jne column11
      cmp byte[arr2+7],'O'
      jne column11
      cmp byte[arr2+8],'O'
      jne column11
      mov byte[win],'O'
      jmp winrow3
         
column11:
      cmp byte[arr2],'O'
      jne column22
      cmp byte[arr2+3],'O'
      jne column22
      cmp byte[arr2+6],'O'
      jne column22
      mov byte[win],'O'
      jmp wincolumn1
         
column22:
      cmp byte[arr2+1],'O'
      jne column33
      cmp byte[arr2+4],'O'
      jne column33
      cmp byte[arr2+7],'O'
      jne column33
      mov byte[win],'O'
      jmp wincolumn2
         
column33:
      cmp byte[arr2+2],'O'
      jne diag11
      cmp byte[arr2+5],'O'
      jne diag11
      cmp byte[arr2+8],'O'
      jne diag11
      mov byte[win],'O'
      jmp wincolumn3
         
diag11:
      cmp byte[arr2],'O'
      jne diag22
      cmp byte[arr2+4],'O'
      jne diag22
      cmp byte[arr2+8],'O'
      jne diag22
      mov byte[win],'O'
      jmp windiag1
         
diag22:
      cmp byte[arr2+2],'O'
      jne R
      cmp byte[arr2+4],'O'
      jne R
      cmp byte[arr2+6],'O'
      jne R
      mov byte[win],'O'
      jmp windiag2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
R:
      pop ebp
      cmp ebp,9
      jge nowin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
   
check:
      in al,0x64
      and al,0x01
      jz check
      in al,0x60
      cmp al,0x80
      ja check
      cmp al,0x47  ;7
      je first
      cmp al,0x48 ;8
      je second
      cmp al,0x49  ;9
      je third
      cmp al,0x4b   ;4
      je fourth
      cmp al,0x4c   ;5
      je fifth
      cmp al,0x4d   ;6
      je sixth
      cmp al,0x4f   ;1
      je seventh
      cmp al,0x50   ;2
      je eighth
      cmp al,0x51   ;3
      je ninth
      cmp al,0x1C ;Enter (to rsest)
      je Restart
      jmp check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
     
Restart:
      mov ebp , 0
      xor edi,edi
Res:
      mov ah, 0
      mov al , 0x13
      int 0x10
      jmp start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;      
;drawing X

drawx:
      mov byte[arr2+edi],'X'
      sub dx,20
      sub cx,20
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,40
ll4411:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1100b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl ll4411

      sub dx,40
      add dx,cx
      mov bx,dx
      sub dx,cx
      mov si,dx
      add si,40
lll41:
      sub bx,dx
      mov cx,bx
      add bx,dx
      mov al,1100b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl lll41
      jmp next
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;drawing O
        
drawo:
      mov byte[arr2+edi],'O'
      mov [a],cx
      mov [b],dx
      sub dx,10;radious
      mov si,dx
      add si,20
      finit
aa41:
      mov cx,[a]
      mov [y],dx
      fild word[y]
      fisub word[b]
      fmul st0
      fisub word[r2]
      fchs
      fsqrt
      fistp word[x]
      add cx,[x]
      mov al,1001b
      mov ah, 0ch
      int 10h
      neg cx
      add cx,[a]
      add cx,[a]
      mov al,1001b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl aa41
      jmp next
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            
winrow1:
      mov cx,70
      mov dx,40
aw:
      inc cx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp cx, 250
      JNE aw
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
       
winrow2:
      mov cx,70
      mov dx,100
bw:
      inc cx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp cx, 250
      JNE bw
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
       
winrow3:
      mov cx,70
      mov dx,160
c:
      inc cx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp cx, 250
      JNE c
      cmp byte[win],'X'
      je drawxwin
      jne drawowin

wincolumn1:
      mov cx,100
      mov dx,10
d:
      inc dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp dx, 190
      jne d
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
       
wincolumn2:
      mov cx,160
      mov dx,10
e:
      inc dx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp dx, 190
      jne e
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
      
wincolumn3:
      mov cx,220
      mov dx,10
f:
      inc dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp dx, 190
      jne f
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
      
windiag1:
      mov cx,70
      mov dx, 10     
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,180
ll44117:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1110b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl ll44117
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
      
windiag2:       
      mov cx,250
      mov dx,10
      add dx,cx
      mov bx,dx
      sub dx,cx
      mov si,dx
      add si,180
lll5:
      sub bx,dx
      mov cx,bx
      add bx,dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl lll5
      cmp byte[win],'X'
      je drawxwin
      jne drawowin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
drawxwin:
      mov cx, 10; x-axis
      mov dx, 70; y-axis
;draw X
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,60
x1:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1110b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl x1

      sub dx,60
      add dx,cx
      mov bx,dx
      sub dx,cx
      mov si,dx
      add si,60
x2:
      sub bx,dx
      mov cx,bx
      add bx,dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl x2
      jmp drawWIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
drawowin:
      mov cx, 40; x-axis
      mov dx, 100; y-axis
;draw O
      mov [a],cx
      mov [b],dx
      mov dword[r2],900
      sub dx,30
      mov si,dx
      add si,60
      finit
o1:
      mov cx,[a]
      mov [y],dx
      fild word[y]
      fisub word[b]
      fmul st0
      fisub word[r2]
      fchs
      fsqrt
      fistp word[x]
      add cx,[x]
      mov al,1110b
      mov ah, 0ch
      int 10h
      neg cx
      add cx,[a]
      add cx,[a]
      mov al,1010b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl o1
      jmp drawWIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
nowin:
;draw NO
;draw N
      mov cx,10
      mov dx,30
n4:
      inc dx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp dx, 90
      jne n4

      mov cx,11
      mov dx,30
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,60
n5:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1010b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl n5

      mov cx,70
      mov dx,30
n6:
      inc dx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp dx, 90
      jne n6

;draw O
      mov cx, 40; x-axis
      mov dx, 140; y-axis
      mov [a],cx
      mov [b],dx
      mov dword[r2],900
      sub dx,30
      mov si,dx
      add si,60
      finit
o2:
      mov cx,[a]
      mov [y],dx
      fild word[y]
      fisub word[b]
      fmul st0
      fisub word[r2]
      fchs
      fsqrt
      fistp word[x]
      add cx,[x]
      mov al,1010b
      mov ah, 0ch
      int 10h
      neg cx
      add cx,[a]
      add cx,[a]
      mov al,1110b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl o2
      jmp drawWIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    
drawWIN:
;draw W
      mov cx,264
      mov dx,0
w1:
      inc dx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp dx, 60
      jne w1

      mov cx,284
      mov dx,40
      add dx,cx
      mov bx,dx
      sub dx,cx
      mov si,dx
      add si,20
w2:
      sub bx,dx
      mov cx,bx
      add bx,dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl w2

      mov cx,284
      mov dx,40
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,20
w3:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1110b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl w3

      mov cx,304
      mov dx,0
w4:
      inc dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp dx, 60
      jne w4

;draw I
      mov cx,280
      mov dx,70
i1:
      inc dx
      mov al,1110b
      mov ah, 0ch
      int 10h
      cmp dx, 130
      jne i1

;draw N
      mov cx,250
      mov dx,140
n1:
      inc dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp dx, 200
      jne n1

      mov cx,251
      mov dx,140
      sub dx,cx
      mov bx,dx
      add dx,cx
      mov si,dx
      add si,60
n2:
      sub dx,bx
      mov cx,dx
      add dx,bx
      mov al,1110b
      mov ah, 0ch
      int 10h
      inc dx
      cmp dx,si
      jl n2

      mov cx,310
      mov dx,140
n3:
      inc dx
      mov al,1010b
      mov ah, 0ch
      int 10h
      cmp dx, 200
      jne n3
      jmp kl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

arr: db '0','0','0','0','0','0','0','0','0'
arr2: db '0','0','0','0','0','0','0','0','0'
win: db '0'
x:dd 0
y:dd 0
a:dd 0
b:dd 0
r2:dd 100
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

kl:
 
Checkend:    
      in al,0x64
      and al,0x01
      jz Checkend
      in al,0x60
      cmp al,0x80
      ja Checkend
      cmp al,0x1C ;Enter (to rsest)
      je Restart
      jmp Checkend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
times (0x400000 - 512) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
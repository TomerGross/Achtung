IDEAL
P286
MODEL small
STACK 100h
DATASEG

;----------------------------------------
;SET THE WINNER POINTS/WHEN THE GAME END
;----------------------------------------

WinnerPoints dw 10

;----------------------------------------
;SET THE WINNER POINTS/WHEN THE GAME END
;----------------------------------------

color db 14
x dw 1
y dw 1

Xp1 dw 100                     ;location player 1
Yp1 dw 100
directionP1 db 1               ;direction player 1
ColorP1 db 4                   ;color of player 1
CountP1 dw 0                   ;points player 1

Xp2 dw 200                     ;location player 2
Yp2 dw 50
directionP2 db 1               ;direction player 2
ColorP2 db 10                  ;color of player 2
CountP2 dw 0                   ;points player 2


ScoreP1 db 'Fred: $'
ScoreP2 db 'Greenlee: $'
msg db 'Score $'

DelayHelper dw 2
DelayHelper2 dw 4
Dis db 0
Toggle db 0



;-------------------------------------
;BMP
;-------------------------------------

StartX equ [bp+18]
StartY equ [bp+16]
PicWidth equ [bp+14] 
PicHight equ [bp+12]
FileName equ [bp+4]
Header equ [bp+6]
PalleteStorage equ [bp+8]
BoardPicSaveSave equ [bp+10]
TrueHeader dw ?
TmpHeader db 54 dup (0)
Pallete db 1024 dup (0)
BoardPicSave db 200*320 dup (0)
BoardName2 db 'STASC.bmp'‚,0
BoardName3 db 'INSTSC.bmp',0
BoardName4 db 'FRW.bmp',0
BoardName5 db 'GRW.bmp',0

;--------------------------------------
;BMP
;-------------------------------------


;-------------------------------------
;TIMER
;-------------------------------------

Clock equ es:6Ch
StartMessage db 'Loading...',13,10,'$'
EndMessage db '...Stop.',13,10,'$'

;-------------------------------------
;TIMER
;-------------------------------------


CODESEG

proc Achtung1


push [DelayHelper]           
Loop1:
cmp [DelayHelper],0
je Continue5
mov cx,0DFFCh                    
Delay: 
;delay - doing delay to limit the speed of the player                               
loop Delay
dec [DelayHelper]
loop Loop1


Continue5:
pop [DelayHelper]


in al, 60h
cmp al,20h           ;check if the key D is pressed
je AddDirection1
cmp al,1Eh           ;check if the key A is pressed
jne CheckTheDirection1 
jmp SubDirection1

AddDirection1:         ;if the player press right(D)
cmp [directionP1],12
jne Continue
mov [directionP1],1
jmp End1
Continue:
inc [directionP1]
End1:
jmp CheckTheDirection1

SubDirection1:         ;if the player press left(A)
cmp [directionP1],1
jne Continue2
mov [directionP1],12
jmp End2
Continue2:
dec [directionP1]
End2:
jmp CheckTheDirection1


CheckTheDirection1:       ;check the last direction of the player (the last direction is save in the variable directionP1)
                          ;and then print the player accordingly his direction and his location
Label1p1:
cmp [directionP1],1
jne Label2p1
jmp direction1p1
Label2p1:
cmp [directionP1],2
jne Label3p1
jmp direction2p1
Label3p1:
cmp [directionP1],3
jne Label4p1
jmp direction3p1
Label4p1:
cmp [directionP1],4
jne Label5p1
jmp direction4p1
Label5p1:
cmp [directionP1],5
jne Label6p1
jmp  direction5p1
Label6p1:
cmp [directionP1],6
jne Label7p1
jmp  direction6p1
Label7p1:
cmp [directionP1],7
jne Label8p1
jmp  direction7p1
Label8p1:
cmp [directionP1],8
jne Label9p1
jmp  direction8p1
Label9p1:
cmp [directionP1],9
jne Label10p1
jmp  direction9p1
Label10p1:
cmp [directionP1],10
jne Label11p1
jmp  direction10p1
Label11p1:
cmp [directionP1],11
jne Label12p1
jmp  direction11p1
Label12p1:
cmp [directionP1],12
jmp  direction12p1


direction1p1:
 
sub [Yp1],2 
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1
  
xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2

jmp Return

direction2p1:

inc [Xp1]
sub [Yp1],2
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]


call Proc Pixel_2x2

jmp Return

direction3p1:
add [Xp1],2
dec [Yp1]
mov cx,[Xp1]
mov dx,[Yp1]

 call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2


jmp Return

direction4p1:
add [Xp1],2                 
mov cx,[Xp1]
mov dx,[Yp1]
call proc CheckForHit1
xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2 


jmp Return

direction5p1:
inc [Yp1]
add [Xp1],2
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1
xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2 


jmp Return

direction6p1:
inc [Xp1]
add [Yp1],2
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2 


jmp Return

direction7p1:
add [Yp1],2                       
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2

jmp Return

direction8p1:
dec [Xp1]
add [Yp1],2
mov cx,[Xp1]
mov dx,[Yp1]

 call proc CheckForHit1
 
xor bh,bh
mov al,[ColorP1]


call Proc Pixel_2x2


jmp Return

direction9p1:
sub [Xp1],2
inc [Yp1]
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2

jmp Return

direction10p1:
sub [Xp1],2                    
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2

jmp Return

direction11p1:
sub [Xp1],2
dec [Yp1]
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2

jmp Return

direction12p1:
dec [Xp1]
sub [Yp1],2
mov cx,[Xp1]
mov dx,[Yp1]

call proc CheckForHit1

xor bh,bh
mov al,[ColorP1]

call Proc Pixel_2x2
jmp Return


Return:
ret
endp Achtung1

;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------

proc Achtung2

push [DelayHelper]
Loop2:
cmp [DelayHelper],0
je Continue6
mov cx,0DFFCh
Delay2:
;delay
loop Delay2
dec [DelayHelper]
loop Loop2

Continue6:
pop [DelayHelper]


in al, 60h
cmp al,4Dh          ;check if the key ----> is pressed
je AddDirection2
cmp al,4Bh          ;check if the key <---- is pressed
jne CheckTheDirection2
jmp SubDirection2

AddDirection2:          ;if the player press right(--->)
cmp [directionP2],12
jne Continue3
mov [directionP2],1
jmp End3
Continue3:
inc [directionP2]
End3:
jmp CheckTheDirection2

SubDirection2:         ;if the player press left(<---)
cmp [directionP2],1
jne Continue4
mov [directionP2],12
jmp End4
Continue4:
dec [directionP2]
End4:
jmp CheckTheDirection2


CheckTheDirection2:       ;check the last direction of the player (the last direction is save in the variable directionP2)
                          ;and then print the player accordingly his direction and his location
Label1p2:
cmp [directionP2],1
jne Label2p2
jmp direction1p2
Label2p2:
cmp [directionP2],2
jne Label3p2
jmp direction2p2
Label3p2:
cmp [directionP2],3
jne Label4p2
jmp direction3p2
Label4p2:
cmp [directionP2],4
jne Label5p2
jmp direction4p2
Label5p2:
cmp [directionP2],5
jne Label6p2
jmp  direction5p2
Label6p2:
cmp [directionP2],6
jne Label7p2
jmp  direction6p2
Label7p2:
cmp [directionP2],7
jne Label8p2
jmp  direction7p2
Label8p2:
cmp [directionP2],8
jne Label9p2
jmp  direction8p2
Label9p2:
cmp [directionP2],9
jne Label10p2
jmp  direction9p2
Label10p2:
cmp [directionP2],10
jne Label11p2
jmp  direction10p2
Label11p2:
cmp [directionP2],11
jne Label12p2
jmp  direction11p2
Label12p2:
cmp [directionP2],12
jmp  direction12p2


direction1p2:
sub [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
 
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2

jmp Return2

direction2p2:

inc [Xp2]
sub [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]


call Proc Pixel_2x2

jmp Return2

direction3p2:
add [Xp2],2
dec [Yp2]
mov cx,[Xp2]
mov dx,[Yp2]

call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2


jmp Return2

direction4p2:
add [Xp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2 


jmp Return2

direction5p2:
inc [Yp2]
add [Xp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2 


jmp Return2

direction6p2:
inc [Xp2]
add [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2 


jmp Return2

direction7p2:
add [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2

jmp Return2

direction8p2:
dec [Xp2]
add [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]


call Proc Pixel_2x2


jmp Return2

direction9p2:
sub [Xp2],2
inc [Yp2]
mov cx,[Xp2]
mov dx,[Yp2]

call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2

jmp Return2

direction10p2:
sub [Xp2],2
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2

jmp Return2

direction11p2:
sub [Xp2],2
dec [Yp2]
mov cx,[Xp2]
mov dx,[Yp2]

 call proc CheckForHit2
 
xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2

jmp Return2

direction12p2:
dec [Xp2]
sub [Yp2],2
mov cx,[Xp2]
mov dx,[Yp2]

call proc CheckForHit2

xor bh,bh
mov al,[ColorP2]

call Proc Pixel_2x2
jmp Return2


Return2:
ret
endp Achtung2


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc CheckForHit1
mov  ah,0Dh 
int  10h ; return al the pixel value read
cmp al,0
jne EndOfTheRound
jmp Return3


EndOfTheRound:    
                                ;if player 1 disqualified so the number 1 save in the variable Dis that responsible 
                                ;about the num of the player that disqualified
mov [Dis],1			   
			   
Return3:
ret
endp CheckForHit1


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc CheckForHit2
mov  ah,0Dh 
int  10h ; return al the pixel value read
cmp al,0
jne EndOfTheRound2
jmp Return4

EndOfTheRound2:
                                ;if player 2 disqualified so the number 2 save in the variable Dis that responsible 
                                ;about the num of the player that disqualified
mov [Dis],2

Return4:
ret
endp CheckForHit2


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc Pixel_2x2
                    ;this proc responsible about the thickness of the player
                    ;(print 2*2 pixels accordingly the player direction and location)					
                                
mov bh,0h 
mov ah,0ch 
int 10h 

sub cx,1
mov bh,0h 
mov ah,0ch
int 10h

sub dx,1
mov bh,0h 
mov ah,0ch
int 10h

add cx,1
mov bh,0h 
mov ah,0ch
int 10h
ret
endp Pixel_2x2


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc PrintBMP
push bp
mov bp, sp
mov dx, FileName
call OpenFile
mov [TrueHeader], ax
mov bx, ax
mov bx, [TrueHeader]
mov dx, Header
Call ReadHeader
mov dx, PalleteStorage
call ReadPallete
mov si,dx
call CopyPallete
mov dx, BoardPicSaveSave
cld
call CopyToMemory
mov bx, [TrueHeader]
call CloseFile
mov dx,BoardPicSaveSave
cld
call TakeFromMemory

pop bp
ret  16D
endp PrintBMP


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc CloseFile
  mov ah,3Eh
  int 21h
  ret
endp CloseFile


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc CopyPallete
pusha
mov cx, 256
mov dx,3c8h
mov al,0
out dx, al
inc dx
PalletLoop:
mov al, [si+2]
shr al,2
out dx,al
 mov al,[si+1] ; Get green value.
  shr al,2
  out dx,al ; Send it.
  mov al,[si] ; Get blue value.
  shr al,2
  out dx,al ; Send it.
  add si,4 ; Point to next color.
  loop PalletLoop
popa
ret
endp CopyPallete


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc OpenFile
clc
mov ah,3dh
xor al,al
int 21h
jc ErrorOpening
jmp FinishedOpening
ErrorOpening:
mov ax,0
FinishedOpening:
ret 
endp OpenFile



;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc ReadHeader
pusha
mov ah, 3fh
mov cx,54
int 21h
popa
ret
endp ReadHeader
proc ReadPallete
pusha
mov ah,3fh
mov cx, 400h
int 21h
popa
ret
endp ReadPallete


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc CopyToMemory
pusha
push ax
mov ax, PicHight
push dx
push bx
mov bx, 320
mul bx
pop bx
pop dx

add dx,ax
pop ax
sub dx, 320
xor si,si
xor cx,cx
mov si, PicHight

ReadLine:
mov cx, PicWidth
mov ax, 03f00h
int 21h
sub dx,320
dec si
cmp si,0
jne ReadLine
popa
ret
endp CopyToMemory


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc TakeFromMemory
pusha
xor di,di
mov si, BoardPicSaveSave   ;from
mov ax,0A000h
mov es, ax       ;too segment es 
push ax
mov ax, StartY
push bx
mov bx,320
mul bx
pop bx
add di, ax       ;from offset
pop ax
add di, StartX
mov cx,PicHight
CopyToVideoMemory:
push cx
mov cx,PicWidth
cld
rep movsb
pop cx
add di,320
sub di,PicWidth
add si, 320
sub si, PicWidth

loop CopyToVideoMemory
popa
ret
endp TakeFromMemory


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc RefreshScoreP1
                           ;the proc print the score of player 1 + his name on the screen
    mov ax,[CountP1]
	add ax,'0'
	mov [ScoreP1+5],al
	
	lea dx,[ScoreP1]
	mov ah,09h
	int 21h
	
	
ret
endp RefreshScoreP1


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc RefreshScoreP2
                           ;the proc print the score of player 2 + his name on the screen
	mov ax,[CountP2]
	add ax,'0'
	mov [ScoreP2+9],al
	
	lea dx,[ScoreP2]
	mov ah,09h
	int 21h
	
	
ret
endp RefreshScoreP2


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc GameMenu
                           ;the proc print the word 'SCORE' on the screen
	lea dx,[msg]
	mov ah,09h
	int 21h
	
ret
endp GameMenu


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc ResetCursor1
                           ;the proc reset the location of player 1 name + his points on the screen
 push ax bx dx
 mov dh,6 
 mov dl,29
 mov bh,0
 mov ah,2
 int 10h
 pop dx bx ax
 ret
endp ResetCursor1


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc ResetCursor2
                          ;the proc reset the location of player 2 name + his points on the screen
push ax bx dx
 mov dh,8
 mov dl,29
 mov bh,0
 mov ah,2
 int 10h
 pop dx bx ax
 ret
endp ResetCursor2


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc ResetCursor3
                          ;the proc reset the location of the word 'SCORE' on the screen
 push ax bx dx
 mov dh,2
 mov dl,29
 mov bh,0
 mov ah,2
 int 10h
 pop dx bx ax
 ret
endp ResetCursor3


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc Frame
                              ;the proc print the frame of the game
push ax
push bx
push cx
push dx
push [x]
push [y]



mov al,[color]
mov bl,0

mov cx,320

LineUp:
mov al,[color]
mov bl,0

mov cx,320
Line:
cmp cx,0
je LineDown
push cx
mov cx,[x]
mov dx,[y]

call proc Pixel_2x2

pop cx
;move pixel right
inc [x]

loop Line




LineDown:

mov [y],199
mov [x],0
mov al,[color]
mov bl,0
mov cx,320

Line2:
cmp cx,0
je CollumeLeft
push cx
mov cx,[x]
mov dx,[y]

call proc Pixel_2x2
pop cx
;move pixel right
inc [x]

loop Line2


CollumeLeft:
mov al,[color]
mov bl,0
mov [x],1
mov [y],1

mov cx,200
Collume:
cmp cx,0
je CollumeRight
push cx
mov cx,[x]
mov dx,[y]

call proc Pixel_2x2

pop cx
;move pixel right
inc [y]

loop Collume


CollumeRight:
mov al,[color]
mov bl,0
mov [x],319
mov [y],0

mov cx,200
Collume2:
cmp cx,0
je Next
push cx
mov cx,[x]
mov dx,[y]

call proc Pixel_2x2
pop cx
;move pixel right
inc [y]

loop Collume2

Next:

mov al,[color]
mov bl,0
mov [x],225
mov [y],0

mov cx,200
Collume3:
cmp cx,0
je Return5
push cx
mov cx,[x]
mov dx,[y]

call proc Pixel_2x2

pop cx
;move pixel right
inc [y]

loop Collume3


Return5:
pop [y]
pop [x]
pop dx
pop cx
pop bx
pop ax

ret
endp Frame


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc ResetPlayers
                        ;the proc reset the direction of the player to 1 and his location to his start location
	mov [directionP1],1
	mov [directionP2],1
    mov [Xp1],100
	mov [Yp1],100
	mov [Xp2],200
	mov [Yp2],50

ret
endp ResetPlayers


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc DelayHelp
                        ;the proc doing delay

push [DelayHelper2]
Loop3:
cmp [DelayHelper2],0
je Continue9
mov cx,0FFFFh
Delay3:
;delay
loop Delay3
dec [DelayHelper2]
loop Loop3


Continue9:
pop [DelayHelper2]


ret
endp DelayHelp


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------


proc WaitForKeyPressed
                             ;the proc wait from the user to press on the space-bar
StartOfProc:
call Proc DelayHelp
in al,60h
cmp al,0B9h
jne StartOfProc

ret
endp WaitForKeyPressed


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------



proc Timer
                           ;the proc wait 3 sec to continue the plan
mov ax, 40h
mov es, ax
mov ax, [Clock]
FirstTick:
cmp ax, [Clock]
je FirstTick
; print start message
mov dx, offset StartMessage
mov ah, 9h
int 21h
; count 10 sec
mov cx, 55 ; 54.5x0.055sec = ~3sec
DelayLoop:
mov ax, [Clock]
Tick:
cmp ax, [Clock]
je Tick
loop DelayLoop
; print end message
mov dx, offset EndMessage
mov ah, 9h
int 21h

ret
endp Timer


;------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------



start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here
; --------------------------

STARTSCREEN:
	
	mov ax, 13h  ;to delete the last screen
    int 10h
	
	push 0 ;x
	push 0   ;y
	push 320  ;width
	push 200  ;hight
	push offset BoardPicSave
	push offset Pallete
	push offset TmpHeader
	push offset BoardName2
	call PrintBMP
	
	WaitForKey:
	
	in al, 64h   ;check for new key
	cmp al, 10b
	je WaitForKey
	in al,60h
	cmp al,17h    ;check if the key I is pressed   - instructions
	je INSTRUCTIONS_SCREEN
	cmp al,1h      ;check if the key ESC is pressed - exit
	jne Continue7
	jmp exit
	Continue7:
	cmp al,1Fh     ;check if the the key S is pressed  - start
	je Game
	jmp WaitForKey
	
	
	
INSTRUCTIONS_SCREEN:	     
	push 0 ;x
	push 0   ;y
	push 320  ;width
	push 200  ;hight
	push offset BoardPicSave
	push offset Pallete
	push offset TmpHeader
	push offset BoardName3
	call PrintBMP              ;print instruction screen

	
	WaitForBack:
	in al, 64h   ;check for new key
	cmp al, 10b
	je WaitForBack
	in al,60h
	cmp al,30h           ;check if the key B is pressed - back to the start menu
	je STARTSCREEN
	jmp WaitForBack
	
Game:	
	mov ax, 13h
	int 10h
	call Proc Frame        ;print the frame
	mov [CountP1],0           ;reset the score
	mov [CountP2],0
    call Proc ResetPlayers
	
	
InfinityLoop:

	in al, 60h
	cmp al,81h              ;check if button esc is up - if yes so back to the start screen
	je STARTSCREEN
	cmp al,39h              ;check if the key Space is pressed - to pause the game
	je Pause1
	jmp Continue8
	
	Pause1:
	in al,60h
	cmp al,81h              ;check if the key esc is pressed - exit the game
	jne Next3
	jmp STARTSCREEN
	
	Next3:
	
	cmp al,0B9h        ;check if the key Space is up 
	jne Pause1
	
	Next2:
	
	call Proc DelayHelp
	
	in al,60h
	cmp al,1               ;check if the key esc is pressed - exit the game
	jne Next4
	jmp STARTSCREEN
	
	Next4:
	cmp al,39h        ;check if the key space is pressed another time to resume the game         
	jne Next2
	
	Continue8:
	call proc ResetCursor1	
	call proc RefreshScoreP1
	call proc ResetCursor2
	call proc RefreshScoreP2
	call proc ResetCursor3
	call proc GameMenu
	
	
	call Proc Achtung1
	call Proc Achtung2

	cmp [Dis],1                ;check if one of the players disqualified
	je AddP2
	cmp [Dis],2
	jne TheGameContinue

AddP1:	      ;if player 2 disqualified
	
	inc [CountP1]		
	
	mov ax, 13h
	int 10h
	
	call Proc ResetPlayers
	call proc Frame
	call proc ResetCursor1	
	call proc RefreshScoreP1
	call proc ResetCursor2
	call proc RefreshScoreP2
	call proc ResetCursor3
	call proc GameMenu
	call proc WaitForKeyPressed

jmp TheGameContinue	
	
AddP2:        ;if player 1 disqualified	         

	inc [CountP2]	
    
	mov ax, 13h
	int 10h
	
	call Proc ResetPlayers
	call proc Frame
	call proc ResetCursor1	
	call proc RefreshScoreP1
	call proc ResetCursor2
	call proc RefreshScoreP2
	call proc ResetCursor3
	call proc GameMenu
	call proc WaitForKeyPressed
	
jmp TheGameContinue
	
TheGameContinue:
mov [Dis],0



mov ax,[WinnerPoints]  ;mov to ax the sum of the points that player need to win
cmp [CountP1],ax
je fredwin	
cmp [CountP2],ax
je greenleewin	


	
jmp InfinityLoop


fredwin:
	
	mov ax, 13h
	int 10h
	
	push 0 ;x
	push 0   ;y
	push 320  ;width
	push 200  ;hight
	push offset BoardPicSave
	push offset Pallete
	push offset TmpHeader
	push offset BoardName4
	call PrintBMP          ;print winner screen of fred / player1
		
	call proc Timer
	
jmp STARTSCREEN


greenleewin:
	
	mov ax, 13h
	int 10h
	
	push 0 ;x
	push 0   ;y
	push 320  ;width
	push 200  ;hight
	push offset BoardPicSave
	push offset Pallete
	push offset TmpHeader
	push offset BoardName5
	call PrintBMP           ;print winner screen of greenlee / player2
	
	call proc Timer


jmp STARTSCREEN


exit:
	mov ax, 4c00h
	int 21h
END start



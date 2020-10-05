;вар 10
format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        strNumber db 'Number from 1 to 100: ', 0
        strNextNumber db '[%d] = ', 0
        Result db 10, 13, '[%d] = ', 0
        ResStr db '%d', 0
        spaceStr db ' %d', 0
        emptyStr db '%d', 0
        mass rd 101
        massB rd 101
        Number dd ?
        tmp dd ?
        Null = 0

section '.code' code readable executable
        start:
                push strNumber
                call [printf]


                push Number
                push emptyStr
                call [scanf]


                mov ebx, 0
                for:
                        mov edx, ebx
                        push edx
                        push strNextNumber
                        call [printf]

                        mov edx, tmp
                        push edx
                        push spaceStr
                        call[scanf]

                        mov ecx, [tmp]
                        mov [mass + 4 * ebx], ecx

                        inc ebx
                        cmp ebx, [Number]
                jne for



                mov ebx, [Number]
                sub ebx, 1
                for2:
                        mov ecx, [Number]
                        sub ecx, ebx
                        sub ecx, 2
                        inc ecx

                        mov ecx, [mass + 4 * ebx]
                        cinvoke printf, spaceStr, ecx

                        sub ebx, 1
                        cmp ebx, -1
                jg for2



                call [getch]

                push Null
                call [ExitProcess]


section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel, \
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'
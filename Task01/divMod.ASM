format PE Console        ; output type - console

entry start              ; code start point

include 'win32a.inc'

section '.data' data readable writable

        str1 db 'Enter the first number: ', 0
        str2 db 'Enter the second number: ', 0
        strRes db 'Result: %d', 0
        strSpace db ' %d', 0
        strZeroDiv db 'Zero division error!', 0
        strMod db '/%d', 0

        A dd ?
        B dd ?
        C dd ?

section '.code' code readable executable

        start:

        push str1
        call [printf]

        push A
        push strSpace
        call [scanf]                 ; entering the numerator

        push str2
        call [printf]

        push B
        push strSpace
        call [scanf]                 ; entering denominator

        mov eax, [A]
        mov ecx, [B]
        mov edx, 0

        cmp [B], 0
        jne notZeroDiv
            push strZeroDiv
            call [printf]

            jmp finish
            notZeroDiv:

            div ecx
            mov [C], edx

            push eax
            push strRes
            call [printf]

            push [C]
            push strSpace
            call [printf]

            push [B]
            push strMod
            call [printf]

            jmp finish

        push ecx
        push strRes
        call[printf]                 ; show result

        jmp finish

        finish:                      ; finishing program

        call [getch]

        push 0
        call [ExitProcess]

section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'

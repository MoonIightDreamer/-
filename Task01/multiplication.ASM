format PE Console        ; формат вывода - консоль

entry start              ; точка начала кода

include 'win32a.inc'

section '.data' data readable writable

        str1 db 'Enter the first number: ', 0
        str2 db 'Enter the second number: ', 0
        strRes db 'Result: %d', 0
        strSpace db ' %d', 0

        A dd ?
        B dd ?

section '.code' code readable executable

        start:

        push str1
        call [printf]

        push A
        push strSpace
        call [scanf]                 ; ввод 1-го множителя

        push str2
        call [printf]

        push B
        push strSpace
        call [scanf]                 ; ввод 2-го множителя

        mov ecx, [A]
        imul ecx, [B]                 ; умножение (в случае imul - знаковое. для беззнакового используется mul)

        push ecx
        push strRes
        call[printf]                 ; вывод результата

        jmp finish

        finish:                      ; конец программы

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
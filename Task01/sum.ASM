;ïðîãðàììà, ñóììèðóþùàÿ äâà ââåäåííûõ ïîëüçîâàòåëåì ÷èñëà
format PE Console        ; ôîðìàò âûâîäà - êîíñîëü

entry start              ; òî÷êà íà÷àëà êîäà

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
        call [scanf]                 ; ââîä 1-ãî ñëàãàåìîãî

        push str2
        call [printf]

        push B
        push strSpace
        call [scanf]                 ; ââîä 2-ãî ñëàãàåìîãî

        mov ecx, [A]
        add ecx, [B]                 ; ñóììèðîâàíèå

        push ecx
        push strRes
        call[printf]                 ; âûâîä ðåçóëüòàòà

        jmp finish

        finish:                      ; êîíåö ïðîãðàììû

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

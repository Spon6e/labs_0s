org 0x7C00

start:
    mov ax, 0x03        ; Текстовый режим 
    int 0x10
    
    lea si, privet ; Вывод приветственного сообщения
    call print

    lea si, next_str ; Делаю некст строку
    call print

    lea si, vvedi_name ; Спраштваю имя
    call print

    
    mov di, bff ; Читаю имя

chitau_ima:
    call chitau_simvol
    cmp al, 0x0D        ; Проверка на Enter
    je zapisal_ima
    stosb               ; Сохраняем символ (записывает байт из регистра AL в память)
    call vivozhu_simvol
    jmp chitau_ima

zapisal_ima:
    mov byte [di], 0    ; Завершаем строку
    lea si, next_str    ; Делаю некст строку
    call print
    
    lea si, Hi      ; Приветствие с именем
    call print

    lea si, bff
    call print
    lea si, next_str
    call print
    ; Запрос действия
    lea si, prodolzh
    call print

cho_skaz:
    call chitau_simvol

    
    cmp al, 'y'; Смотрим что по ответу
    je skaz_yes
    cmp al, 'n'
    je skaz_no

    
    lea si, figna; ЕЩЕ РАЗ
    call print
    lea si, next_str
    call print
    lea si, prodolzh
    call print
    jmp cho_skaz

skaz_yes:
    lea si, da_b
    call print
    jmp halt

skaz_no:
    lea si, NT
    call print
    jmp halt

halt:
    cli
    hlt ;Заканчиваем вообще все(спрерывания офнуты, поэтому ждем перезагрузки)

print: ; Принтую строку
    mov ah, 0x0E

sled_bukva:
    lodsb               ;Загружаем символ из строки
    cmp al, 0
    je nisy
    int 0x10
    jmp sled_bukva

nisy:
    ret
    
chitau_simvol:  ; Считываю символ с клавиатуры
    xor ah, ah
    int 0x16    ; Прерывание для ввода символа(клава)
    ret

vivozhu_simvol:    ; Вывод одного символа
    mov ah, 0x0E
    int 0x10        ; Прерывание для вывода символа
    ret

; Данные
privet db 'Hello, its my OS!', 0
vvedi_name db 'Enter your name: ', 0
Hi db 'Hi, ', 0
next_str db 0x0D, 0x0A, 0
prodolzh db 'Postavite 5? (y/n): ', 0
da_b db 'Nice, thk.', 0
NT db 'You, nepravi.', 0
figna db 'Budu schitat, chto eto yes, no peresproshu.', 0
bff db 32 dup(0)

; Заполнение до 512 байт
times 510-($-$$) db 0
dw 0xAA55

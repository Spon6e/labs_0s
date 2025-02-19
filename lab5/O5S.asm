org 0x7C00
start:
    ; Очистка экрана
    mov ax, 0x03        ; Текстовый режим 80x25
    int 0x10

    ; Вывод приветственного сообщения
    lea si, welcome_msg
    call print

    lea si, newline_msg
    call print

    ; Запрос имени
    lea si, name_prompt
    call print

    ; Чтение имени
    mov di, name_buffer
.read_name:
    call read_key
    cmp al, 0x0D        ; Проверка на Enter
    je .name_done
    stosb               ; Сохраняем символ
    call print_char
    jmp .read_name
.name_done:
    mov byte [di], 0    ; Завершаем строку
    lea si, newline_msg
    call print
    ; Приветствие с именем
    lea si, hello_msg
    call print

    lea si, name_buffer
    call print
    lea si, newline_msg
    call print
    ; Запрос действия
    lea si, action_prompt
    call print

.read_action:
    call read_key

    ; Обработка ответа
    cmp al, 'y'
    je .yes_response
    cmp al, 'n'
    je .no_response

    ; Некорректный ввод - повторно задаем вопрос
    lea si, invalid_msg
    call print
    lea si, newline_msg
    call print
    lea si, action_prompt
    call print
    jmp .read_action

.yes_response:
    lea si, yes_msg
    call print
    jmp halt

.no_response:
    lea si, no_msg
    call print
    jmp halt

halt:
    cli
    hlt

; Функция вывода строки
print:
    mov ah, 0x0E
.next_char:
    lodsb               ; Загружаем символ из строки
    cmp al, 0
    je .done
    int 0x10
    jmp .next_char
.done:
    ret
    ; Функция чтения символа с клавиатуры
read_key:
    xor ah, ah
    int 0x16
    ret

; Вывод одного символа
print_char:
    mov ah, 0x0E
    int 0x10
    ret

; Данные
welcome_msg db 'Welcome to mini-OS!', 0
name_prompt db 'Enter your name: ', 0
hello_msg db 'Hello, ', 0
newline_msg db 0x0D, 0x0A, 0
action_prompt db 'Continue? (y/n): ', 0
yes_msg db 'You choose to continue.', 0
no_msg db 'You choose to exit.', 0
invalid_msg db 'Invalid input.', 0
name_buffer db 32 dup(0)

; Заполнение до 512 байт
times 510-($-$$) db 0
dw 0xAA55

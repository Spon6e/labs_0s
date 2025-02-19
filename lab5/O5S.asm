org 0x7C00
start:
    ; ������� ������
    mov ax, 0x03        ; ��������� ����� 80x25
    int 0x10

    ; ����� ��������������� ���������
    lea si, welcome_msg
    call print

    lea si, newline_msg
    call print

    ; ������ �����
    lea si, name_prompt
    call print

    ; ������ �����
    mov di, name_buffer
.read_name:
    call read_key
    cmp al, 0x0D        ; �������� �� Enter
    je .name_done
    stosb               ; ��������� ������
    call print_char
    jmp .read_name
.name_done:
    mov byte [di], 0    ; ��������� ������
    lea si, newline_msg
    call print
    ; ����������� � ������
    lea si, hello_msg
    call print

    lea si, name_buffer
    call print
    lea si, newline_msg
    call print
    ; ������ ��������
    lea si, action_prompt
    call print

.read_action:
    call read_key

    ; ��������� ������
    cmp al, 'y'
    je .yes_response
    cmp al, 'n'
    je .no_response

    ; ������������ ���� - �������� ������ ������
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

; ������� ������ ������
print:
    mov ah, 0x0E
.next_char:
    lodsb               ; ��������� ������ �� ������
    cmp al, 0
    je .done
    int 0x10
    jmp .next_char
.done:
    ret
    ; ������� ������ ������� � ����������
read_key:
    xor ah, ah
    int 0x16
    ret

; ����� ������ �������
print_char:
    mov ah, 0x0E
    int 0x10
    ret

; ������
welcome_msg db 'Welcome to mini-OS!', 0
name_prompt db 'Enter your name: ', 0
hello_msg db 'Hello, ', 0
newline_msg db 0x0D, 0x0A, 0
action_prompt db 'Continue? (y/n): ', 0
yes_msg db 'You choose to continue.', 0
no_msg db 'You choose to exit.', 0
invalid_msg db 'Invalid input.', 0
name_buffer db 32 dup(0)

; ���������� �� 512 ����
times 510-($-$$) db 0
dw 0xAA55

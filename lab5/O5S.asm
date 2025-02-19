org 0x7C00

start:
    mov ax, 0x03        ; ��������� ����� 
    int 0x10
    
    lea si, privet ; ����� ��������������� ���������
    call print

    lea si, next_str ; ����� ����� ������
    call print

    lea si, vvedi_name ; ��������� ���
    call print

    
    mov di, bff ; ����� ���

chitau_ima:
    call chitau_simvol
    cmp al, 0x0D        ; �������� �� Enter
    je zapisal_ima
    stosb               ; ��������� ������ (���������� ���� �� �������� AL � ������)
    call vivozhu_simvol
    jmp chitau_ima

zapisal_ima:
    mov byte [di], 0    ; ��������� ������
    lea si, next_str    ; ����� ����� ������
    call print
    
    lea si, Hi      ; ����������� � ������
    call print

    lea si, bff
    call print
    lea si, next_str
    call print
    ; ������ ��������
    lea si, prodolzh
    call print

cho_skaz:
    call chitau_simvol

    
    cmp al, 'y'; ������� ��� �� ������
    je skaz_yes
    cmp al, 'n'
    je skaz_no

    
    lea si, figna; ��� ���
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
    hlt ;����������� ������ ���(����������� ������, ������� ���� ������������)

print: ; ������� ������
    mov ah, 0x0E

sled_bukva:
    lodsb               ;��������� ������ �� ������
    cmp al, 0
    je nisy
    int 0x10
    jmp sled_bukva

nisy:
    ret
    
chitau_simvol:  ; �������� ������ � ����������
    xor ah, ah
    int 0x16    ; ���������� ��� ����� �������(�����)
    ret

vivozhu_simvol:    ; ����� ������ �������
    mov ah, 0x0E
    int 0x10        ; ���������� ��� ������ �������
    ret

; ������
privet db 'Hello, its my OS!', 0
vvedi_name db 'Enter your name: ', 0
Hi db 'Hi, ', 0
next_str db 0x0D, 0x0A, 0
prodolzh db 'Postavite 5? (y/n): ', 0
da_b db 'Nice, thk.', 0
NT db 'You, nepravi.', 0
figna db 'Budu schitat, chto eto yes, no peresproshu.', 0
bff db 32 dup(0)

; ���������� �� 512 ����
times 510-($-$$) db 0
dw 0xAA55

org 0x7C00 ; �����, ���� BIOS ��������� ����������� ������

start:
	mov si, mes ; ��������� ����� ������ message � ������� SI (SI - ��������� �� ������� ������ ������)
	mov ah, 0x0e ; ������������� � �������� AH �������� 0x0E ��� ������ ������� �� ����� 

cycle1:
	lodsb  ; ��������� ���� �� ������, �� ������� ��������� SI, � ������� AL (SI ������������� �� 1, ����� ��������� �� ���� ������)
	test al, al  ; ���������, ����� �� ���� � �������� AL ���� (����� ������)
	jz cycle1_exit ;���� ���� � AL ����� 0, ����������� ������� � cycle1_exit
	int 0x10 ; ���������� BIOS ��� ������ �������
	jmp cycle1 ; ����������� ������� ������� � cycle1, ��� ��������� ���� �������

cycle1_exit:
	jmp $ ; ����������� ���� ��� ��������� ���������� ��������� 

mes:
	db '  ___    __        __   __   __           __   __   ', 10, 13, '   //   /  \ |    /  \ |__) /  \ \  /    /  \ /__`  ', 10, 13, '  //_   \__/ |___ \__/ |__) \__/  \/     \__/ .__/ ', 0

finish:
	times 510 - ($ - $$) db 0 ; ��������� ���������� ������������ ������������ ������� ������
	dw 0xaa55  ; ��������� ������������, ��� ������ ������ �������� �����������

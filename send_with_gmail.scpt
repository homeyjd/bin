FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .GURLGURLnull��� ��� TEXT 	 o      ���� 0 this_url this_URL��    k     � 
 
     l     ��  ��    K E When the link is clicked in thewebpage, this handler will be passed      �   �   W h e n   t h e   l i n k   i s   c l i c k e d   i n   t h e w e b p a g e ,   t h i s   h a n d l e r   w i l l   b e   p a s s e d        l     ��  ��    5 / the URL that triggered the action, similar to:     �   ^   t h e   U R L   t h a t   t r i g g e r e d   t h e   a c t i o n ,   s i m i l a r   t o :      l     ��  ��    B <> yourURLProtocol://yourBundleIdentifier?key=value&key=value     �   x >   y o u r U R L P r o t o c o l : / / y o u r B u n d l e I d e n t i f i e r ? k e y = v a l u e & k e y = v a l u e      l     ��������  ��  ��        l     ��  ��      EXTRACT ARGUMENTS     �     $   E X T R A C T   A R G U M E N T S   ! " ! r      # $ # l    	 %���� % I    	���� &
�� .sysooffslong    ��� null��   & �� ' (
�� 
psof ' m     ) ) � * *  ? ( �� +��
�� 
psin + o    ���� 0 this_url this_URL��  ��  ��   $ o      ���� 0 x   "  , - , r     . / . n     0 1 0 7   �� 2 3
�� 
ctxt 2 m    ����   3 l    4���� 4 \     5 6 5 o    ���� 0 x   6 m    ���� ��  ��   1 o    ���� 0 this_url this_URL / l      7���� 7 o      ���� 	0 email  ��  ��   -  8 9 8 r    + : ; : n    ) < = < 7    )�� > ?
�� 
ctxt > l  ! % @���� @ [   ! % A B A o   " #���� 0 x   B m   # $���� ��  ��   ? m   & (������ = o    ���� 0 this_url this_URL ; l      C���� C o      ���� 0 argument_string  ��  ��   9  D E D r   , 1 F G F m   , - H H � I I  & G n      J K J 1   . 0��
�� 
txdl K 1   - .��
�� 
ascr E  L M L r   2 7 N O N n   2 5 P Q P 2   3 5��
�� 
citm Q l  2 3 R���� R o   2 3���� 0 argument_string  ��  ��   O o      ���� 0 these_arguments   M  S T S r   8 = U V U m   8 9 W W � X X   V n      Y Z Y 1   : <��
�� 
txdl Z 1   9 :��
�� 
ascr T  [ \ [ l  > >��������  ��  ��   \  ] ^ ] l  > >�� _ `��   _   PROCESS ACTIONS    ` � a a     P R O C E S S   A C T I O N S ^  b c b l  > >�� d e��   d I C This loop will execute scripts located within the Resources folder    e � f f �   T h i s   l o o p   w i l l   e x e c u t e   s c r i p t s   l o c a t e d   w i t h i n   t h e   R e s o u r c e s   f o l d e r c  g h g l  > >�� i j��   i F @ of this applet depending on the key and value passed in the URL    j � k k �   o f   t h i s   a p p l e t   d e p e n d i n g   o n   t h e   k e y   a n d   v a l u e   p a s s e d   i n   t h e   U R L h  l m l Y   > � n�� o p�� n k   L � q q  r s r r   L R t u t n   L P v w v 4   M P�� x
�� 
cobj x o   N O���� 0 i   w o   L M���� 0 these_arguments   u o      ���� 0 	this_pair   s  y z y r   S X { | { m   S T } } � ~ ~  = | n       �  1   U W��
�� 
txdl � 1   T U��
�� 
ascr z  � � � s   Y m � � � n   Y \ � � � 2   Z \��
�� 
citm � o   Y Z���� 0 	this_pair   � J       � �  � � � o      ���� 0 this_key   �  ��� � o      ���� 0 
this_value  ��   �  � � � r   n s � � � m   n o � � � � �   � n      � � � 1   p r��
�� 
txdl � 1   o p��
�� 
ascr �  ��� � Z   t � � ����� � =  t w � � � o   t u���� 0 this_key   � m   u v � � � � �  s u b j e c t � r   z } � � � o   z {���� 0 
this_value   � o      ���� 0 subject  ��  ��  ��  �� 0 i   o m   A B����  p l  B G ����� � I  B G�� ���
�� .corecnte****       **** � o   B C���� 0 these_arguments  ��  ��  ��  ��   m  � � � l  � ���������  ��  ��   �  � � � I  � ��� ���
�� .sysodlogaskr        TEXT � b   � � � � � m   � � � � � � �  O p e n i n g   u r l   � o   � ����� 	0 email  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � "  Open in default web browser    � � � � 8   O p e n   i n   d e f a u l t   w e b   b r o w s e r �  � � � I  � ��� ���
�� .sysoexecTEXT���     TEXT � b   � � � � � b   � � � � � m   � � � � � � � v o p e n   " h t t p s : / / m a i l . g o o g l e . c o m / m a i l ? v i e w = c m & t f = 0 & t o = `   e c h o   " � n   � � � � � 1   � ���
�� 
strq � o   � ����� 	0 email   � m   � � � � � � � l "   |   s e d   ' s / m a i l t o : \ ( . * \ ) / \ 1 / '   |   s e d   ' s / \ & . * / / '   ` & f s = 1 "��   �  ��� � l  � ���������  ��  ��  ��     � � � l     ��������  ��  ��   �  � � � i     � � � I      �� ����� 0 run_scriptfile   �  ��� � o      ���� 0 this_scriptfile  ��  ��   � k      � �  � � � l     �� � ���   � / ) This handler will execute a script file     � � � � R   T h i s   h a n d l e r   w i l l   e x e c u t e   a   s c r i p t   f i l e   �  � � � l     �� � ���   � 5 / located in the Resources folder of this applet    � � � � ^   l o c a t e d   i n   t h e   R e s o u r c e s   f o l d e r   o f   t h i s   a p p l e t �  ��� � Q      � � � � k     � �  � � � r    
 � � � I   �� ���
�� .sysorpthalis        TEXT � o    ���� 0 this_scriptfile  ��   � l      ����� � o      ���� 0 script_file  ��  ��   �  ��� � L     � � l    ����� � I   �� ���
�� .sysodsct****        scpt � o    ���� 0 script_file  ��  ��  ��  ��   � R      ������
�� .ascrerr ****      � ****��  ��   � L     � � m    ��
�� boovfals��   �  � � � l     �������  ��  �   �  ��~ � i     � � � I      �} ��|�} 0 load_run   �  � � � o      �{�{ 0 this_scriptfile   �  ��z � o      �y�y 0 this_property_value  �z  �|   � k     / � �  � � � l     �x � ��x   � ; 5 This handler will load, then execute, a script file     � � � � j   T h i s   h a n d l e r   w i l l   l o a d ,   t h e n   e x e c u t e ,   a   s c r i p t   f i l e   �  � � � l     �w � ��w   � 6 0 located in the Resources folder of this applet.    � � � � `   l o c a t e d   i n   t h e   R e s o u r c e s   f o l d e r   o f   t h i s   a p p l e t . �  � � � l     �v � ��v   � 7 1 This method allows you to change property values    � � � � b   T h i s   m e t h o d   a l l o w s   y o u   t o   c h a n g e   p r o p e r t y   v a l u e s �  � � � l     �u � ��u   � 1 + within the loaded script before execution,    � � � � V   w i t h i n   t h e   l o a d e d   s c r i p t   b e f o r e   e x e c u t i o n , �  � � � l     �t � �t   � 7 1 or to execute handlers within the loaded script.     � b   o r   t o   e x e c u t e   h a n d l e r s   w i t h i n   t h e   l o a d e d   s c r i p t . � �s Q     / k    %  r    
	
	 I   �r�q
�r .sysorpthalis        TEXT o    �p�p 0 this_scriptfile  �q  
 l     �o�n o      �m�m 0 script_file  �o  �n    r     I   �l�k
�l .sysoloadscpt        file o    �j�j 0 script_file  �k   o      �i�i 0 this_script    O     r     o    �h�h 0 this_property_value   o      �g�g 0 some_script_property   4    �f
�f 
scpt o    �e�e 0 this_script   �d L    % l   $�c�b I   $�a�`
�a .sysodsct****        scpt o     �_�_ 0 this_script  �`  �c  �b  �d   R      �^�]�\
�^ .ascrerr ****      � ****�]  �\   L   - / m   - .�[
�[ boovfals�s  �~       �Z !�Z   �Y�X�W
�Y .GURLGURLnull��� ��� TEXT�X 0 run_scriptfile  �W 0 load_run   �V �U�T"#�S
�V .GURLGURLnull��� ��� TEXT�U 0 this_url this_URL�T  " 
�R�Q�P�O�N�M�L�K�J�I�R 0 this_url this_URL�Q 0 x  �P 	0 email  �O 0 argument_string  �N 0 these_arguments  �M 0 i  �L 0 	this_pair  �K 0 this_key  �J 0 
this_value  �I 0 subject  # �H )�G�F�E�D H�C�B�A W�@�? } � � ��> ��= ��<
�H 
psof
�G 
psin�F 
�E .sysooffslong    ��� null
�D 
ctxt
�C 
ascr
�B 
txdl
�A 
citm
�@ .corecnte****       ****
�? 
cobj
�> .sysodlogaskr        TEXT
�= 
strq
�< .sysoexecTEXT���     TEXT�S �*���� E�O�[�\[Zj\Z�k2E�O�[�\[Z�k\Zi2E�O���,FO��-E�O���,FO Gk�j kh ��/E�O���,FO��-E[�k/EQ�Z[�l/EQ�ZO���,FO��  �E�Y h[OY��Oa �%j Oa �a ,%a %j OP  �; ��:�9$%�8�; 0 run_scriptfile  �: �7&�7 &  �6�6 0 this_scriptfile  �9  $ �5�4�5 0 this_scriptfile  �4 0 script_file  % �3�2�1�0
�3 .sysorpthalis        TEXT
�2 .sysodsct****        scpt�1  �0  �8  �j  E�O�j W 	X  f! �/ ��.�-'(�,�/ 0 load_run  �. �+)�+ )  �*�)�* 0 this_scriptfile  �) 0 this_property_value  �-  ' �(�'�&�%�$�( 0 this_scriptfile  �' 0 this_property_value  �& 0 script_file  �% 0 this_script  �$ 0 some_script_property  ( �#�"�!� ��
�# .sysorpthalis        TEXT
�" .sysoloadscpt        file
�! 
scpt
�  .sysodsct****        scpt�  �  �, 0 '�j  E�O�j E�O*�/ �E�UO�j W 	X  fascr  ��ޭ
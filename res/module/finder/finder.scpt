FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     ��������  ��  ��     	 
 	 l     ��  ��    ( " vvv derived from dvd-remote.2.txt     �   D   v v v   d e r i v e d   f r o m   d v d - r e m o t e . 2 . t x t 
     l     ��������  ��  ��        l     ��������  ��  ��        l      ��  ��    � �
######################################################### 
Finder / File System
######################################################### 
     �   
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   
 F i n d e r   /   F i l e   S y s t e m 
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #   
      l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��        i          I      �������� 0 
list_roots  ��  ��     k     � ! !  " # " r      $ % $ J     ����   % o      ���� 
0 answer   #  & ' & l   ��������  ��  ��   '  ( ) ( O    � * + * k    � , ,  - . - l   ��������  ��  ��   .  / 0 / l   �� 1 2��   1   first the disks ...     2 � 3 3 *   f i r s t   t h e   d i s k s   . . .   0  4 5 4 r     6 7 6 2   ��
�� 
cdis 7 o      ���� 0 	all_disks   5  8 9 8 l   �� : ;��   : 8 2repeat with disk_ref in disks -- ... does not work    ; � < < d r e p e a t   w i t h   d i s k _ r e f   i n   d i s k s   - -   . . .   d o e s   n o t   w o r k 9  = > = r     ? @ ? J    ����   @ o      ���� 
0 _disks   >  A B A X    R C�� D C k   ( M E E  F G F r   ( 0 H I H K   ( . J J �� K���� 	0 _name   K n   ) , L M L 1   * ,��
�� 
pnam M o   ) *���� 0 disk_ref  ��   I o      ���� 	0 _disk   G  N O N r   1 = P Q P b   1 ; R S R o   1 2���� 	0 _disk   S K   2 : T T �� U���� 	0 _path   U c   3 8 V W V c   3 6 X Y X o   3 4���� 0 disk_ref   Y m   4 5��
�� 
alis W m   6 7��
�� 
ctxt��   Q o      ���� 	0 _disk   O  Z [ Z r   > F \ ] \ b   > D ^ _ ^ o   > ?���� 	0 _disk   _ K   ? C ` ` �� a���� 0 
_iconclass 
_iconClass a m   @ A b b � c c  f a   f a - h d d - o��   ] o      ���� 	0 _disk   [  d e d l  G G�� f g��   f > 8 set _disk to _disk & {_ejectable:ejectable of disk_ref}    g � h h p   s e t   _ d i s k   t o   _ d i s k   &   { _ e j e c t a b l e : e j e c t a b l e   o f   d i s k _ r e f } e  i j i l  G G�� k l��   k : 4 set _disk to _disk & {_startup:startup of disk_ref}    l � m m h   s e t   _ d i s k   t o   _ d i s k   &   { _ s t a r t u p : s t a r t u p   o f   d i s k _ r e f } j  n o n l  G G�� p q��   p D > set _disk to _disk & {_local_volume:local volume of disk_ref}    q � r r |   s e t   _ d i s k   t o   _ d i s k   &   { _ l o c a l _ v o l u m e : l o c a l   v o l u m e   o f   d i s k _ r e f } o  s t s l  G G��������  ��  ��   t  u v u r   G K w x w o   G H���� 	0 _disk   x n       y z y  ;   I J z o   H I���� 
0 _disks   v  { | { l  L L�� } ~��   } &   copy _disk to the end of _disks    ~ �   @   c o p y   _ d i s k   t o   t h e   e n d   o f   _ d i s k s |  ��� � l  L L�� � ���   � * $set answer to answer & {folder_info}    � � � � H s e t   a n s w e r   t o   a n s w e r   &   { f o l d e r _ i n f o }��  �� 0 disk_ref   D o    ���� 0 	all_disks   B  � � � l  S S��������  ��  ��   �  � � � r   S [ � � � b   S Y � � � o   S T���� 
0 answer   � K   T X � � �� ����� 
0 _disks   � o   U V���� 
0 _disks  ��   � o      ���� 
0 answer   �  � � � l  \ \��������  ��  ��   �  � � � l  \ \�� � ���   � $  next the standad 'places' ...    � � � � <   n e x t   t h e   s t a n d a d   ' p l a c e s '   . . . �  � � � r   \ ` � � � J   \ ^����   � o      ���� 0 _places   �  � � � l  a a��������  ��  ��   �  � � � r   a h � � � c   a f � � � 1   a d��
�� 
home � m   d e��
�� 
alis � o      ���� 0 home_ref   �  � � � Z   i � � ����� � I  i u�� ���
�� .coredoexnull���     obj  � 4   i q�� �
�� 
cfol � l  m p ����� � c   m p � � � o   m n���� 0 home_ref   � m   n o��
�� 
ctxt��  ��  ��   � k   x � � �  � � � r   x � � � � K   x � � � �� ����� 	0 _name   � n   y ~ � � � 1   | ~��
�� 
pnam � 1   y |��
�� 
home��   � o      ���� 	0 _home   �  � � � r   � � � � � b   � � � � � o   � ����� 	0 _home   � K   � � � � �� ����� 	0 _path   � c   � � � � � c   � � � � � o   � ����� 0 home_ref   � m   � ���
�� 
ctxt � m   � ���
�� 
ctxt��   � o      ���� 	0 _home   �  � � � r   � � � � � b   � � � � � o   � ����� 	0 _home   � K   � � � � �� ����� 0 
_iconclass 
_iconClass � m   � � � � � � �  f a   f a - h o m e��   � o      ���� 	0 _home   �  � � � r   � � � � � o   � ����� 	0 _home   � n       � � �  ;   � � � o   � ����� 0 _places   �  � � � l  � ���������  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � < 6 set _home to _home & {_path:home_ref as text as text}    � � � � l   s e t   _ h o m e   t o   _ h o m e   &   { _ p a t h : h o m e _ r e f   a s   t e x t   a s   t e x t } �  � � � l  � ��� � ���   � * $ set _home to _home & {_type:"home"}    � � � � H   s e t   _ h o m e   t o   _ h o m e   &   { _ t y p e : " h o m e " } �  � � � l  � �� � ��   � . ( set _home to _home & {_ejectable:false}    � � � � P   s e t   _ h o m e   t o   _ h o m e   &   { _ e j e c t a b l e : f a l s e } �  � � � l  � ��~ � ��~   � , & set _home to _home & {_startup:false}    � � � � L   s e t   _ h o m e   t o   _ h o m e   &   { _ s t a r t u p : f a l s e } �  � � � l  � ��} � ��}   � 0 * set _home to _home & {_local_volume:true}    � � � � T   s e t   _ h o m e   t o   _ h o m e   &   { _ l o c a l _ v o l u m e : t r u e } �  � � � l  � ��| � ��|   � - ' set _places to _places & {_home:_home}    � � � � N   s e t   _ p l a c e s   t o   _ p l a c e s   &   { _ h o m e : _ h o m e } �  ��{ � l  � ��z � ��z   � ' ! copy _home to the end of _places    � � � � B   c o p y   _ h o m e   t o   t h e   e n d   o f   _ p l a c e s�{  ��  ��   �  � � � l  � ��y�x�w�y  �x  �w   �  � � � r   � � � � � b   � � � � � o   � ��v�v 
0 answer   � K   � � � � �u �t�u 0 _places    o   � ��s�s 0 _places  �t   � o      �r�r 
0 answer   �  l  � ��q�p�o�q  �p  �o   �n l  � ��m�l�k�m  �l  �k  �n   + 5    
�j�i
�j 
capp m     �   c o m . a p p l e . f i n d e r
�i kfrmID   ) �h L   � � o   � ��g�g 
0 answer  �h    	
	 l     �f�e�d�f  �e  �d  
  l     �c�c     list_roots()    �    l i s t _ r o o t s ( )  l     �b�a�`�b  �a  �`    l     �_�^�]�_  �^  �]    i     I      �\�[�\ 0 	list_path   �Z o      �Y�Y 0 folder_path  �Z  �[   k     �  l     �X�W�V�X  �W  �V    r       K     !! �U"�T�U 0 _folder_path  " o    �S�S 0 folder_path  �T    o      �R�R 
0 answer   #$# r    %&% J    	�Q�Q  & o      �P�P 0 _sub_folders  $ '(' r    )*) J    �O�O  * o      �N�N 
0 _files  ( +,+ l   �M�L�K�M  �L  �K  , -.- r    /0/ m    �J
�J boovfals0 o      �I�I 0 quick_and_dirty  . 121 l   �H�G�F�H  �G  �F  2 343 Z    �56�E75 o    �D�D 0 quick_and_dirty  6 O    7898 k   ! 6:: ;<; r   ! +=>= n   ! )?@? 1   ' )�C
�C 
pnam@ n   ! 'ABA 2  % '�B
�B 
cfolB 4   ! %�AC
�A 
cfolC o   # $�@�@ 0 folder_path  > o      �?�? 0 _sub_folders  < D�>D r   , 6EFE n   , 4GHG 1   2 4�=
�= 
pnamH n   , 2IJI 2  0 2�<
�< 
fileJ 4   , 0�;K
�; 
cfolK o   . /�:�: 0 folder_path  F o      �9�9 
0 _files  �>  9 5    �8L�7
�8 
cappL m    MM �NN   c o m . a p p l e . f i n d e r
�7 kfrmID  �E  7 l  : �OPQO O   : �RSR k   B �TT UVU l  B B�6�5�4�6  �5  �4  V WXW r   B GYZY c   B E[\[ o   B C�3�3 0 folder_path  \ m   C D�2
�2 
alisZ o      �1�1 0 target_container  X ]^] l  H H�0�/�.�0  �/  �.  ^ _`_ r   H Raba b   H Pcdc o   H I�-�- 
0 answer  d K   I Oee �,f�+�, 0 _posix_path  f n   J Mghg 1   K M�*
�* 
psxph o   J K�)�) 0 target_container  �+  b o      �(�( 
0 answer  ` iji r   S ]klk b   S [mnm o   S T�'�' 
0 answer  n K   T Zoo �&p�%�& 	0 _name  p n   U Xqrq 1   V X�$
�$ 
pnamr o   U V�#�# 0 target_container  �%  l o      �"�" 
0 answer  j sts l  ^ ^�!� ��!  �   �  t uvu l  ^ ^����  �  �  v wxw r   ^ cyzy n   ^ a{|{ 2  _ a�
� 
cfol| o   ^ _�� 0 target_container  z o      �� 0 contained_folders  x }~} l  d d���   T Nrepeat with sub_folder_ref in folders of target_container -- ... does not work   � ��� � r e p e a t   w i t h   s u b _ f o l d e r _ r e f   i n   f o l d e r s   o f   t a r g e t _ c o n t a i n e r   - -   . . .   d o e s   n o t   w o r k~ ��� X   d ����� k   t ��� ��� r   t |��� K   t z�� ���� 	0 _name  � n   u x��� 1   v x�
� 
pnam� o   u v�� 0 sub_folder_ref  �  � o      �� 0 
sub_folder  � ��� l  } }����  � M G set sub_folder to sub_folder & {_path:sub_folder_ref as alias as text}   � ��� �   s e t   s u b _ f o l d e r   t o   s u b _ f o l d e r   &   { _ p a t h : s u b _ f o l d e r _ r e f   a s   a l i a s   a s   t e x t }� ��� r   } ���� o   } ~�� 0 
sub_folder  � n      ���  ;    �� o   ~ �� 0 _sub_folders  � ��� l  � �����  � 1 + copy sub_folder to the end of _sub_folders   � ��� V   c o p y   s u b _ f o l d e r   t o   t h e   e n d   o f   _ s u b _ f o l d e r s�  � 0 sub_folder_ref  � o   g h�� 0 contained_folders  � ��� l  � ���
�	�  �
  �	  � ��� r   � ���� n   � ���� 2  � ��
� 
file� o   � ��� 0 target_container  � o      �� 0 contained_files  � ��� X   � ����� k   � ��� ��� r   � ���� K   � ��� ���� 	0 _name  � n   � ���� 1   � ��
� 
pnam� o   � ��� 0 file_ref  �  � o      � �  	0 _file  � ��� l  � �������  � $  set _size to size of file_ref   � ��� <   s e t   _ s i z e   t o   s i z e   o f   f i l e _ r e f� ��� l  � �������  � - 'set file_ref_alias to file_ref as alias   � ��� N s e t   f i l e _ r e f _ a l i a s   t o   f i l e _ r e f   a s   a l i a s� ��� l  � �������  � 5 /set _posix_path to POSIX path of file_ref_alias   � ��� ^ s e t   _ p o s i x _ p a t h   t o   P O S I X   p a t h   o f   f i l e _ r e f _ a l i a s� ��� l  � �������  � 5 / set _file to _file & {_posix_path:_posix_path}   � ��� ^   s e t   _ f i l e   t o   _ f i l e   &   { _ p o s i x _ p a t h : _ p o s i x _ p a t h }� ��� l  � �������  � $  set _path to file_ref as text   � ��� <   s e t   _ p a t h   t o   f i l e _ r e f   a s   t e x t� ��� l  � �������  � ) # set _file to _file & {_path:_path}   � ��� F   s e t   _ f i l e   t o   _ f i l e   &   { _ p a t h : _ p a t h }� ��� r   � ���� n   � ���� 1   � ���
�� 
ptsz� o   � ����� 0 file_ref  � o      ���� 	0 _size  � ��� Z   � ������� I  � ������
�� .coredoexnull���     obj � 1   � ���
�� 
ptsz��  � r   � ���� b   � ���� o   � ����� 	0 _file  � K   � ��� ������� 	0 _size  � o   � ����� 	0 _size  ��  � o      ���� 	0 _file  ��  � r   � ���� b   � ���� o   � ����� 	0 _file  � K   � ��� ������� 	0 _size  � m   � ���
�� 
null��  � o      ���� 	0 _file  � ��� l  � ���������  ��  ��  � ��� r   � ���� o   � ����� 	0 _file  � n      ���  ;   � �� o   � ����� 
0 _files  � ���� l  � ���������  ��  ��  ��  � 0 file_ref  � o   � ����� 0 contained_files  � ���� l  � ���������  ��  ��  ��  S 5   : ?�����
�� 
capp� m   < =�� ���   c o m . a p p l e . f i n d e r
�� kfrmID  P + % slower but more technically correct    Q ��� J   s l o w e r   b u t   m o r e   t e c h n i c a l l y   c o r r e c t  4 ��� r   � ���� b   � ���� o   � ����� 
0 answer  � K   � ��� ������� 0 _folders  � o   � ����� 0 _sub_folders  ��  � o      ���� 
0 answer  � ���� r   � �   b   � � o   � ����� 
0 answer   K   � � ������ 
0 _files   o   � ����� 
0 _files  ��   o      ���� 
0 answer  ��    l     ��������  ��  ��   	 l     ��
��  
 . ( list_path("Macintosh HD:Applications:")    � P   l i s t _ p a t h ( " M a c i n t o s h   H D : A p p l i c a t i o n s : " )	  l     ����   4 .list_path("64G:Movies") -- list the disk 'osx'    � \ l i s t _ p a t h ( " 6 4 G : M o v i e s " )   - -   l i s t   t h e   d i s k   ' o s x '  l     ����   2 , list_path("osx:tmp") -- list the disk 'osx'    � X   l i s t _ p a t h ( " o s x : t m p " )   - -   l i s t   t h e   d i s k   ' o s x '  l     ����      list_path("osx:Library:")    � 4   l i s t _ p a t h ( " o s x : L i b r a r y : " )  l     ����   %  list_path("osx:Applications:")    �   >   l i s t _ p a t h ( " o s x : A p p l i c a t i o n s : " ) !"! l     ��������  ��  ��  " #$# i    %&% I      ��'���� 0 	file_info  ' (��( o      ���� 0 	file_path  ��  ��  & k     q)) *+* l     ��������  ��  ��  + ,-, O     o./. k    n00 121 r    343 I   ��5��
�� .sysonfo4asfe        file5 4    ��6
�� 
file6 o   
 ���� 0 	file_path  ��  4 o      ���� 0 file_info_ref  2 787 r    9:9 K    ;; ��<���� 0 
_file_path  < o    ���� 0 	file_path  ��  : o      ���� 
0 answer  8 =>= r    $?@? b    "ABA o    ���� 
0 answer  B K    !CC ��D���� 
0 _alias  D n    EFE m    ��
�� 
alisF o    ���� 0 file_info_ref  ��  @ o      ���� 
0 answer  > GHG r   % 1IJI b   % /KLK o   % &���� 
0 answer  L K   & .MM ��N���� 0 _type_identifier  N c   ' ,OPO n   ' *QRQ 1   ( *��
�� 
utidR o   ' (���� 0 file_info_ref  P m   * +��
�� 
TEXT��  J o      ���� 
0 answer  H STS Z   2 NUV��WU E   2 8XYX o   2 3���� 0 file_info_ref  Y K   3 7ZZ ��[��
�� 
aslk[ m   4 5��
�� boovtrue��  V r   ; C\]\ b   ; A^_^ o   ; <���� 
0 answer  _ K   < @`` ��a���� 0 _locked  a m   = >��
�� boovtrue��  ] o      ���� 
0 answer  ��  W r   F Nbcb b   F Lded o   F G���� 
0 answer  e K   G Kff ��g���� 0 _locked  g m   H I��
�� boovfals��  c o      ���� 
0 answer  T hih Z   O kjk��lj E   O Umnm o   O P���� 0 file_info_ref  n K   P Too ��p��
�� 
bzstp m   Q R��
�� boovtrue��  k r   X `qrq b   X ^sts o   X Y���� 
0 answer  t K   Y ]uu ��v���� 0 _busy_status  v m   Z [��
�� boovtrue��  r o      ���� 
0 answer  ��  l r   c kwxw b   c iyzy o   c d���� 
0 answer  z K   d h{{ ��|���� 0 _busy_status  | m   e f��
�� boovfals��  x o      ���� 
0 answer  i }��} L   l n~~ o   l m���� 
0 answer  ��  / 5     ����
�� 
capp m    �� ���   c o m . a p p l e . f i n d e r
�� kfrmID  - ���� l  p p��������  ��  ��  ��  $ ��� l     ��~�}�  �~  �}  � ��� l     �|���|  � ^ X file_info("osx:Users:Shared:Projects:osx.app.Mc-Remote:com.apple.Finder:test-file.txt")   � ��� �   f i l e _ i n f o ( " o s x : U s e r s : S h a r e d : P r o j e c t s : o s x . a p p . M c - R e m o t e : c o m . a p p l e . F i n d e r : t e s t - f i l e . t x t " )� ��� l     �{�z�y�{  �z  �y  � ��� l     �x���x  � ( " ^^^ derived from dvd-remote.2.txt   � ��� D   ^ ^ ^   d e r i v e d   f r o m   d v d - r e m o t e . 2 . t x t� ��� l     �w�v�u�w  �v  �u  � ��� i    ��� I      �t�s�r�t 0 ping  �s  �r  � I    �q��p
�q .sysonotfnull��� ��� TEXT� m     �� ��� . p i n g   f r o m   ' f i n d e r . s c p t '�p  � ��� l     �o�n�m�o  �n  �m  � ��� l     �l���l  �   ping()   � ���    p i n g ( )� ��� l     �k�j�i�k  �j  �i  � ��h� l     �g�f�e�g  �f  �e  �h       �d������d  � �c�b�a�`�c 0 
list_roots  �b 0 	list_path  �a 0 	file_info  �` 0 ping  � �_  �^�]���\�_ 0 
list_roots  �^  �]  � �[�Z�Y�X�W�V�U�T�[ 
0 answer  �Z 0 	all_disks  �Y 
0 _disks  �X 0 disk_ref  �W 	0 _disk  �V 0 _places  �U 0 home_ref  �T 	0 _home  � �S�R�Q�P�O�N�M�L�K�J�I�H b�G�F�E�D ��C
�S 
capp
�R kfrmID  
�Q 
cdis
�P 
kocl
�O 
cobj
�N .corecnte****       ****�M 	0 _name  
�L 
pnam�K 	0 _path  
�J 
alis
�I 
ctxt�H 0 
_iconclass 
_iconClass�G 
0 _disks  
�F 
home
�E 
cfol
�D .coredoexnull���     obj �C 0 _places  �\ �jvE�O)���0 �*�-E�OjvE�O 9�[��l kh ��,lE�O���&�&l%E�O���l%E�O��6FOP[OY��O��l%E�OjvE�O*�,�&E�O*a ��&/j  .�*�,�,lE�O���&�&l%E�O��a l%E�O��6FOPY hO�a �l%E�OPUO�� �B�A�@���?�B 0 	list_path  �A �>��> �  �=�= 0 folder_path  �@  � �<�;�:�9�8�7�6�5�4�3�2�1�0�< 0 folder_path  �; 
0 answer  �: 0 _sub_folders  �9 
0 _files  �8 0 quick_and_dirty  �7 0 target_container  �6 0 contained_folders  �5 0 sub_folder_ref  �4 0 
sub_folder  �3 0 contained_files  �2 0 file_ref  �1 	0 _file  �0 	0 _size  � �/�.M�-�,�+�*��)�(�'�&�%�$�#�"�!� ����/ 0 _folder_path  
�. 
capp
�- kfrmID  
�, 
cfol
�+ 
pnam
�* 
file
�) 
alis�( 0 _posix_path  
�' 
psxp�& 	0 _name  
�% 
kocl
�$ 
cobj
�# .corecnte****       ****
�" 
ptsz
�! .coredoexnull���     obj �  	0 _size  
� 
null� 0 _folders  � 
0 _files  �? ��lE�OjvE�OjvE�OfE�O� #)���0 *�/�-�,E�O*�/�-�,E�UY �)���0 ���&E�O���,l%E�O���,l%E�O��-E�O #�[��l kh ��,lE�O��6FOP[OY��O��-E�O M�[��l kh 
��,lE�O��,E�O*�,j  �a �l%E�Y �a a l%E�O��6FOP[OY��OPUO�a �l%E�O�a �l%E�� �&������ 0 	file_info  � ��� �  �� 0 	file_path  �  � ���� 0 	file_path  � 0 file_info_ref  � 
0 answer  � �����������
�	���
� 
capp
� kfrmID  
� 
file
� .sysonfo4asfe        file� 0 
_file_path  � 
0 _alias  
� 
alis� 0 _type_identifier  
� 
utid
�
 
TEXT
�	 
aslk� 0 _locked  
� 
bzst� 0 _busy_status  � r)���0 h*�/j E�O�lE�O���,l%E�O���,�&l%E�O��el ��el%E�Y 
��fl%E�O��el ��el%E�Y 
��fl%E�O�UOP� �������� 0 ping  �  �  �  � ��
� .sysonotfnull��� ��� TEXT� �j ascr  ��ޭ
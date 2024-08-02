PGDMP      7                |            dbms    16.3    16.3                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16398    dbms    DATABASE     {   CREATE DATABASE dbms WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE dbms;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1255    16503    check_weapon_type_match()    FUNCTION     f  CREATE FUNCTION public.check_weapon_type_match() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NOT EXISTS(
SELECT 1
FROM character c
JOIN weapon w ON c.weapon_type = w.weapon_type
WHERE c.name = NEW.character_name
AND w.name = NEW.weapon_name
) THEN
RAISE EXCEPTION 'Weapon type of character and weapon do not match';
END IF;

RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.check_weapon_type_match();
       public          postgres    false    4            �            1259    16469    best_weapon    TABLE     x   CREATE TABLE public.best_weapon (
    "character" text NOT NULL,
    rank integer NOT NULL,
    weapon text NOT NULL
);
    DROP TABLE public.best_weapon;
       public         heap    postgres    false    4            �            1259    16440 	   character    TABLE     �   CREATE TABLE public."character" (
    name text NOT NULL,
    rarity text NOT NULL,
    element text NOT NULL,
    weapon_type text NOT NULL,
    role text NOT NULL
);
    DROP TABLE public."character";
       public         heap    postgres    false    4            �            1259    16486    character_skill    TABLE     �   CREATE TABLE public.character_skill (
    character_name text NOT NULL,
    skill_name text NOT NULL,
    skill_type text NOT NULL
);
 #   DROP TABLE public.character_skill;
       public         heap    postgres    false    4            �            1259    16424    skill    TABLE     h   CREATE TABLE public.skill (
    name text NOT NULL,
    type text NOT NULL,
    "desc" text NOT NULL
);
    DROP TABLE public.skill;
       public         heap    postgres    false    4            �            1259    16457    weapon    TABLE     �   CREATE TABLE public.weapon (
    name text NOT NULL,
    type text NOT NULL,
    rarity text NOT NULL,
    atk integer NOT NULL,
    secondary text NOT NULL,
    drop text NOT NULL
);
    DROP TABLE public.weapon;
       public         heap    postgres    false    4            �            1259    16433    weapon_type    TABLE     <   CREATE TABLE public.weapon_type (
    name text NOT NULL
);
    DROP TABLE public.weapon_type;
       public         heap    postgres    false    4            
          0    16469    best_weapon 
   TABLE DATA           @   COPY public.best_weapon ("character", rank, weapon) FROM stdin;
    public          postgres    false    219   '                 0    16440 	   character 
   TABLE DATA           O   COPY public."character" (name, rarity, element, weapon_type, role) FROM stdin;
    public          postgres    false    217   "'                 0    16486    character_skill 
   TABLE DATA           Q   COPY public.character_skill (character_name, skill_name, skill_type) FROM stdin;
    public          postgres    false    220   c*                 0    16424    skill 
   TABLE DATA           3   COPY public.skill (name, type, "desc") FROM stdin;
    public          postgres    false    215   �*       	          0    16457    weapon 
   TABLE DATA           J   COPY public.weapon (name, type, rarity, atk, secondary, drop) FROM stdin;
    public          postgres    false    218   u�                 0    16433    weapon_type 
   TABLE DATA           +   COPY public.weapon_type (name) FROM stdin;
    public          postgres    false    216   ~�       m           2606    16475    best_weapon best_weapon_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.best_weapon
    ADD CONSTRAINT best_weapon_pkey PRIMARY KEY ("character", rank);
 F   ALTER TABLE ONLY public.best_weapon DROP CONSTRAINT best_weapon_pkey;
       public            postgres    false    219    219            i           2606    16446    character character_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (name);
 D   ALTER TABLE ONLY public."character" DROP CONSTRAINT character_pkey;
       public            postgres    false    217            o           2606    16492 $   character_skill character_skill_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_pkey PRIMARY KEY (character_name, skill_name, skill_type);
 N   ALTER TABLE ONLY public.character_skill DROP CONSTRAINT character_skill_pkey;
       public            postgres    false    220    220    220            e           2606    16430    skill skill_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (name, type);
 :   ALTER TABLE ONLY public.skill DROP CONSTRAINT skill_pkey;
       public            postgres    false    215    215            k           2606    16463    weapon weapon_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_pkey PRIMARY KEY (name);
 <   ALTER TABLE ONLY public.weapon DROP CONSTRAINT weapon_pkey;
       public            postgres    false    218            g           2606    16439    weapon_type weapon_type_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.weapon_type
    ADD CONSTRAINT weapon_type_pkey PRIMARY KEY (name);
 F   ALTER TABLE ONLY public.weapon_type DROP CONSTRAINT weapon_type_pkey;
       public            postgres    false    216            v           2620    16504 '   best_weapon trg_check_weapon_type_match    TRIGGER     �   CREATE TRIGGER trg_check_weapon_type_match BEFORE INSERT OR UPDATE ON public.best_weapon FOR EACH ROW EXECUTE FUNCTION public.check_weapon_type_match();
 @   DROP TRIGGER trg_check_weapon_type_match ON public.best_weapon;
       public          postgres    false    219    221            r           2606    16476 &   best_weapon best_weapon_character_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.best_weapon
    ADD CONSTRAINT best_weapon_character_fkey FOREIGN KEY ("character") REFERENCES public."character"(name) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 P   ALTER TABLE ONLY public.best_weapon DROP CONSTRAINT best_weapon_character_fkey;
       public          postgres    false    217    4713    219            s           2606    16481 #   best_weapon best_weapon_weapon_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.best_weapon
    ADD CONSTRAINT best_weapon_weapon_fkey FOREIGN KEY (weapon) REFERENCES public.weapon(name) ON UPDATE RESTRICT ON DELETE CASCADE NOT VALID;
 M   ALTER TABLE ONLY public.best_weapon DROP CONSTRAINT best_weapon_weapon_fkey;
       public          postgres    false    4715    219    218            t           2606    16493 3   character_skill character_skill_character_name_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_character_name_fkey FOREIGN KEY (character_name) REFERENCES public."character"(name) ON UPDATE CASCADE ON DELETE RESTRICT;
 ]   ALTER TABLE ONLY public.character_skill DROP CONSTRAINT character_skill_character_name_fkey;
       public          postgres    false    4713    217    220            u           2606    16498 :   character_skill character_skill_skill_name_skill_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.character_skill
    ADD CONSTRAINT character_skill_skill_name_skill_type_fkey FOREIGN KEY (skill_name, skill_type) REFERENCES public.skill(name, type) ON UPDATE CASCADE ON DELETE RESTRICT;
 d   ALTER TABLE ONLY public.character_skill DROP CONSTRAINT character_skill_skill_name_skill_type_fkey;
       public          postgres    false    215    220    220    4709    215            p           2606    16452 $   character character_weapon_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_weapon_type_fkey FOREIGN KEY (weapon_type) REFERENCES public.weapon_type(name) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 P   ALTER TABLE ONLY public."character" DROP CONSTRAINT character_weapon_type_fkey;
       public          postgres    false    217    216    4711            q           2606    16464    weapon weapon_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.weapon
    ADD CONSTRAINT weapon_type_fkey FOREIGN KEY (type) REFERENCES public.weapon_type(name) ON UPDATE CASCADE ON DELETE RESTRICT NOT VALID;
 A   ALTER TABLE ONLY public.weapon DROP CONSTRAINT weapon_type_fkey;
       public          postgres    false    218    4711    216            
      x������ � �         1  x��VAv�0]�)X�E�� HC�K�	}�0E�D��W�G�*blɒk>_3���?�|�[�Q�(7��v�(;�w����^�Ə��3��A�@c[U��DT7F£{4�(9�J=��=8P�LLf �xnMÃ#�#�QY	��M��^_�ʻ	#�Ől$���HE�dH���ƶ��U%��E���J8�T*�*כ6PEu�y�f�h[>4+Z�8at�T��V��pu���<pT\��p����S�>��fp�o$vWG2㈡��IH�eJ�@���@��4z����m�u����@pM�9�q�y�<nsN\�6�}�7j����E�n��C�0�r��lI;&�_��'UK���rT�O6��"DT���J���N�m���aGҿ��!u���?P�6WQ ��f�Bb�A?+�9Ì�v-�!¾�i󣅌lkq2E��=о!#{���1���HJ)��ھ�dR�x�ݡɆ��i6p,�;#PkP�-{;Bں���\r�	Q�����a'v����Ѱ�����[�A0FăB�a�jLh��=nF��6Tȡj{Y(/��bT�{W�Q�6���Bن�˟�DaJV���*�L!��Ơ��N��}2�_�-���=Z����	5�g��F�t�뙑���1�fzO���3l�`����`x[i�sG4��*��t�m(���֜۱�4����y��h��"���(��9��,�Zu���u�"t�s&��V^荒Y$h$������)�mBF��������n2��6��@�����kҸ�R:l`�E�D}�!�חn��n�W�            x������ � �            x���rI�&���Q?�Te"�V�p̮E��JRJM2SSm���H"P���^m~�G��p��[x���̜�6k�N��?��������3s]WE�f�K��o��*;�>�E��駺٘2;�:3�
��}ț%���۬��gYc��"k�����iv�6�*_��'u�����L6ϛ�Uf6u_uY��.:�)*���U��v�=��`>ިʾZ��N��.�z�m�š)�_Ⱥu����"��e}3�fch�z�����`Fe��G��[g^䦤��/��w/a�u����wӃ�YQ��*o��(��K�d�ۺ�7�O/�|c�&]\e���r�/�l�䦣��g}�1�|�ov��f]���햾�2����m���1�<�Fc|\�U������[���Z§>�Z3��ٺ�&����l3\T�.�Km��۶޴����Mi~�k��sS���2�e?h��g��hsS�������~��Y~�7��1�5��	�=o����zN��������.�����/q���m}��-�ך]�W��+[x�~�����X��nJL����y�Zw��=.�<=�?�T�.���;�;S,��K����"�^��?� 2\U���@/�%-R��ༀ��O$ܢ��(�����yv	��(�yߴݟ~���� ��fc���5�Y���3×p��$�=Jð7pG�����4{�\�&0�N>�O�y��ͨ���E^�4������O<ۀ���@^�������e�a�欬���@� ;V�-����`&�+M���}7
�����γs`y0n��/��b�?W�IMOt����^�fV7B�Uv�2`��}��y�͍i�(O�j��y´+�@nnn7�tpj�|u�N�
��=.���%��MS[��W������cB������Y�6p��b��{��'W�E��~��!��@_�X��-��E�����}\��z���I5t:��?���?��s�;T$�Ƣk�iX�T���2C����M�F3�E�Ӈұ��L�D׽.��pK�M�:)w�+B򁫔��%����wi��dBdQ�c#�i�䐍�)8�a�������ᩦX,�J�$� i]��a��
e��8T�[��� ��UH@.#�%�/x�=3-	T��73`�0%�g����x��I �j�B.��zQ����4K������vM(O��r�]CG���y�����Z�������,��
����k�u3k'V�x��D@Yv�f�&tŶ��bu/<�i��}�������
d`���e�=�V��1"�����6����΍԰)�Nv�G�Z,��?>���O�w�R�G���x�я�q��WQ��M5=x]]�eҊ����,�(�Zl�Y��DcK�p!�,>�f�"P�&�\� �'#�O<G
#)E��z��}����볾�g��M�����g/;h%,�W+�B*R�ݲ�Z��`��H�q��3���\9�9��4���y�]���5�Ͼ-������s����Y�UC2�����f��;�){�a��*$�J��ؗ�»�#�Q�+�9�0vw��E�23�+V҄���柺ƨ����%1sψ�u_�Q.T�b�9�tS�}Ӑv���92�U.�d�
����Ik@�K��	���r��Mt%n�N���ӇO�p[��AC���� ��ܦ=;nװ'��g��f8��l�{�f��	�=�]�԰��m׋%�NNԳ�C�~�"Am�1��l��ȳ�A�K��IbZ=������	��uO�1<���|�e�����[&�8~r�~�i�kO�A��Sy:|���#+4HXz�A"Zf<����	!"k�!���>f}K�:���,�Z"Y=q�x^����3k�ff9w������Gz���O>1�"��=���=�����ڔ�'��D��7� �^��ST�͓g*�����B��GO���-���/�f���B���4mf��7le�Y|V��cr-�eҩ�hW>X��}�$V�<��hi;%9����l�d�����ٶ�4ڑ7,6a���WV��b��=�ats�9�����>��������DD�A��S��1��Oހ�����Mw��1���������o�hB8h� ��\C}���`��7�ث]�_ݰ*ȽCg2'�4}�!f�!/?iv�ˣo]԰�]��7E&k�����s��<[��d|�+X�k�2gM�v�l�E~U��}Y�j�J��gx�.��k�N�f]4L��ޥE+�Fi�M��[򽁺��4�#ٱ������s���Ӷ������8{Ry���tN��IY ��̕Q�T�yY��V/���3��e��7���n�늿An*�H{S,�Hv�ʫH0|h�LS1؝c"_.����6%�(�ɪ��W�Xh��jGfH��>���B����:^EC?@26 ��Z:)a��	ˤ�au���ȗ���"��w0�I��`1�OYj��-��0�rѡA��|]w�p�>mXxYN��왾l�A�lAHhY�+_����z�\���N��09�B"��7h���gٗ@�s�
�`� 
X=�鋯v���&p���?��T�g¿�q$� ]v����1����t��,j��
�%�Mn#��U��R��,�s)Q(i�֡�c�.D�|����[0��]��޴^��r�zó�f��o�IC�IN�Z�+�B�_�mR��xr��&-��C;�_�����-�b[�N��?|i�`W�)��Q�Zq�$�9x�b�aQ���Pk�2|�F�._L�X U
f�l�o�#0Y�DA�g�5�^k�&k<
��:�ٔ���,��ź���|[Υ3+�{Wii�AJ��E��i�(�o�"���P��=��se˞�qo9��W � K��j�-���]�@3	���"�X�C�c���qD�3��TQ�vԬr�M�j˻���#���X e<˛��%����� �T��29jā�4�hc.�g~-�5����h���2��BƦ��6vV%��h��H�p1�RLA����J_tk����4s�� �ɣ��a��m}�����@�E���
$}N�-|�ۉ
�"�5��f^o�u��X�_�-N�&���;�[�[p0��5d��7l�
�{�>6��
��s��1~��
}J�X�t tz@�Э�b�A�y�[#��Q��Z�Άz� �[� �����J�;~H80����#d������@J���#i�{�!U��A����}��������J���a0%�'�*{St��d�@e�}����iaV��v b1T��D�/�5؋�mSPF�ټ���-�{N?�d%�V��/6(�H�[8/0<����X�n�Lek���9����p*����D0�����X,����S*>�%]�t�E�R���ِE|���:r��#z�4?��p8h()�(BA.T����J���Y�)�;{f�^ GɄ,�]�.hl����ܳ�/�l��*I
��B"$N�ϋ�{q�%���k�t.{`��4����06�f���z�Z3T6r���eM��#��O<=8�;:�K68�"4�[�U�{�ʳh��mU��X�ň��2��(�Ep^�F�/�s���v!C{΁!�+����_�l24f��n\��	�����=����.��k�?�b�	�����}LGjp�Fݚ�PM����>���tqy��	��?�������:�+�T&t�w55��Vr�ͻ��e1�����R\��k:�-�Λ�pV�e�6_���(;gy�in���2��6l'�~b�X��j��!��6�?[G,<'5�&70[8��u�.�}���Ю��Žոe)�bj�>]�����C���U�0�N���'���h��M�#�|"{Utw�u��/�\�wL�Q������DԐ-<�!<�ɏHL�r��a�$1�D�@�A^�שw<��L��9�BhD"a^N���:9e�]��O7*0��UEËԹ�9���u�,    X14���n�z�f=̠|1n/$D��.(G2<�m溞e�g0�I�l�rmr��6�nsCO%f t��Oí;b@"g�]��}IlO��a�����bμoċㄤ򽁬�ġ�`��ރ���Ojt�H�؁2G'r���������$�c`@n�쳷]X�y%ؔ�?�)�V�3[���?�V�ɩϗ3n���ᑸ(%�XD�:�v/�G^�ouۉ�8��Q2�Ȋ��q�M�Y�w"�^��N��S���!�WW!"m��h���ʄ��S(þғuQ7���dn�l�@����������7y��Q\
&&\����� 8�	O8(����\��=���S��mN�T���v�.8�0+�cg�5\��
�jxKA��$���Ȅ��@'Z����(���󪒪�7�˱�������DG�ll�J�ʣ�@�i���\�+��$9�}���RK� |U���(�;V|waD��_�c̭����P���lʷ�wɅ���� 7���)ʺ���b
<x���V_��X�(}�y�'Ĳ�߂۶<���\�
Y	�����l[�]]���҃��"�g�|��L̷��!���M�´����������6��J���}�� ��F�o�����0Ԉ�A>L�(�А���xz����#_h8A9��"Xn��&:k��1���'���
�~�α�S/C�#��ū?g/gr�����On��⥟��nY
�f�YEEvO�#�ދ���H�O�dO��@����a5B�A���v�R��r@yp*[N��/G�� �O���f�����bl9J��;M6�'���-��	���R��$]�8���2jv��}�q<�:�\�%�&��sBI]ɸ6��q,��y4[��k"o ��50�2w{z�9�B_��t�:�آE��"����8�zq�����������G]z�����o0�cC�ؓMU;�9~L�~t6b℠H���m�E^ك�R9/��m�Y�}B���W
b�L" d'��5��R�].�w7��Y�� ��u�h>r�P"�f��T���˹�q�၄'��2>����c���R�CrO�h��ޔǳ��G��҉I�B?��V"4���U��",�ԍ�%�O,�ƲI�9'���ݕ�u����l՗�J�g�r;̓�D [�i�Y$�1��pv�ҽvD,Ǡ��|���M��,������WîM���K��w��0��\���=pl�̦����n����Ƴ���q����3�h6+k�k��f����,a����|˨��*�(�/m
>%pF{����H����h��)��5ՙ�q�~�LU�������������HY�����h�K4���~m����Ϡ���������\`�\�a��~��sL\.�`A6C-�sr̀`��#!�CA"�NvU�!?��vS����ŉ-�кx��{�.��ʋ�X�K%m��4���M��n��4;z�'�nMS�HWD��~��J�]�3�U�f�߰nCˤm@��F���80�鋛���f���-ŉ��>�� �3��@�I����Jߑ���d�Q3D��%�D**Hyֿ��%�i�%r�qQV�?c���cJ_)�T���38�GXgv���5 ����?�|���4;�G�:Q7�v�9�iC۠��VN�T��k48��3윙)�g:AN������x���Wx����]]µ�`�7U=�Qt�X�D	C��P.@���K���EQ��YTr��e��,�d�����Zԛ�#k�4�їQ؈�!-�<�)c%�B$��9+�䁄����lBs��}9i�� �q�JZ�$11[�Σ^U��҆���.���7���)�/���M�4�Ӹ�۔���jr/(5�IR��UA0�}ߤmB��/j��p�H~zL]��)�At�p#�ڳ�O�>sk{bN;HML�S�z�\�����m$31����L��EH�n��)i��K%��[�F����:.+��䵏����ȯ�S���X�>Uhd�>�p	�ؤ��%�},�YCR�]�x[УZ�7,S����Tdyb�`@�\�J�&��\����K�r#�(<$���eDXKEvY����r'U�M
=�A�<���Oj��v�~���F�s �A�靘��������&��ks�( �7k�+ѹ5�
g�JEE0H+2-�$y6������)��J*I<$��S����h=��j:{�p"t���	�q��<?�3�d�(Q��i�.ʽyQi����8Q�w�Uе���Ez�n�PK���`&�����2ě�@%_����S"����(�P�=�G�R$�~o1`�Jӛ��Ւ ϛr��O$唋�PT��Iɞ�ȣl�o�k����P�������~n��`�2����p�T8�I?���Z;s3A�g4�s7��%Ӄ�|�%�r�Q��ֻK}�{��_\�(���+��)�>��ƞ�Į.��I_zB{$fb�J��1!iI�7�CR��J�h�꩹�&��%�|������Pe ����;�]��?{�*�#2r��Kk�=�������'ސeYxU�V�$������0��T��w硣�����D+���8r�::N9r~�p���r�v�0�bB1"�ˉ�E���g=ư9R[�
B>��"/�Q/�$u�?���rk��<���_���RqKL*~���h�e=�^��g���:آ�M�Y��9H|Z�M������ܱԕ#OA6B�a_[E'�?NdeQ��RI�Z��`Xm�Y��O҇%�S�3�S�c�tRr o��a�kQ��_\�����?lu���X���v� ma��C��a-�2u�����S�S�uY�aB�Lc��xh�@E�R��S������[���A`���L���@�V�\�p���'�F�C�p��P7v\s�^DR47�Nh��p���w�Ħ�JB���a�4�/ak�vB�O�9�E�xs���������8t(1��'����	����Y�5���o�����%)�u�z@���=�uY���۫����oaf (H�u����;E�F3
�1� l�ʚ�������,�5�.��Y�6������ap�`9����/`b���Į	P��XT��j�[fc��$a\�E� ��AZ%Y�g��d�i2�_n�bn���C�¨e@߁��yv�R�]������G�kl5���x�KS�􏑔�@� DOYت��Ρ�GdAؗ�\Q����rJ�G)��|���y!a�|H��c�p����nG��jC���~6CU�b�h�A�vM ��]�����<���$\�;�p������!|k#�ĘE���ge?� m��=���� i��>}�Ř$B��A��U}/�ِ��13}�܅�M� �����H{	$�'�$<oL��Ϛ��!��,�q���{��S�ԝ�T^E=&;S�Ts����_�p�2�[�$3pK�ݥ/ %R��Hr�_����P3-���z�(�����u��s�:Z����/8-��D����i��p\�_�E<���,h㣇?���1���������8+�� n�A^�8d�7hB�t��r��1�D�Ѕ�L��{Zܬ��z�yH����ݍd+r.���(�v[���ؐp�A�GF\Fa%R��88��L�3JJ��RA�j��4s��L>�5����|�O?�i�4�Ͷ/[�l��ˠb���XZv7���b@��J��!��\��?J��I�Fī���@�j� !>��L�$բ.*g�X��Z��rLz�~��Y L�:"�W�E"��`�� �N� ��W|%��y]q�����Lx^��a �|�hR��ۣ6�K�`�̱�� ������G��9l*,�֢z�	?��UcI�W����N{���Z$6��'��G���-�w��ȯȖi�W�4|�q��x<>r���W����T�i�bwN���%�lLQ�B��<8�)�J������m�Շ�|]P�`�=�h�7��4����)Kv���J��	7p �ޙ�    Խt9&�^�{��9ry#�p�E�wml�r-�ќ�B��|zۦ^�-w�ѧ��;��Gl�4L�	h�-ɱ:�aJY�3�j(�m�v�p��D�n/D��ry��dS�>�XH�ę��9����EiC�s(q?'�Y���(��t�Ƅ��f�����422�(845��L,ADW+ �ߤ������]�D/��+$���,�CK�U�]��������|������3�AR�	W�[��Z1�;�1OE�T#�i��M�~'��ua�)�˒ۢ�I$7���|*	����Q3@�f������[㒶��.Yn��%��s��Z��O-Ƅ��L$�~S��#�+�hI��>Wg8�%%��<|���m\��O}g�x��f�a	*����ZrݶZ���5 ��KX���Z�p�Z���a�F��:��1��,��fpX��jhH���*N뽨�l�z�ᕚI�K�ӷ�VS�ԢL���>�vt+W �a͂��;�yiA+�~&c�sH��7P�o�w��cKTР� :-��Y-M��c��z(2��^���i��և�4��3)�%W�p6���^|k��\��5�P�=˿�D&9�i����H�"�	h��+8A��0Ɇ�z�C~�u��E�GCt��¯V�;Y�=9*�;��1��Y[���1��b:��~�HAp�`YE�5��N?�-����z�i}<V!M>�B�=��E��߈_���!z��p��ɋ�풮�7~j�0!&�I�a,�>�&��c�8�1נ\! H?"h�����CR�l���ưޙ�tm���ۯ�����������X1�zF�j��xz��ly >5�tՂ]0WE�&oA���~~uAL�e�?!��7���j��Nay���G�QВ�i��׺F� ��f��/ op��kLx�53�`5a��O�n�N�0��
P�-8��{''�B(	���3<�v04��Y_r���?�Ƃv��9�'��ʱ?[$�$ǉ����F���w�M�3&�AF�o�k��鷨#k��c��Ly��{ߘ��1�:����$N-��庿8O����ȿx#$�8���C ���n疈�d�+X��E?$d��"&�k�ڟ�]&k�8�,�$�
�� �D.�L�ߵ,�p6�e����=�!B��X߯4�����/'�#l�W��]��L�?qQ$�	�8��N�= ����[�Z���.���TW���󽯀w�_��&��3�3��S�Y���ϥ�� �($�]ბ[�)d�U���m��}x���I�ɋ�pr��e��YH����k��H<(O0�[ۏE0��4�BB�ʃh�hk�|!0e?�����)���1��B�Rs��w?��o�!�y8�e�PE<0V�b3��҃��k�NN��Z�����_�l��tF; �`?s]ip�q�	� ��5��f0�@ԣF�d�\�����X>���-b�5��Yz�=߲&��[r�yjðV�y���!��Ycڲ����@2d���h=�5�B�NS��h���S;e�'��z �z����e<8���"���M���r����S֥�Ҽ�F:-���8V�N �L�ٸ�F�ڵ6�%�����S�A�b�L�%��zZ�#G-ӏTMYK�y�)p�kd�4^W�Z��#��ZhC�-;�-Z	/��Ŭ�\���4��<� |*�M�<�%h�}����<ANX����~�ɺX����M�z����� Gٻb�F͹�>�j����\���@H��)Z�f��?1�p<�sG��;"��-R�ڍ��YdP=�Jev]�Z)��I���U��a)v�l�X����~��RS"����y$2}�}�P"􈺅��ɦ(4������e�o��~��LYd�:f5�Е�O�=,�%�J��+�@�&SEg��Yt� �L���ą&E��}��*��0���MFJ+�'6t(H�����~�����Ôfuc�k�c@|�|P.���
bҴ������\҆KC�-�ɼ�vQ��x�
)$��ih��%Q(P�U����l��8l��:������=u.�TJ�+��x�hY`&8w^DO_���*��z��3����
��af,L�[�� Ӑ�b�Jm�����5��p��cC�� �1�&�|�Q�-U�;�#�-~�����$� G]0L���:0�kd66��9���|�O�|���p �
���?�R��R���KL�>'�/.��xR�Q�3��dR�Q
Vy�.Jb����I+��7�~":����B�e"�!ϊQDB�pX��þ3͕:d�mݱw��
�Ol�n�%Ŭv4N�1���i�K+�(��-�M���.�C�܄ANIt��_��`AY�2ޙ�'��-sE$qFpoeh
�$�`H݌��.b���@t�u�~��v��ct���a��N����*��ޕ���]P����:A+��5�oI(��|I�L�����H���æKj,\��le���%3ܮ�����͛��Q���N��An���؉\'�X�Iۺ ?ts� ���zV.�����ꥁ�T:KÄ�<n���R�ݪ�-�*k"�x4l,;��yi��3��q�o[ P��r� u}��P�g�LQ������m{cfu���^qBaa��Df��3|�Ƽw���O�9�s>�*}߂��� �W:,�����K��'7��_���c�5s��������Ew�)z�v����`̙����@:\�՟UTᅟd�;3�70l(��n�fP&�;h��I���%Ч�#��g�f"�$��f�q�Ce�edԠ]*mF���6N\�԰�����ąB�K�,�m�Ǵك�Av�M��x�~É-�9�L�ε�$$�pf�R�0��������Pg����A؊���O/��f��jD�YJ�u�u6�^#�y��C�����W�z�i0���U�)�I���}u3�{a��It� ����-&���^��ن�w�����D�-TA�.PXwr9v�N;� 7p���m�ٟi�?���ݱ%վR����p��A�,\/���g�	����VlS5ۗ���c �[�$�iEc˙X��zFj+�i�'0,���4͆Qށ5���-���s����i���)��I|�p���«⧌��G=��=�Q6��];�]�ce!�hOn�u�mz^.��܋[=Fʕ���
���dag�
)���DvX��􁕩?%^��������2��#�j-B";9}����	*�g�o�D�y�y���{P ��KW�8�/)�t&پR�$Yv3�Y�Q������eY����n�:C����Tڐ�>�$h̺[�Ūn���CSo��6!�&J^�s[���;S��d��f	?����ŷ�*�"W��7�Su��ZA&��$�׳���}�匁A��u�z `x������jh�?%~P�aO�c�R�
PV.��d�iS����(�M���V�9��&\ 6qbӋ�%�&Cc9\h�����M{_i�V~�IQ�D/
ln[�3���a��9*A���=�sdn�߂�?�W��^ɛz%��^D�~�=�Eo���=�R�Ud����Jb$���p�^�i�G�_���N~��G���aKl�%JG5(���Іy��`z��1���_���s1�z���<K(M5h5�*�5�@�{:��M�7ɱL3�SZ�J�L��*�a�\�ے�����	�ė�h�},� �La_y�Z�ȹb`Ь(��uO̱N���^�{~x�U���w������_�M��.�V�x�������E��ت�Od_��#�A�J�v'�s �;�6��������.r �[4�*���d����ojρ��m���<��V�p7/k.��4F+zr��%Y�J���o�A���"��]X�������z�E�n��l�5:bs޴�Z��x���H�9����?��=�eo!ݧ��vKi)�\��ixl�[i��Y�a���}/��]]���H��a����3�,]?�Ӻ��������m���E]MΑ%�H��\�Vb
n���b$��wN-���    >����h���᫋�5c��R�B��[�_F�d$ �sW��g�ĉ:E���H��g��J9��_{�n-���:	O����P�$e��`��f�̀EI��H�.��M�kMl��M�m��"]aK���k%B��=L ʃ*����m�<�.E|~��5����E땦�}����CL�����Iz�t��0�ѷ��;wK�jP1�E�G��v[r�`�~�W��8%�c��<�#ъ�l�lg�WVσ@�-���5ѦN!�����3�����.��J�g�U��		�����rtW��2��ʒ(�n�]�eM��O�R}����Kl��IJ5��Ah�+ך��~RɒB�ʤ�E�Ї+��!���x�����.����R�iU��*�`�� ����v؋�+ж�'8���4��*�8կur��C�����^+h�k��'�._*kou�{k�+n�o������ꛡ7��{�]���O�ZҌn�b�[z�"n	����oB~U>���.�i^Q±]�Kkc�l���u�+k��������]�û�'?t^R�wV�������#�C�MM��)�~���.�UJ�}�RVB��ȗ�@6��i?z��~�jN�B�lIK҄��m�������h��ۨu������o�>`JgRb� ���m��)�(4�H�<7���[��HO��ZV�͸0�6aB�S8��7�8��'cԖU..�W;�	f�����AS0U���%(hYh�Ia�Q��Y{֞^6�6�ͳ��?a��u��82�$��Fx=Q�
���
���%���N�^z-�oZE�5��b�`�7�팟��A2�vi�Ƕ,ǎ�\���xﲛ�%�ck�)y��.S�T���-G�ټARs8�U�,���~�%Xu�UrG�l���n𶒩��`�I�:b�����>�߱�P=%P���L�˰��q��k���T�����9�l7��D-���k�/Z��i��U�"����3eQ�6Z!.�Ħ�KTh���[s'����b[l�b�P�o�G&=y񻴎�f�-^���ف*1�7P�����$>ǐh����*�3 �_A��� ��`��/!�!��-&ɋ닟�4�ŊL�/J Db&t�g�~=�$�o�xO>��ZۼѴ\���յh;G˵������%�
�
=��
�e���f�ll��w^��N��QZ��s
4�$o'��<��0Y3dݻ���������ѣ��t�(n��P~hd=rCl��3���hO��Oω��(561>=�?��A�cRjAC�:4�P瓻�Hʹt4��;�[^����m ��o[Qj�u�����}!ܑ�"栂��f]�����n{;�	(R�"Q���S!�Z'ٌ��]�����vwk�g����/�w��锑�(�=�����X�>����
C\��K�S��.q��X7O9�2,0C-n+�^*�+ۆo0�J  *To�q��S�7��i��i�.�T�A	'�ݿ�qBh+�p�T��Cb���GԎ����7(����P�ɼM:�h(X,�@|���to|��	S^$Z[���ꋲ�5E�٫�`�'�ۘ/	������]�k�w+�!�L]y�g�>�;�Gg^lH���[&%��@| �nk�	�:���d��`��9�;�o� ���eeVt�(u��m�yڶӁ�c����`Aӌ|��{��F��[�k�u��3�0��C$ �i��H�+�iY�@���{֜�=Za�����i��fV��A	��T�M$aU%�Hlw=1�Ȳ��D�˻��#"Jn���~���d�7��s,��G�'�;��V�{�f�q2ܹÜ�j�+w����S��@]W���\�C`C��0�al��E�joH�^`�{ec'8)�H,���!�?{�C����j�G���w	�F ��
�/ط����D�g��W�d�Qԗ��ښa���Z�b�Q��}����@2��8 ��~��Y���$�}*.�2��]p��$�������JA��?[�}O��Q��x>a_g�В9�1u$�9��x#��w���B�������nA.�&.�o���7�YX�ȕ�Ӷ'����9,��	'�\�M�5UQ)��{�]�*���Y�@����~m���� �G*q�qs�;*�A2�~�(9����� `,|�`|�ŰqR�\�_��1�w3�Z�r|�j���tK��=�f�kSI}���@ܔu� [�[���C�d۱� ¤I3B�GՍ���������n��>�Lly��G��[���l&�zA>F�u<��QI�	�ΦG�<]��۾n��1;t��"M^A�FΚ�T��,Ɓp�e��ך���������\�}�O�� �c^fQ���.�쓑���cl4�K��zh�Fb�Y�L���̳��6uV�Ww܌��u��?���	��&3oİJ�2���g�5A$�S
�uv�do��9Ws#��j؋^�������¼̅���V�b�H��,�J@׏|]����� ٭]���3AJ�ۢl�c�9��P#��H������Ѡ�����9���Kq�t��1 ��x�o�`��W�V�d*Rc�!L�M(z=ϯsX�%���ߋٌ)�3(�'qo�P�j��&)�ϭl������:��N$f�P6�A���8͕�Mm�R�g�Hi��Oi��Ȱ�kEm����=��}K5�=n0>;7��T�j諣��8�~�1�/�§1U�Y+������1���,_;�)��J,��p�[��@�j��r�긒0�6�~��p�B� ����_�M:�X�D��uf�ch�Tg��KN:�s �b�ހU\���^�M[�(Z�c�u���}��m
���H��^��G}Q'3Lر��X�;�����.nX����X��c���.��KcG����CQ<tP�Z�m�%�ʐx|�Y�t:nP̶�$�F�~Y'��]H{��:i��^� �pNs��� ����'l3��8<�Z��.�wJ⾂,K�#F1��HW���o"D��]�����Z�3pF�� ����g�6u U���5��M������_��*���.��&�1�w^�-i����I��^bqE&�����Ak�|�m1��H�
T�S��`�9�ۺ�vT��uE�jNi&�*��-B��pooؙ�)$d�Ҋ,T�D��NC�sڭ��Q�'2��G���It$�c}��1�l��Ƨ��Dsl͸-���9�Z�Hm,
$�\2)��Qw$�m��A�O��Ӊxr���l����=>T��QV��9��؇���布����rJ�����`.I��!����aJJ���4�q8����R�߷��gV8��{�HhBA�i$���C40���EZ�l�%��>y���j�o�c0�o�� Lvr#����=�߼U�7��	����:��Q��/�EI��� :4=m:�qp`CY/�56�X���]��=��$���PkQ>��lb�G�pA)�[��s���+,�yOB[N
�v�/�ycmޏ��6�j+����!����rbwk��{*""��������X���}��)�s�);�ė��=h�C���8�*ƣpB�]4�jH�y5	Y�A~Lマ�$dg$�N<(rB-�r�ӟ�o�^�Q�@����k�>���m�,K�M+�]T��� u�(��j����'K�]�e調���+`��5Ƙ��El^n����[r,���`2�7��z�,�zlKSE,a+���!{�:�9�XZ7&ِ5u���H�P����7��h�����2�E"�Z\��Aq̛�����^b�6Ԛ�ж98@�g�õo�,V��4�d��h�-���\a�_f0�GU`f�A~� 38��f�)v��S�2��F�"5���W	 ���1�gn[+DUy�=`���R�Z��~ �n�wE5lub��c�L��K���\-�N[��IQɚ���q�[�}��5-T�,Խ
	qQ��1k��؁Kth.���5p�,���~ɝ\����6�bS�Kʹ���$��?�nh�-ߵy�%��HL;׵���=	��k    k[/�1��5�j[:#�ɀB��*-�Pʂ��`(/c��;j{�*�;w��cF�
{�a.�l�,���a*�V��.H����M]!����(�S�`�M�K�t�� �kSĲ��:��5!ϝH�kz�}m�=X���*���.|��ɥ:���S�:+
2�|¶+��#�0�4|w4c�'��4}�X�]��n���6isv�$�U��;��+�~�[��D,uL5���l��iH�@n#�k�#R��e��pS_K�debt�~'`J��2�T��.��u��{ە1�Л��^���B�_�:7���^ێ4c��j�0c�a��w.�Ͷ�sY�za�C�jm�JP�Y��Ҫ��;��[��q���da���nIaɐ���\�h|�k��[�يj����w?�������)6�,V�6�ӆ_�����:J��y���-�E���5�R�J�&��+*�*�w�(�2� �t�.�`�Ȩ����� �!�"/�N�@���1�0Mm�D�MCwÞ=/B�"��sM�N5@�%�2���\�R�-���k�����-��F����tlmQ���E�C%�{a���ON�c0ñ��	����/���R
��3�YL�fK�q���Xl�b���N��q%�<��	[�q࢙����:����Dr���D2���p��_�m���#c�s��\��f�yʶ]ɨ��U��f𓂽��DvDGş^��-xw�i�.ut�.,ݮ�:�Dɂ9�+��!�����!�*H�x(�j:o�fa#�xt�GmS4��Y�8�9l4I�����#=�i�9bID�a��!]�@[��xq��):���ֶ��:�P�y��so���'�O~^�mȷ��xU[��K��T�,7�����G���08��M&�,>+_�i���ʷ"��IFV�-7��Qv�p+r�`�&��7���+�*	r�D�p&�$�Un��~�w9|�m�JﭽLf��V�8��_��c�Fvaf��p�/^�@�B+�_!,�%��(t[�.F/��"�h�c��|�jۀ�bb��7��+m����ӸHB��3����ա���n� @��m���)(�^}� x�Ӻ����VȪvmk%�O#�T1FTA����y�P�7,'ܻ�V�gచ ��W���1���n}�L�&[>,*t�q
��\7�������-4i���W�Ɔ���pz����[��E<��/i&���>X�4�uC�.�{��@��eO�2�BV����e�gK������C��ay�{�'�+�}Pڭw�J
aj*N�0�L:����`���85ף�j�ge����#~�ސhRؤ|�m��J�M�����ݒ�ۯUx[+u(��&2���+t�%���:}��6�>=�x�����h�ݻx6c<�s7��|��f�yJ����}��wlу�.��E�>��c%DL���p@�K�O��G���u��9��_�=����P+�⋯�5ۏ޳��o�n�g��`w߁�߫\��{�$!� S��v����D@=�O��5R(y���QP�H�g�9�Wa�ژ(�'i �Lo�>�n�{!^�*_�#�k+5�BQ�񼫎+c�;,R�$�[s�9:��kװ+e���s�ծ�x`�4��X� p�$��g!O��.�}��l-�dy��6Y����w��!Aa3M�M߯��������˺_�W�ʦ����hX�������������Kɓ�F�n "�j�.�P�s�� kT�(XDP��������uH� �xlN���<����ɹ�Z
0ū>�P
�#�s�o�1��ީSelGJ��/���;MU�1��
ֳα[9��&Om`��_z��n�=��b!��ir�~M�a�/M�qJmKI���-��Op��f-�W@j�u�A���lW�&�P��8��R�U�B.�N�k/l�پ��?��s-|pT��x�*H5�.ʺ�*��4���qRo8�T�&�M�n	*UP�Ǐ�<%�Â�P�s�9ϐabͶc�����Q�����]��`w`r�҈��1q0I�lw�e��Drͩ�h�.�ˆ�)'�}�yFŽf�'���@,���/ݖ�lդ�����6g�Kߵ�,�}/����c�����#�yb�U�Z�����+�(c˷�_Î���>��I�b���ۈWϲ�/�.,%�w����f�7d�k��� Z����q��u�K<'�7�%�ۨ�� MB��;r���N���U�t��G:��*��@.��M�A�?��(U6���j�y�6��Q:!@�Tz��\An�����
5�������X�d�@���%�7��O���N�g�m�'׃��/G7���S�\����X��Y���<F��8J�?��J�iю$�#�aG��|gA������;��f�-2{��ٯ>1�{fJI<ټǷ�XC�Π�nL�Dx��򄃏5�]�)�;A�ORWD�M� P�:��l9�]A>K�s�=��K�C������Sc�e�F��"���".�}ڂ��z]8�I	�5�Ʋ�7����v}��O��N��+/^J9���֦��#�r�+1JjA|���X+cQG ���xWG�S�J7��}�ˎ7)76g;i��M��˺����g%J@Q�55���+_��Cj�iR���z=X�7��O�ir��~Śz�(��a�`@܌����+�Tҳ���f&�4��zp�Ĉ/����w���D4X�jM,r�(��W��5�<ng1����}Fi�Q�i�ǔ8��;ԓS✉kh?i�,�k�I�q�V�
=ݷWC'2�Q��B������2��w�P��E�A#Y��Ӽ�<�GRm��h��b���6�	S�f����[zP5C�.d�>
�`�aA��T��,�7m� nP@��Z�g7���rP`�h��h�YŸd�:��\>��H2+b7Cu�tN,"�o�IU�*��R���0���H�4%�@/�M���?����n:���X.��7��Cz��;y&g�_���7p�-�Y�:���3)�-�q�/�/J|!�ߝ�D��E<z�E��Q����>/�D�L�nw�Mf^\倓�~IU�?�U�6��H��鼪Ze��#`��@<ժ�جꩼMQ�̜�hz�-��WqoIj�Ydg��O�(����U��h�g�Z'�,d#��0�N{3
�<������ӹ0� 8ξ�?!$��s[1�*��=18ZA���pX
�=���u=����+�M����]qU/�ݟ�^����\K��(��[4|�s�7f��Q/N��:�S�	ߓl�i�����U�7�D�<��T�ζ�b����ODh�TE��L�&�[��w��8����-��0P+F�\K��>���B�k�_�g
��k�J�i;y��k�'��|B�'��Mb\ʹ���u
��تD���TM�#l�5= ֘��V�y$�&�\�a-��d�7|��k�ӳ��ҝ�_-�*��˞謅�N��4bA*���A�*f63G�I��.;˄�+��WE�y9XƋ�!ۭ�������)LΤEzvVµ8��NiA���$+���ߵj��6�h�*Z�3�N��~*Ζ8^\n���N�!��q���H&NKru�}V�9W�z&$LK���Je�����ݐYW	�B��ˋ߼���P�蛇����|������'�؂�H�4[`�ۼ㸨�8sk`�ԋ���?���	�N>^[N��4��	����͐TVJ�*�`O����;���_�I7$�T]?��]���n�P�;��=-�OŲ1�J[��m��%��͵��8�	�s�?�{�0�4�d�j�� ��(�{�m�k�Hu��.���q��8�}��Sx����E&�͏�)�b�#���Vq(������Tu��'�>7�^�����D� 1�Q��^����:>��!dҧ-7��A���b�+�ⵁoĝ&�+*J�՜���Jq�~]aNˮp��$m�1I�R�����$��rk:EO�K���FA��U��=\ěBp}��2�b�=��XP�/\8�    aT��-E;��@�՛��ήA���t�[�l;-ڋ�.G�N�rQzɓ����p�/S��+EQc�#�L�9�q �C3�l� �RM�^JK��c��4{��r�3�2�Z�Ϡw�_��Yh�����^�e&�k8�����|�1������������,+b1�h��DAc_�>�(X֫u�2L���I��K�=��s�Y>�A�f�+���]���0I�F0=�u=�Rö�8P�0>#ʠ�]D�z-��:���%��9}��V5x8}��1}x��_���*�Y�����I�.Ug����tzC�%�ˠ��-�)�������oC���ɺBu�kC,%���� nRJD;�����A�Dq��G��;���s]�<G�=�1V�zFoă�$X�T��M�ρ�X����wQЫo]!p���������1sz�-L�����D���L[gնw�q	-L�8ﴲ��${�l�~�M�<7<����]�#H�VM��6��9]��{�K�D����A�|���n�NAE��8�ӟ�B+�i�$�9Lڃ",i���6��Y� t����az�޵%�]5(PI-I��h?F����[~�㭞�Q�wmk��Ԯ����O��]��0}�]�1��̀k�s���J���؈�m�:�����hF��6�C}UcO=�`~j�
OzJ�b�����H�j���x�rYs�wo�̱e�۩?��氳�hM���U���?-*�w�ݧ�¿�cl��uKy�!ͺ�׼;a��H��{�0J7�9�f_��i:s�x`�Ь�k��Eb� [>�Ѽ+��r�EyEt�l��Z0>�\�U��u�c%����};|�~��jV7�3W��
Si��P�6M�l�J5����=��2��b�/z�> �W�S.�6њ"���i����]>��"sؙ��n��z��D�)r
�7��Y�*��^�ي���1�0�׷�\� 
<'��u)-"}�]�!�z�cUI��Z���=ϋBFܐI��(�S���T1]�F�s$F��nI���z1����'�̻e�Du�'�w2
�<'�4��@�	��O'#}�p��ԕ�>H9��kr�A�Q2Vw-�gc����,.u��4�y^��C=J8 �!pOiw7�<0�1�ue ��%��<Fɏ{�ҋ%h��n滐�Ee�Hβd�n�"��RY^���I!i�puw�+��M��hؗWp#�6L�3sj[+���4D�qt��WrMqP�TiŞӠ�N ��.mH ��i��ǸO��Yh؝���âh��Z̔�5˻�ܵ���A��/��;�hQ��I*��1?��}���3������-c�ZA`��V�>ϱL�?�A�ZťL�_'�� N-����Hk\/�'m�!d�t��([r�ǜ?����s):+	��,N���$q�\���W90�E^l�|'�Pa�"pR�g�������^H�1�D�1	;0u�S�6y$׻�U�ӖH��Upl���T�-� ��ٔ~r_�ZB�4Ӄ�˃nAm�"	~�f��@"-���R�R!1�Cb��B�ӄUIC`s����[�[�C��Q`��3�����Vud����t�E3g�h^�0���k8]���S4:�0��A�y�x��,��I��M�ǳщ��|�.߈t�fΉ?GE�r}}�G�쉻�'�L����%*�q.0�r����p�A�>����~��?��o����Q-/8���rj[cz�lm�o���f�ͱ�fV�n���)_��蹡x�ǹ��j^o�m��&^hV�B��L����N�_g�O�qS&E��!f�RQO~d��� =e䧾����+��Z�C��U�`��˽.Y��.}�T���y�D;OY�t�*�����&ˡ���*0��a� C�x�s	��Y��QyGo�������Fng<�Հ�% ',�sf�C��������Jڵ�}���>i��_��oN���G"���}{���h�r�[�ÆS�D~%���X��%�kSN|�W��ȯ1�C-�om���Zh<5\�
�����3�n�� �@���kS�: ����ê����E�;���{�2rV��:^kZ��I]��'u�ةf�~si��o��%�*m=1ė����R>7����do@�ČI<�����L'����}A��Dܗ�%���2m�i$OH�%����e��-��Y�^|!Xu�ZNFO��F�o)S/9��n@x�6�w֟�������m�*��߹ ^��gi>G�֊�����R����������5��9�|�-6�h��*}�뺫W`>�w���NŦ^��|_F���#�1{�2�ܽ�r@�iΨA\2Y[�?vc�%y���LK��᷻�(�u�wL�A��3�c����:ϵao����WO�|�6)8௉E�'���fY��_��"e��yZ�x!Ɍ���h
^O��N'����?9��)��� ��Za��i!��2�N��z���-���r�&��ed_������3�b'��Y��u	�A2�)%�ذ��e���wjr%,�K�1��p�X2��Y�rV�)a����[)<3�E�b�tN���R�(�E��ɩue��mȸ�?zf#ܔ+}H�ư@I�.-���GC����s�R��H3��ҝ.؇&�;N�{nV4�)��3��y�e��~�o�%� �Ǝ`_���kԺ}�Ӳ_}��@���� W[Ӓ�;����7�����iEq���_ڿFc$WF��[T����tR!����_ѕ�l�r��<'��k<�E1�P3̳?Y��M��ÿ�b~��[�B��xT�^��LJ�Jf	�>�nq�����3�U�v��׳���]�*�����t��|ѹ�/���Dj���7�)�ܩn�zBB�U3V�Ul1$����dT���RE�륷k.zA�f=7X��i9�����2~СZ�h�0�ui��/�}�;>�ɍ=5����}G���s�_�a�S�;����S"9"��_h8��	=E�_ J���ؔg�=�c��bܸ��s	k=ך��@<�1:�C1�[W�5E��-\xT��n��E��Q1F�X�!�R�sǑ��V�օn
@_e)١����N�aj���DD t�%�3s�����������,R��c��Y߰�:�)fr?�-���=戼E���E<�h&Z��͍)�����I�p�b>�ѧ��d`1��W=�a�+�.�ȘqߢNS�gE�0
�V���L;������)1���2dOt+Py^�$��BC�"��3��CC$����&%ȝ����"�@�P��M�V��d�@%S�I�*L�IQ�`$�����es��ˌ���&��I��:-��t^Ӆ�Ӷ��9�:6G���<���Q��=��= ����u�U��ҖMr^�>������3��٤�/�)3��L�<��!�S�&P���k�,󇖒0�*G�y'����"����e�o��'�|St�np�.ь�e'=nQ�tkdn��dpav�d���ŌA�	^�8� ���Q ˇ������7�<p�s�c���?"�H���7���cڕ_����ן�)��z��}~'�`�~���z����fX3w�
�<����&�ȴ�L*��SMv�QQ���^����t-�-|� ��I^����Gyl���ǜZB]�Ԧ��.�G�D�soy�u�ax4�Us�A��g��#�<F"S��v��$v��� ��(��/��Q�@qK~x�D<A��e�����]�iȾ(�P2"�#��X�&���N �����+�ﰐKr3Л�~��I��[�1N҉'�E_}����|���i�A�����&��j(�=l�m�8�{l/,p�`�-���� _�"=��#f��3�'�(�Tr.�¨z��%��O��!�`�mA��wA2Ʒ��%_�Sɮ��l�^w� ;]��yڠ������2PR�_��8W���|6�������At}"M!D��3�ҖJ٪U!�ȼ,��um����vQb ��l�3g�����\o���E!����ZO�u�W��q�Ӊ�z���,	�J���[����3    מ�MB�(�h����~����VǮ�1pk����'T��˾��A@�����%�,BT<�'(B��i���*Q�uf����$O�2;�r���Pi��\���p���i���%��Y���&��d2�-Cˆ�2x� �UPT�^�M�v΀3�6SS�N�<ԞGZu���L1fv�q|��L4G�`IXE89�uU�o��hP�me�-���SdԤߒ�zX�`.����<���n��"��L�k��4N"��ѣ�U)���gؔ�x��ev�x��ZݰoS0����|*�)�,i�g%���7�ך��}L�?^�S��3{����{퇾ls/��ۺ�jj\�=�.p��3�������
���=aw���2����� -|�}G� 1��3,Њ��~
��/ ʊbAJ��s� 	�4ъa��>�6��Ņ�n���X�|�2Q3�O��_��Y$��R-b՘����a�e�	��G�ME�
lg{��+.��R�L�l��障a��.%�E��4�� ��g�B�����f�t�<d�M�Ü������P*]�Ѳ��,����mjҿ3�l���4UE~�Y�֩�ْɼ"�A��
��bv^�Cg��rJ�K��ý�� ����?�C}b�9����WX���kn,�s��㳕D��؂zR�TNH\�k_�(�D��:BƝ�556���KJ�Y�j��X�~XS�X����Qcf�&'\��HRw����T�dX��l{��/�Q!�2����HƐ�cڭd9m&�r�Ϛ��Nz�a�5X�pX��C�J�<ޮG[p
~(�%A�_���h9��Dի�C�H�J������)a��q۠-A�0~�ă�	���X��y$0	~�4��jLCtb/؆�?������$�yA�t���d��lx�1�S�	J�K�mA�䣇��<�/^�I�&2�!Fm�\��ߖ�$��~�^|B:�}�ضn$�Xö�b�|�@�n�쳒n��G�o|��7,�$w�B^����K�B����|��a�ÑRlqM�]h�H���#P���9�b��YG4C������rSQk�!�ip�=3��I�;'y����bI��ja8�YUg.�@yS�4�m`�_|�������p�f���uFќo�y������#	.�$��o��6N�gȹ�ۤ�.Q ��!���ľ����,�P��WKu���Qx&��',4,n��IձŬkb�%B��+����|�^��53�Ϗ0��~rb�[�C�Sל;���ͬ_.��ꔡX��?G(��'�>34wyfؼ��;����;��{��!�ݞ�����K~����<n�w��D��L0��A���v��j��:��3L�@9���1��Ԏ:�^0[�I��C`�4.���A�y�O��L�fiP��$��\|��U*dg���H������\�\b��L�ݏ���)#�zo�9�D��t\���@�k��Ϡa8�Rt���\b�gZ�����1cMc�R�J�&���4��(?� Z� �z��x%���7y����f����y=|CE/�s�c�xA��U���.���ȗh\kQm �ulP͵Itj�� 5gnM3FM�"�����,&tM7�~XH&����3�Kh��)�U͙x6gm~�ljjߢ��'��)����K�n���QOT�h���NK��D��68�X��#V��tЕ�n��ui84kIҗ����+Mt$�_[Ɂ���JF���{QH`B����ؽ�T16�ez�r���G�Y߆N4���Ö�1��!h��}g���K5b_!D�'��ϛ�@�%�Fy�����F����kU�gse���!�d���j��� <��H��[hƨ8:�>������_A�^��])���� cF�̂*�0c�6��P�H�¬F�<��:BmR���c�f�/�4��q�y�
W�;k���La�ɡNJ!>�[-_~Y7�F��&�@����*�=�ύ�!b7#�zU0ܱ!��|�Br�x���'	���6���Ū����?�~e��7qȟQ~�R`V�0���@H��zm�+枡��� x/5�T�R�x��*���ݖ��^3��KGs`�f�OO^2N��፹�����B'���|]��}��Np<�`�����n��k���wA�p]����,ҋ�R�ʣ�3t+�;T��o�c�a>rb9�]#�$�&g�5����hȖ�x's�l�sn��ڿJ/��Xg�c�;�i

?߆�YzT�~�m��Ԡ?֩��M(@?xD�r;�J�8�e����H���I�^~��61�i`�
���R�v%�4��yw� �[���~���4���.�g#wTE�wz�ڛ<'M��q��d�����V�y����3lǷ��h;�ܻ5�+,�ui�@��i��	���0��ą��\7c��`+p[ŽOX�u<� =tm�H�Af%j���������R�oIt�R\~5�e�^3��F��2��1!AX���a�C��_D��̑ҭ��tǧ�dZ�����
�>Њg�/0���52el��,�gG~K�Vl�0ePc��4���QM�m�����/f�����W�E��lX����(�U ���YM��Ta�S��8�fX2]s"UQ�ͥ
� E���ˠ^ƶ@��S{��'��B�}c�N��[Nd�K�m���A�8R��E�%������m�-
��U���5�,����av�-P�U�+��;�0�w���C�M]h[H2��\���1�O0�V��W��ړ��*�ST4���"���@��߶(8���`*K�f���s��ڧ��6������7&���4TJ�є��<�%��$Di�V��s�p��M~]��߹�h�Ac�R���oyǦݏ,�����΁��Y~R�*y�Ӄ�9�\��~�w���ӟ������\�*K��b{*};���>8�M��w�	,˾*0o���D\��������R@��}�6�{��M���"�-��Z�'����\��8!ܟ����Ŕ6�is�.G_ ^�
((#��|⚰�wɭv���������f��0���&�t�,��W��g�����fh��b�y�Fgb^nf��'�z]P�f	�p�[Nݢm���^a�H&9񛱲�al|W���X@eJ�@�m�˒�[�a���
 ��XS��Rz�YB�]V�#��}�[��B�#z��ן��ܳ��o�Dƛ���{��/gD����z�Ej�o|%�av�K.L����5S�x��Z�����o�?OCYy�_r(��q��6��:��M#/�2�.�:"1J��1� h�Cª�HҠ�_"����8Q����Ř^�(-6�DV)�:��{�T�զ��?�1: 1���vi�����W]����;�7jR8�����y��t�S3�}v��bM��-T$���)Ueq-N=t�	d�5#�^���<�T�Ģ�+�זbx�
P.���YT�)�t����A�.3>U�p�U�� \���t��Ha&�6�n���KJ�%̓�K���Px��L	��G���b�K|�i��YG���=S�\Q�����F��[L
�poL��ϕ�y��5��K�y6�5Y���Sn�����zގ���8�[Ɂ�	!m[b�b�����{b��ee���_��C�=�&���w�x�n%l�SJ��iЙO�l9.?:�nt�s��@�[ T�T�t�I�[�v���!p�>�`	t�#D�N��DL7&�]P:@���y||�N�&}��G�EG��жG�O�"�J�	il�{G�P�FGwC�0��vL�e�ݼ�$�ƯhV?L^H�a�?sk�[	#̏��`۴z�����|�z����揤�P��bI� B�a��]����u�f՞�h��_Q�U�y#����9���Te��7 �0����/�A���M!���e	"so��"sd���3jM�S�x/��h	L�1e�L^���~2M��xS��+    ��wt�����(A����^ܾͪ�jr{���!�bh�R�,B@�Z�{�u�a�y.��Ɛc�������6>�mX��)�N4�,�ت�@�M���p�a{�g�my �p������RL����ۄ�~B�Т�X+a�l���jϻ��/)��N��3|z�,�#��5�2R��G��ٍ�N��yS5*�HI42S�;U��Q�%5Gd�g��f������O�|x�>?�-*�~��	V��-�ȶ�<g�A�������R�.� C�q���" \ld3�ʬ��p��=M㲺�2R͖�C�T�^~:8���|���
b���ܡ�D*'irRrt���p�6��BE�;M9��R����B?yj<[�6��9�`	��Ŷ���wbdp��/s�6m�<ݛhю�jS!:c����@�'A���,n3�ו,�k*2ׁ�������;�^���)�QΎO��?�n��@��/N�R2:i�vK����B�,��%��j���Nԥ*��j��Dp��&�����Z#��z�!I��{���
s#V"�H�-{��3_bQνTiW=l�m�p_����m��-ܓ��<ܟ��܍_��$kq���E?}e-N)����M�p,����ez���L�naf���73d��ǴPO�7{׸��$vu-��\b���/(��Hr�_��YP��9�|��������DZh-P�pk���X����ݍᶐ�N�l�c△Lxt�`�K���:����p�ȩ	ԑ�&N�3l���v��d�Y�jb�5n�f�s1�o�u�OB��Z}r�I ct!E��AX��'����0�©L�M�;���+�����_TŊc�g ͇%Yge����2���Z���� �6�)MVQ���D:)�hnow�_3g�.�fA\�<�Ӗy:gVٞeMͫ��Cb��O��g����������0��/`�5\�M+)-�X[׳Ӝ����9/��I�"�o��(�,��q��iqE�YŪ

y\��?%�/`S�|��lv���K��ď���b�A��DG�n襐��������;c�e���E{�j�tܫ��a���z�x��Q��GH�pC)���D3�/�ٶ��g!n�{�4��u�DE��QJ��hq�5�`qܹ��W���A�
mB�9r��F�~�4�.�����F<�k �a2�̨q�P��p��d��DN�ȊGr������Wx�r�y�Z��0�_�26c��zizg��Iz����+_Ѹ\��d.�0��ۻ�%7�+��_�yPp&��m98OͥeJ�-7�#+b^
@�Q$��k���'�]2ofe���BE�/Z�@VVV�ͻ�{N,��_|�j��=��1\���ȂGQvl	|�_b���T��J(Gy)�-J��a�{��$RT�Ԟ��%�JH7�[2��g+���#*nݦq��9�ʁ"��a����;�7����m�p6�z�8��}�9�0��ps�����B����<�H��1~q�YBx���H��]v���0kʨSB��!\6�>h�ق%e\��K96��w﮵Ί4
�9q��X�Ig�E�R�(o�wB;���k�cV�����'JY�v�r�I�`�rK�N"�������y*.ʱ��5���=�f�؛�𙴃�X ����%E��G�$i�r��B�\G,^}�m�e��)þ���lЁ��ZM�'�0����=�/�t�v��7r6i��#�WBPx�ug��>�L�O�CI�/P0�xE��aƦ��Z�8�����G.tex��W2i_j�G3�Y6��NG�MZ���/�����eq/ �rw.�.w6�m�!��)O�V���Ս~ӣ5�	'��q��G[x����M���8�4\��֎����e��_�d6I/E��tOp��Pd-@��
 [oW��{p�������I_i������튦,���a~}j�O��^n���^��r�©���o�L���,��o+4����`���W~��iǌ	(
�06!��:�Z�H;&6��O-z�%	N��n��+��<
A��o�+Cq�;���i*��v��KI��i����-�%�,�YGy�m�mM����L�V�;N�'lJ1џ���yI�"'sJZ=�;�=�c���~|A�A�p��q�D��V&yuI*�q��r�i<��4@�j>@�fe^��b��^�����xt�N����	�7:�=U�ߤyN��r���lV�&�SJ��t��29�kz!y�n�o�F���0]��s��.����^��e�v��oJ�2ci�̛�����2�������>�k.H�N�2��@�������z �-�z�y�H�Г�����A�4������td��f%ԤU����'߉z��+ �
�)��	����Ȝ�����zue�%��f�W1c/�ŷ�7�>G��~/�"��<�3g�6���(��z8lL%��y�촛���w��l�kf�c$W��Po���^�`�fwU��n����4��u�є�l�R�A��M�Ն�ʷ�e!w]�̯3i(8���g�xm�e$m@�g�|�gZ�nE6���|�Ibp��N�i>�d�Q_�r�X����)S9�Jw Nw��MnM����,�GZ;�*{R4.������	b������J�I�@2)T~�]F-��;M�e�����Ȏ�w{[�Ck�R���� ʳ�� 59����V6�8������~��^21ώúj���d���4'S�~�FVj�@��(\3ql'�~e��+�_	7�雇�6Fҭ4�O��ޛW��9��������ܭ������ۢ�
_lQ�
����j)V��m*�PB���J� vW�|�A�W�>�,p.xm	gB8��gł�^�@�ׁ�a�WL�q�u	�Jz�&F���5p�q��{���ISu}�s>�v�\*��3zxT���������o}�@�������7�����l���6N&J�B'' K�*x0��J�+S?;���t>[����ٵ�U�T���"K��ѽ���4{{a�Ke�$=D�-��ʇz�PXO�/�`�\~IǴ֭�g<�j�d�E�[������	�xC̱"�jC�Rv$�(��Ѭ"�����0�T^��с��,�X��W�������o�w`�@��ZJ*�-5�h<J�9�����|�knf��a�MNx	��7P=���E`A�n�k�H;���b��=�F������[�K����
�+;�З�r!N��n�iC6�TQg(шud���A*�?T�@��x��Hs��u�sw�X�9��0v�:_W�� ������6R@�\XH��88]�}''��_�-�Ĝ�É�R7:&W	�����*��px=�t;�hI@so�[��d��,�!�7?�>�����~QP��]�yՏ����$�/L����D�Xכ��^�˾w{bփc����)�]� ����Y�#�n[��i
9�~�������3��Z���1Cd���|
C�0�h�����^(�ۘ�/f��|��2��BoJ�����Vd̎MD�W5 ���H���#36	#���G0�\4oy��L�+������:{$�4ib	��^�K�����d���̜m>��I�n�����as��E_��!�����$��/����,��/��	�;�BXa1Ҿ���i����BϮK��G@U({��8���l��N�F�s��Ք&�]<�,bk��rW`/T��+������;�˭{�t�XR���=A	>���L�w�=�]�e��q�ˊ�} ��62�w
!�T5����"򪊧� �~�X�s��Y�����'c O��|�Σ�P�@�-:x��F--�nn��Ӧr�Hu^I�>�"���௾��}�6 g-���p)�h�сҢ^7-����`�=-y�� Vl�Z�8�r�%�י���:�)j��Z�6u����3�0;���n�+D`��]��a�¿�&wg[��U�'����H��@����aY�S��ޗ����ԓ��ܩ��=yncoM",ݿ�>��49�N��L�~-�k��1���$mp���[Wa��t�	$cX42��ڴ���ڷ@2��$�>ij�b��oGm6��$J� �  ��gyn��]"8Rǿ�hz��+@��N*��:�5��4��V�ʒ;����9˸�]���w���ō��o�,���j�Y��K>�n��2��EJ�G��� rBz��_7&Q!��ޖ�Dg�.'� �y���Ɗ1(��m��o�OH��9���a�i29\��
c�d�	��~K���,��`[�_' �4�3�a�	+�}b|L�2\2�!�-Q̛
2�Tb���3^�=B?��2"N�A}�soh��Ӟ����������(��MB_���0��49���ٗ>�h�e^��s�i���`���t���a��������n��e&�����?NO���>y�&S��簡0��^VŽ˚C<���& ����1�Z=f>�f��������;Fc��(]����[R�ẕ��P���>ǔ��B!@�P�#�[?�.��'����{W^l��/�L.�Ib�.�-�m��4��#�F�:D[�r�߮<_�߃m��R%զr�0I���,$N0?Q�xU��HqG\�F�h:�)gt:�]ވɵ�v=�*i7�ઊ�3�W�TS�ׇ�Ů)*���	�G����A���T ����GRkP�+3�j��4J2d�y.L�d��j4ף:4�V���ɒ��l���{}���ʤ8�7�yn�n�N�m��\4}XX�� �6�L��ȵ2����-}��|Y7|�ȬfÏļ?'ZHy��
�������������@y}B#�/��ՉG��#@��S;t���[A&`.Y��������m��	�)NV�x:�"O'����>=�}�qϯL^dh�_2C�дw~�6}l���^�nch|���X���d5�SC#J�g�����O��Q�8�\�#d;�y�WjT�v�gU�o�"-_Ƿ �=�7v���Y�
ZH4<�*x�^��#(M��Bn�7}��(�Y'L%�>����e��q��K�q�n�U}���~yw��2<(���tI����I��[��01�jyEץ-�u��J���A��e�C¿e�������ǔE�=�%>�{���x��S�j�Y�����	&�q�uU��z��6K9a�cXB�: �)����_�ϱ=��g��?��n�´��PvJ`U+_jx�����"����7�·���Ђ��E5ý�m�B^��ֆ��B�{w�,s�S.]t8�����e��)?;�Mnz�j�긱�)��hPP�_���C��9�p�#3��_ <��/�:��g0־7�ln�a�3G���y	��gVQW�.�����2G�{���n���:��
ih#�8��g�S<Mn8㾹��M�(8�Ru��}y���A��EP���.�W��'��9T?V�o��ϴ�x��`m�[6�%-(�$C�s"#a��t�Eˤ�P?8��?G�k�7ʳ�3�$�#�JP�D"�]���Z;c��>@�cC�&h�T���ȲM��$ʿ�[
�dQ:����g��w�k��=�!��+d��]-���۟H6ڊ�o4�?���%�)\����>�?.���5ذ9[�@V�B����~,����hH�o҆�b�u�����&��Ӟ�x�+U!ʄ;�~_`�$��v��fl��4F�!��w�:(١���`V���4,�~!Ը[bv�P�<��HkP%��m�'@<])d�&��r�'j9Tߊ��(H�1ѵA�����:��*b�>�	_+b�l��C�6S �kt�>4g*�׫j9d>��v��Z���L�*��o(ݒr��WB.i�3�V	�}I76L&j�Ŧ ��֧�f�ҽ�М�v��v�?`��ݕ��[�J�
��G���-3rdɕ��l��d�g �{�\v���
Ҷ�N���g��뵳�G}4�����j>��f�æ@�7��d����J'��Ǿ�遺w�?�L��V�m��R�f�V�am���=��X��#��S�/ܵ��5�pD�NX�Lu������ ��>�0Z�jv��'�?�`���+������7�CLo���Y��1�*�W���U��*��y�05(X�^�8I���̬P�@��<��$f���/%Yk�����c�ϕ_�TȦAj�&Y'j���e���� ��؃b_��Q-�y�������{�2�QgǨ8� ��	zi��ڳ��=C��79H�G���N|��\ �P��L���y? O�n-�R�$/��dn�#;� R��1�x		�S�a�ۑg���ǐ�m]��an��7;8e} ����Z���G��s�B*X.%w�PH "�"P1[���,"�����|&��[���\G� ��A�Y��W�ˣ���OsF9dV!i���j�O��M�D�����AҎ �}��@'�v�ʻ�n:�Uy����у��;i�\�Λ�oD)����6
�L�V�!��S �|�kQ�]YՍǷ�6��URƅ�r��tOJ�ǠR�;:��,[���l%zS���Ñ��_��ʳ�z=�nbIr�,(�QMV����橑N(Wf�'���V'!g/�u�:���#S:|v�>�q�ۡd���M�i{K&Þ��Y0$ ��ӬE���7%��QK~�F}�KV6%�}�2m� �����&��j����20y����)Z�D|&dx�ȡ����dq�ۖ�r��|u�p����2}S�c�P�'1�(�:��!�i���rq,x�&���f�kc8'7QCԜ�sЮR4!/XMUr�M[���+G���A�?�՘d\��@*#N���۞B�(o��py3�
��d{߃�%���$Qa,��/]�Ԃ>�	m�_����ہ�B��_�H`ٽa�3N�Q	ᬕ�Ӭ,�u�RT��E�����SD�Og��0RK��H.�5U�d٧ �1b�!=�����8�⻣����ö�� 1��.�;LN�'�X�����Zd�DH�~��w�AR�5��"�t!?pM��& �v������������Tf      	   �	  x��Z�v�8]�_�]V������ڒ�m�I�g1��D�@B����f1�4�0�@=I�R�rPu������{3�Zy'uճ���=Ít�����߮z���)<}�J[\ܰi���UΆJs'��K�˸�jm�^����ޝ���?�['�zs��k_r�{���R���]��w3}�|��X�{_A�7���}���s'6�*]r���g�<��wu}N�>'�!��v�c���?��/��D�^������@y�8�7]ItT��� dpu�m-y˕�9�s�
���U����Vy��6��f�fc��,D��P7�	lo���<Fy��(�����g��J����D�j����%�rk�j����	�ߏ�̔���͂�#n$l'*���̭��G]-j�.�E�9���rR�1Q��xX�}�+7��<��s�%�%g_���F��L�Dj���%�b���g��\�~��e�}�;W��M�J�7i�G�\���}�����\#p�@*���*>�MV��#�჻�&��\Q53��.��;b�k���	����zW�7�,��
MT�T��c����c#��E�ܩ���E�>i]��(g�WY�(�n�쫁���,�mm�_D�ks1@8%wY�V�����@���+?�����L�<@z6�Rw�؁�`�-�����Z�"zbbq�.�d�.70�]���G����w�0\����Z���S:�-?B�H�4��x\����7��Lr��8k�՜~}���U�W$r�&�	�e�p�ď%;�L���H�L�\���C����w�H�6F5�����s�#QN�%;sR�⏱,<G�H*�s_�D���1��*xN.����eCA�Z;a�i�l�:/�áe��$Ρ���ۨ���^m�������.yu�n�&��~y�O�Y�j 6�p��+����K4T��$����I
m��E�E4���4^:BwHɮyfN�θ�KO��1q�y聰�	��j�悪P�g%_�R���Ȝ{�:˾��
:�&g}�F����h� Ā�W��<���9ue�Z�h����u%%�a�r�Π?�s�
T�W*��4��F�l�g�}��ؕ�ڶ����$��5/"���@x�t_ȥ4�}�8�F#�+|0�����y�MZ�#@w�A����dĉ`x���>2¦Jx��4������aþVYݷFT<��Q��c�qk��w��نO���o;L�
`#��j�wN0���E;��#y����B5��1]�����!c_��ۓZ�0�ĥaW����ڈ..g4���RH& _�'����$pM���m�l��0�b��Э�n>5c<Ik%�XpW���� /���͠7�q���)T<+u
��lw��E5v+I���Ϭ'�=%����v�=�^Ɇ��=쨺5ψs��U�֠[8&�?��k}0�Ӽ�y�ݧ72c���3�%#
W�V�S�3�[���5B�qh�Fxo�S\&�q?�{�O�oTj�RE�/�d�F�ɕȠ�20h�N&�)��z���Y�� ;�H�/�D�q�^h;�A���nk�f������J<	��m��c;�<	FӖ�}�~��Zs�Mso�9%BOo�D[f�w�	h,��iT	W ����7��9�j�Zģ�0"�z[���O��Z�s�Q�<�F&y��tz�xZ�E<.I&
Q��
���LF�LM��RC4s1��J"��8鑓J��#�Czst(���	_�k�ǆ�C�$���7��d8�B�X���h3��T�r�be����1y�Ɣ�To�@���=B�YG�m�,G�j�\�p�{7L��z��	��᧤O�k�v�@����>�7Gر��Ja�[5
}�(n?��k��[j'G�o\N�{
����T���S����e��Y�U�&��A��J�#A~��F/Q�F0�F ��v2F6G`0V
��DM�N�$3ŠO/h�Y���@��s���%�o2axʀ�@���F��&�,��=ڪݿ!C�:��|	����7?%K#��Xڵ
G����e`,'�e"`b.����uHMM��Ͽ&�����e�-�Lk:͖q&O�"������l�LAR�av�r���-�x�8j9�xvda�M��h
Bʻ�t�Z�jZEӡ���f�?�]�"����%�d�/J��*s+QwN��nn�!"���&DxxT���5%m|8��쫼^/����$�2� ����	�s�X�C�
���(4.�~�g��>����w�[���z*�{�:�Ɔ�^(�v|�a��J��J8��������]V�X�#�'�����r��G�gzˁj4����}��y=^m�wCK�'i��w��_���%�n�n_0���%T�0�D)~��|[����?�����+\8C�/���js����Z ��Y�dcE�?J��Į�;�\��!���M!��i@���ȅ�<�dز�k�&]x��ً�^~�S����g��vj5����<�G$��^��
KS�)���\�g<�s���J� ��\\\�v>H�         4   x�{�{py~Q
W@~NjbQ.�sbIbNeq	�S~9�sNben~Q*W� �|�     
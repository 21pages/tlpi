#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the cmake-3.13.1-Linux-x86_64 subdirectory
  --exclude-subdir  exclude the cmake-3.13.1-Linux-x86_64 subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CMake Installer Version: 3.13.1, Copyright (c) Kitware"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
CMake - Cross Platform Makefile Generator
Copyright 2000-2018 Kitware, Inc. and Contributors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

* Neither the name of Kitware, Inc. nor the names of Contributors
  may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

------------------------------------------------------------------------------

The following individuals and institutions are among the Contributors:

* Aaron C. Meadows <cmake@shadowguarddev.com>
* Adriaan de Groot <groot@kde.org>
* Aleksey Avdeev <solo@altlinux.ru>
* Alexander Neundorf <neundorf@kde.org>
* Alexander Smorkalov <alexander.smorkalov@itseez.com>
* Alexey Sokolov <sokolov@google.com>
* Alex Turbov <i.zaufi@gmail.com>
* Andreas Pakulat <apaku@gmx.de>
* Andreas Schneider <asn@cryptomilk.org>
* André Rigland Brodtkorb <Andre.Brodtkorb@ifi.uio.no>
* Axel Huebl, Helmholtz-Zentrum Dresden - Rossendorf
* Benjamin Eikel
* Bjoern Ricks <bjoern.ricks@gmail.com>
* Brad Hards <bradh@kde.org>
* Christopher Harvey
* Christoph Grüninger <foss@grueninger.de>
* Clement Creusot <creusot@cs.york.ac.uk>
* Daniel Blezek <blezek@gmail.com>
* Daniel Pfeifer <daniel@pfeifer-mail.de>
* Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
* Eran Ifrah <eran.ifrah@gmail.com>
* Esben Mose Hansen, Ange Optimization ApS
* Geoffrey Viola <geoffrey.viola@asirobots.com>
* Google Inc
* Gregor Jasny
* Helio Chissini de Castro <helio@kde.org>
* Ilya Lavrenov <ilya.lavrenov@itseez.com>
* Insight Software Consortium <insightsoftwareconsortium.org>
* Jan Woetzel
* Kelly Thompson <kgt@lanl.gov>
* Konstantin Podsvirov <konstantin@podsvirov.pro>
* Mario Bensi <mbensi@ipsquad.net>
* Mathieu Malaterre <mathieu.malaterre@gmail.com>
* Matthaeus G. Chajdas
* Matthias Kretz <kretz@kde.org>
* Matthias Maennich <matthias@maennich.net>
* Michael Stürmer
* Miguel A. Figueroa-Villanueva
* Mike Jackson
* Mike McQuaid <mike@mikemcquaid.com>
* Nicolas Bock <nicolasbock@gmail.com>
* Nicolas Despres <nicolas.despres@gmail.com>
* Nikita Krupen'ko <krnekit@gmail.com>
* NVIDIA Corporation <www.nvidia.com>
* OpenGamma Ltd. <opengamma.com>
* Patrick Stotko <stotko@cs.uni-bonn.de>
* Per Øyvind Karlsen <peroyvind@mandriva.org>
* Peter Collingbourne <peter@pcc.me.uk>
* Petr Gotthard <gotthard@honeywell.com>
* Philip Lowman <philip@yhbt.com>
* Philippe Proulx <pproulx@efficios.com>
* Raffi Enficiaud, Max Planck Society
* Raumfeld <raumfeld.com>
* Roger Leigh <rleigh@codelibre.net>
* Rolf Eike Beer <eike@sf-mail.de>
* Roman Donchenko <roman.donchenko@itseez.com>
* Roman Kharitonov <roman.kharitonov@itseez.com>
* Ruslan Baratov
* Sebastian Holtermann <sebholt@xwmw.org>
* Stephen Kelly <steveire@gmail.com>
* Sylvain Joubert <joubert.sy@gmail.com>
* Thomas Sondergaard <ts@medical-insight.com>
* Tobias Hunger <tobias.hunger@qt.io>
* Todd Gamblin <tgamblin@llnl.gov>
* Tristan Carel
* University of Dundee
* Vadim Zhukov
* Will Dicharry <wdicharry@stellarscience.com>

See version control history for details of individual contributions.

The above copyright and license notice applies to distributions of
CMake in source and binary form.  Third-party software packages supplied
with CMake under compatible licenses provide their own copyright notices
documented in corresponding subdirectories or source files.

------------------------------------------------------------------------------

CMake was initially developed by Kitware with the following sponsorship:

 * National Library of Medicine at the National Institutes of Health
   as part of the Insight Segmentation and Registration Toolkit (ITK).

 * US National Labs (Los Alamos, Livermore, Sandia) ASC Parallel
   Visualization Initiative.

 * National Alliance for Medical Image Computing (NAMIC) is funded by the
   National Institutes of Health through the NIH Roadmap for Medical Research,
   Grant U54 EB005149.

 * Kitware, Inc.

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CMake will be installed in:"
    echo "  \"${toplevel}/cmake-3.13.1-Linux-x86_64\""
    echo "Do you want to include the subdirectory cmake-3.13.1-Linux-x86_64?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/cmake-3.13.1-Linux-x86_64"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +273 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the cmake-3.13.1-Linux-x86_64"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� ���[ ��r�H�(<�����N�{(Z�]^���mk[����oˡ APB�8 h�=�'�5N���͓|y�P���]zwZP��������0H^��+�[^^�\_��gks}��������Mx���Z�[���������"� ����
c >6����ecm��ֿ ���X����`���?|������W�%QQ��g��ϢN���b�E���K�����������������]�w�~�W���rk�\m���ᗽ�@O�y��;�h�}�c�/�|z�<���8�W�^:2�-�I�F�(��0�����b�.�I/J��A�9�������i4J��}�]ŉwq�}˿�H~�/���ǟ�ê��{n���]헟�%o��򧊇���+������h�}t��4Ks�GY��k��g�Ma��2**����V��i^�0��#�ڦ����0�&�����^bؒ���=�����&
D��xt|�9�xM����\ֿ�6׽f>x�^�_�{���IGE�&��O�_vFAq}�T�Ky:������0��E�\],u����7���{M�h��������gב����'�����}��qt��~�y����⤈�~FM�?��_����4��Wc�� ��G��v�����GQ�c�
�m1`j]g���~ƹ��� :|��Q���7
�k�g��Mp>���Yq�8�$�2BGy�@fz�GY.�
��w'�8���E��24rf	������.�)�f��|L�R"�3 ���E���Rǟ&ԋ��w ����i�N�P��pM���v�L�vǦ���P�]�ƃ� ���K�à<y�
������?���3;R{����f�Y�8t��x��K��a��*��{�/Ok�������c�=C�D�-���,�|�4�-��(�~<������?����
�=a���t�������5B�V12��>�C.`�@HZD��{�ڂ��� ���b	�N�k�Rɾ��9�^��)&���;٫��ߨGH<{��>l����1cp;��%��p��b�ӫ�׮�,�3���e�Y@ɤD����n�9�G�����,�Z C�;N$�R<�>���֝��`nϞcOB9�U��`����܃�DD�2�����ܼ&X�gY("`����<Z�$%����#_#"evF-n �P
#
�����'ڳ��򒗏GH.@��ğk�x�.QC8 t��'�~K� �?2�m�&K�ivâ��ڷ�Z%]],�\C��h�P#�Y�NCf�rPģJH$��_�(τ@e��=%��)�k�%1�G����D^"RA�
`ۅ�3��C ��N�%V[����X���g��# ��`����A��HT�!錟��C�Lp��~��
NHƂ�_@o'4�:�����.]��9�N�9���,�~؉p�!���L��� ���I���P�7��*��\S"1�駅��=�~�^s3m:���	)�ʗ��g4�Q���k�h���͏�ʭm�o��&0���Uٓ��C�0KIHQ@̳��&B��Nw�#�Ӹ{�<tn�7�7����֨t.��������'��]�ſ�n#N
>N�ʋ3G��Q(�߃4	7�n�7�n�ǡ�
���W�����^Z��]|�6���7u�C��9����)q�����0)+��oļ�JJ�L����s0����1柎���D���AÕ~ǹ�=�Ҏ�AN��f��4�5#jϦa�wa�%
�Lĺ�S�@WGł���b
�Q���)�V�2w'��E<�
��g|��P6��`5�z��]�m��x�c�~���Q� ��[="��@cU�
�����O?�3^$��AF����)Ve� �v� ���X>�Y��sL@q]�=KIi\�̇Av����?8:k���!���a�h��/WV�F���Hed��9HL��e���6D턢0�w�
^�2,��-�����*s�Cd�l���?D�`�VЍ�|ͷ;���NGh$|QG��M�T�� �zxW�A>��tځ�t�������v��5=�E-��?=ɽј��T�A��aLo��h ���:�*�)�	�F�s!8�a?��-���l J�c�tYFM���)�z��vh�j��H�
r�Qi���d��qtX�(���U;��ɍ*фᘍ�
�B����Ák=�a�_���?�y	K��WSP��)�y�;
�K�D�s�,����{��N������d�^�Q�𦬅 ߑ�k> Q{I,���µ�h{Q8��=<�Ae�!g��0��� f.�v�[�cF7��ĺ�q�N��
>���9�rh���a�a�R��֖�X���*�e
�g�!�R�Ʊ���r�A�v����]p���`=�xų�>B�{�g��F��S����e�Eabr3V�TP��6������|�`�P"�$D.f*2A�K�m��B\;$:��Y��{�M���Ő��}^_,�E/�2��*I3����1�C+��������˓�8���PBe�)��e}+��Y���D3`�`8@�#T_x,�Vo��6%�����G�K�G��\��m��X-�|���}Y㌠̻�^	m�`���N���������k�ޮ>��(���^�0�x�$�a
C��ǔշB�
Q+>v���@"":�G�]��lLrn\�P���*���F�E?�?ic��6Ν�F��w�2�0���j- ��B(%�|��$��v"�I�sCo��GО�k������MI͜R�0�5P�Ȧʢ'�va�3�.J���$K��1ѕC��6�h�Yt�6\�eh��+��&l���Zİ��z�":A�IX��e���]�s��)���B?l���&�Q�$`���8&��y�+��o�`1�D��9��:�� [2�Vu�} �� J
@l�?+	��O+����L��tD�\?Wۋ�f�V ��͵-�A���DZNA�/���WZ�
$��B[$�\���\67���
N��g���`�?`n�O���>����"5�?�$���l����j_nJ����s���HqUP���E⋩M��;�Dx)�!D��*�si?�p^���	
Z�>
N8Z������­�jkkcc����W"��"���f�߆߷�"ceem:��,��ǏBIw������
����Z��u��0\[_]��
���@��o�B���L��ǏB���fk�����Zﭶ6���~�]���~���[����VV ���V���\��	��(C��ֻ[+�A`����^��
��խYTog��?~
�k�}��e@	�:�Ua����v���7��m؝-@j��mnk-h�l�N�
Z+��jo��x�q�.��l���۰Y��V�������nkyk���[�l����jv{��zk3Z�nnڷZ�F���v��X���rk{�v7�(8V���0
`��*���{���Vf,�����`%���m����V���66Í�n �믴6��VZ���-��=Xؿ�pb�l��t��h��]��6 '�Vk#�^[�"X�n%�hm��mmG�/�[����^�ۋ��V��u��m{�6���:|��#�&l�z�������Fk���چ�7�[-��x
m}�Q�>"�	D�CR3������y�G��P�S4VX��(������g���ɍ�F��.��Cz�V[�I�a��F�Bٳ���c�~�QtF&˞���i�I/�9&9Ā�v0Q�����T*���i֓�(A�E��C��� ��O�_�6S�-aUBb��7���L,8�&�����2,�Q�ZԆǿft�"����|i(C���Xqo��
&LS��@]&�ھ�Jk�YF�`Dy�8��RO"c3�tFS)Ǩ�e��U��I%�B�����3.����p��e>���c.g�:|x�Eg*�Z�MX��.�PSx�r"��Af��G�g��e�%Ge�0)gw쒪ǿHWÓ���k�V����?�I/��9����׊��+�̗mB�Y�Ҟ�9��Sg��h��,�����DB�>� ʧ�#�`Rp�pn5W�q�9ߺ�B ��w�%���d� �`�,�ֆ�t*ۺ���kc�:��>L��Cgeyy}���	�-�vn�Է������1�8~��ߗNv�~�}{�%3 K �|||�3�X�����M��4�BV�rdc�Э��J�)J�Dv(�2l�HH�� \�S΢G�ɿ�D�R�� ��1�d^�ұ���|V�54���C�!`CmpL�,:�k�(�[��x��H�;y����>ǁ܄��E�0Hr����ysn�E�#�xJ`0�}���t�Q��"
�8w0�a���p��e�F	�NSZd���WH����Uͩ��-*g,*g,*g,*g���g���{��XY�\Y���p���E��o��a�?P�o��/����q�?�?���=[�;X�o���(�T���I�����9��r�W+W'�7	q��JT߬
�k�'ז��׵� �}0�RFQ��8?Y�y}"3���+�A`Z�x8�[5
��0�Z��̋��z0�R~f� m!-J`\�A��e��9Io�T�Iٲ@N��o���#����iȞВ�Kk�s��z���d�<��R�ݕ�ڳ�V�%Y�$r�6٬��[R������<���y������aܙۧ�.�xy�N�8!����^����#~�I��.�_dn��;�o2Q����
�^=�N�7D����_Qe���ݝ����T���~O���ёR���ya�:��Ҿ�-E�}���aeP�bM�xhLmEb!&�Z��8=V���N�Wal�X:����Ӈ�i��ؙ�_��AQf9�,M��}���h�EM2��D`����W�������1���gx�ֶ:�=�{W��^kt�+�R�Щ��N�{p�~�I�b�%s�wV/4�17'TJzZr�0�)z�F�M�
ے��v�@�杘@פ�'s+b㒆��L�,���.�%hT�]��ܹ0�I�@�8�ܑeaj�'= ��Y�+V�h��d]�[�[�[�[�[�[�[�[�[�[�[�[�[�[䗛��"����E~����n��̅[�q�4�X��w��k��nn�,��U���\^��}���;kw����Gյ���Y��-������:�p)x���;�/�u��
��D��Z������v�I���O�һ��-��T/�6��^݈��θ��:�d���kI���iϩ�fS �u7
�5�r{���C��@��%�!9�����m�0MY&�;>w���B��Cǈ�* ����G)(f6��Pg�㥝�F �=�g��Ww��>rҸ�̀*��5d-ʱT�� OK��[�=�q�|��q���((�1ӳ����~D"_Y9]��'�q�|���of.��W8�e��?5X!��"�W� ��l
#G{~�Қ��F��\\Z<7	k��5����r�&��+S�$���cd�J�C8��(���@�	+2htb��C�t�&7e�iC��N��7=���R�/Ay@������9��Ui[ꅽ=b��\5�hu���\�#��F�_������2��� �B��8*S���N�:$㍉��LyE��\����O��k�d��}|yrz�����\�����Uxq}hX�1��STtf0�����,�B��K�u���/�Cg^.�*�9�R�Y{��rJS5�:�{���!hj�b��J��Ȱf@�R	:� �(`�K?��̉�Ჲx�>�Vb����1T�R�h$bS5Zr��jf)���1H� ���A2)�)��-<@�:ux��Nv�}5��3�_]��=8<?%���]b��E98>�l����er�{)�PED�1g�>��D"�� ��1
.b6�Q��;S��Br�6�Y2ߣ��s>��},
_*.�%J�%t�6�4^DU�k/gs�q!�m5*��:�J�N��j��u<_ىjf�Nk�z�,���Cn����MT^�ȟ�n8
����-O���������^+�ov��n��C{3ZI�0��l��9�P��(����v�.�ӆۈp�w0v,�x�[P[���%%($ܹ�I�M�$�\�A`wa�qD�
�,c�`X�}S�F%!�	"[a��dj�OUF��@q����蜏5*���2NB!��/���;��g�W�|��d�U�E�<@N��9x��h�����fh@(�k6�]Q�]�ȕ]���$,P6�o�~��+�p� �P�3'�U��r�����}��
����	fpt|V:�3��v%�D�g�T�T7��қ]w:������`�]Ŭ��5�x�������(|;^��?%yY���H]���(GK2�z* 6w�`����_�
}���J��w��dG���J����Lȕ}PF���<M
�19#�5Sp�i�	33�C;�QJ�˒��
f�OM�T����E��K%��M S�G	����x42�M��ꖁ���<����E1܉E3S/)��=�\I�Ec��S�tZ�ٻ ����.V=�V��0�-�o�V�:f�\3v:�GE��C�
i�7��L�I�*��k�T����J����|���K���B�T�)0�Ƹ7ƽ�~��f���d�u�w_d�&'���1yI��Ҽ�J`�&r�J�I�P&{�S�J��L��&�e��� I&_S��ڑ�L(p�բH�(�4Ȋ�S|*
o}���z�T.��RݒEs�?��W�v
�)CMnqs�}��x�d�M�rF�i��Ĳ�c���i�S� �h�:�ɕ=�R�#�'�Xee�
�è<!IL�"9�D}	D�/�[��Ț���]��{ce��o�3GEQ����
O��+񍇵U*a�h����Ԛ>�	<��؃#�8�v΋1N�gd[�O�Q���:\��⮤&�J�q�'J�e�~����Z�&ŏg�MX?Nh"FT}���sYؚ#���(ހ3�"x�V���(����WJݫt�wrruP����=�Q ���ol��� �$e��VU%ЉJ �1�ST�r3�X�`T�:�J%a~?��A�!�%\����:�����]g���9�.�O�CB��mzqU.��/�8<%(�c������T���4��tCR/����$Rd��@ˎ,C9���aj}ֺ�cu_<��Qc��L	��p�l��9�n��4z���8��|ʧ�/K�q��C?t>#b찿�%�_�[�1!56E���*n>2Vߑ}2����C���g���� �ƨ
��#$|o�ƻ<OØ�=�-1�AS>8ø�Ҍ�u�ϫJ�.�k�ok.Dl��CPf�~2��.�<����r��s�<Z�~j:��إ�j��\���WO�Ad�z�r�iqH�E��ь���ģb��KN�;ƒV��ld黐|Bl��_(���D�d�IS�U���QE��i+�F����˵�0�]��r�n�J��q�E��̭	��z���Yi���^pX���멬���w\/�c��MM[6HG	���2X�� ;���눳Ed@�)V��P����.�䤦��1�Oyt�]q~���Q��$�Ą}JyiødI�~��zj�轠 �Z]�Ąyf���Mj�֗R�2�����Z<Χs��9�Bݎ�(��F^
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
�E
���)�w_��ݣ}�s�Ah���;�_߿�=����E����������X^�;�6D!�)ߜ eT��2<��b�nԁ��H���6'a>;���ر��&5��6B3�X3��Mhk�Tx�i�6��1��{�G�?�"���) M�Q~m��`OG���8v8�ёS�X�y�o���<�1��EC�U�E��JP�=˂�KD�%���/����O�t)��4��iÏh5�M|E���/��{������w�P�"-��%�ɑ�<O��d�OV��J�7Z���B\ԃ_
�f�6iP1ۗ���S��MC��q��q��q*_�G%g��}8G�������]�1�Z1�3G��������L�[���D>��a����N��9L�	��`����)G	O���ao#�Do�+4$�������P��<��:��L�)l�J��;,{ZU⵩�/Fl	i S��_����]Lځ�4��h-/���H:��k�ޣ�v�{�2���"�5�C�%�
�es|KY������T}�Ŀ�$�.�\^��*vhyvK�M��Z[Q�2�(q� ��9zP`i��u@FLR]N���i*�M������Њ-�&1�x@&5c��*��=/���Y����#�J��&jyxib<��OD#�ߩ���MU.,5c�
�4���yl�kL�
y1�)�31VR�<���^����T�՞2�=���ʩ�~���8�S٬ ���^.�B�!��J��
���k��M�_�ʗo��:X�c��:�jF��)�>�����
��j���T*Y8]_!��>�2[l+�n#T��jl;E���������5Qn��S�J/�X`xO�=���<2��{0J���I�2�lҖ�\;�8bp��Q�s��Iŷ�ع'���3+�&�[���q!T> ��YiS������=?�u�@ݑ6Q\s�Ɵv��zN��'�T�E��WҐ���+�g�7)s��UIбw�%q�g�m���Nq��U�>ƚE�iE���+�����p�t`R�v�8	Ԕ���fVؕ(�޵�~<>�_�߿�=�t���E��[I1��~�UK���rF��!բ�aj �Q{([9�c�B��B�Қ�p���Z=�����냣�ӏ�������ӏ�uS�Ӊx<[�\����-��5�]I�q�����=I�Mi���>��מa}���43��@�˚RR�E��~�g,���kf�F�#�$V�c��6&�8�i��~
;�a˅[M���$S=?��=k_J��'��އ�������
�=z���CU&c}X=�{/������8�/0�Y�A����~�X�����H\t�L墫,.�ʴp���~T��aEI	RP���_�8K��ś��޻�w�]�q����1)`�v7���(`��d"�aڏ1!VU'U֭�h��#���R9咲�{ ��>U/�'�pMw�@�Az#��S�>ccl3v4���?i#�fx88��t�_�?�??l�{��z'��i�Ȇ��M��,`��a��?�t�l�}.[��lX���m�wD��Z
���6����2s6��
�X6�w�9;~�`O�2���Δ�ǵ��0�[�A޽u���#���(� ���x��Iŧwo��6b��J�<���t�f
�;1l��B!��J��y��|�vɚ�mb���:d;Z{ٞ���	V�~�� ә-��݃tm�p�^�ȗ|Nف4�y>P���r����S����i����o�Na��ո���#�h�3���������dTQT<^S����4�e@�{,�����4p��Y����S�7Ż�j$��?��k:����NC�iE萎�~HD���p
�:|=����1�Xۃ�������VJK�gO��w��e4�T�
#vy\�P+����|h�v�Z/��?�p�(�(��A66�I$�(fc!}�����Rᎆc��_�3�8�nR<����_M�'��cY��L���⽔SIQ��CS���p��G˓� k+���
'��` ]��+��A �E$�l�Tq�l�J۷"jO��@.����9ŭ�R�Xb�]uV�:<~
צ`����$��b�
���Nv����߫�LWţ�����.;

���`�=j7<����8h#o��~�m{N1;:������_�?8�t��W�� �����#
��}�����<��t~:>}��;�u�V�5�瀩;�gS��N�������ě�i��~5�\c��Ga=�̜�S�k#�����E�T,	M�Y|ue� �� 6&��AgqUU1��JLiV\�DI9�I��O�����C#C�N�F>�By��.s̆^}�|�y��R�m�D��0m��Ι
�J�f#�Cg�@��*�!�P�r��3��_�xAIX�iFEw�ȣ,�B�:i�(���� RNl]t��#�qB�}_bJ*z83�؝����j*5`���+��䆮SfAB=��ˬ^U�|C ���� 6\��C�8�C����5�6��r��R�	� ���f���5�>XA��kb�{�.iP�QB-���$:��|�F�n�ES,��Q�����N��0 []�D�V��#��䛘�����^	�R�(� ���6�\x�B�m��{����)Fhy+���K+˭-��X�$aS%�x�4˽��wʝ�9�X�J'��1�駼?����X�b����q���'���X[��gks}����Z�k�-����	[k�><�h���_~j@���q�(7���vw������?�?$������8�
2�:pr����;�� �#x�G�
���]�<��y����vW�rL�����8Y�����4 �S�UW�3�M�G���:�s��[�Z�Ӑ�X�p7�ʎY�)�2
My�@>��	��t��-��КHQWw��7�K�=�Y���Y���,DG\c���� �5�q� �	�{�x�/(��d(��;C���R���������
�����u�pV\l�k%�Q��T����R0��Vx9B4�8���>@sɉ�J�����׀321��;�R�y	�]*g(o�@{�����^],�L�w,�ɫ�4 ����|U�,�Kp��?H�o	?�?���J8�W��Yз⎕KyI�
��	�3�\��3���iK`��\;�>P��y>
�j"Vo�����\�|iG� 'ȏG�IXΚ5�g�0��c�����&b����X���bA��Q�������9�zտ9/V�pg���e�v漸Q%=��F����=�+�)M�<��Z��p�6]<�������	���]Cߦ�<^C	ߜƕ�
+&f�I\7�51��`�ơ~�����n����mzx0mk�h[���Ѷ�����9(�� �.a/����n�5��]���w��W�cs}�����R���m�V�����F���W�I��n���϶�Q�`:����1�������n�����+���������ޏ�o۝���6����x��'�����pptvz���
�k�E�#��o��#\�w����X�zAU.�rߎW)nS��`zw_q��x����Yl�H�Cn���M���8[-�#� �p0������5��9:`�E--����9����_�f!a��rް��8'��^���In�Ɯ�Ľ�տk�Zs��{���N����?�%�>6�[x*w���2�z�U���
��u�*�!Cz���0��i8Xq��z��)%$�[�u`��Å#�	��+�q�,OeDK`�he��ˋJ�Q�Y��A���D|�7���,���7�ch��lx�|ij��������Smߎc���90ى�p��=A.jO0&�
D ��z=�ny<kZs �><J9�r�5���P7�,�!.���p��a��{
�/�k��M=�pZ�BCf����2��'f���$r�+2��+�|��/��N2��m����RM&�OqY�����y0~ѣ���q�.�=GЂ2����p��
Dvp�=���z~��
Դ�y����m��pg"�d5��UEL$�LD�x���(VFi��:��ۗo0�ܗ;r�b�Wvn��8����T{�)凔Mʣ �\i�i�M0���q����ٛ��}̈́�6�N���.��xqnd�Գx��x=+�{� �o��[SNN�4g��I�r,���gHA�)8���RpTa"�
C{|@���b���E�S:�g-�¶t�"��6�͡��,|�G�K'��7r8{ǲJxm�vv��Em��g�1�v�i
3Z����'�i�O��ip��.�P��
Ry�KˎJ?%�Jό��y��Lk�}��T{�����/['���P-ƹ����r:��s��Iu?2�$YY��&�T[��[�#No�a��2J�B����͝�K���@��������N0*���ɟ�n�\.��m��Dh�FT���Iu��՚q(f���Nd/��_
��W��I�Ub�{
Ï2��[|�����Q+���X.�a&D��o��?��x|~6K2��x�PN�A��&ʒ��� ���D�o$9�n�i[Uʕ_��%IǯW��y�#����iz����.&�A�n	/�;,�z!�/�0�R����4��{ 
�ׁ6i�{�g��S؉��I��O{)�0͎`�p�fCO+�i
N��_�:����(�)I���<�6&����4��Q:d��$�9���E��C�/�RCԪ0����L��h�:�i�,ꦢj%������}��WG������[����z��'5]�r�{wU�1��U=ǼwW��z�h9˺-ruGܸa1&���LjN��F#��V4Ȫx�o���fj}�����{6��t��٤�X
�/]ؗ1ŗ�
�5���4�`|����GO�Rz/����]�J�N�F!�S=nl�PS=��
����ڝs'>��4��n�ݭ�8S~25[�J|k��� ���٘4�ჽMO��5�$�k������|�|im�߫L��2
�s@=��
(��E�ymjxr߭���¬�c,%n�D���_��,w	΂'�HC��;��HI����wv�XE˖��8��~��֓�j.�N
"sA�Gh2r;'��l�B��$t!B?Bt�P���������O�Hx{Fsu�����^���\V��V��_t[�r�h2#�͐;K��+LW��f��������'���9��I:���}��t���CS�׈%���	w!���SSRL�v�$�\��ct����U���!^ܵOP�xR�K��� ����]=_���N^�iN޾�� �ec� ,�����>�e�:�ґ��+;�<��U��]�������,��z�RQPը��N5��:@�*�cY���\;b����9j r91rk#m��mGls��Q&�q��=;����krs�=�#�0w@0i@�&^��kT����}��Mй,�ۆ{ DI[��Q�9�
�K��O��Q!�F#;�]��
��@L���<<����X��Q�&!$&
��R�@�ڕF'���]�*��|RJ�`�+�eas~�$u眒�:gr�{ٚG�ޕJ��~sGvUO3x0?&�:��e�k����X���1$ۛ�=�@��L�q,*�;�!̟Ss`51m%���|�$o�B[���F��~~f_OG��p�+͍��U��J���ׇ{>���%M��&Zm�K�5��
�0�fS>u=�(IT�5Q�z4;�E��X�pKy� F8��Đ3G��C*��&l(�h{�Ah}̜�󖮣B���Ϣ���n�akL:�+�������"[�¥���6U����=m��X��ޔ�5r*v�}^$�� ЦqKI�P�y��	���ۻ�@E��Sd��}k}��&$Z�=GN�8a���LԎ#��iXÜM@	�@	���b���3:��t�\��E��DA��R�ixڢk�CEeL�Ԏ���~�tV�	*An�<mc|%K�Ü��YC�-r����Rw<�������.W�VB֬��w���.�o���ݨwiE����p��PK3tHzF
Ȓk\�d�g@�p̑@�+�:v���(v+��Wb�3U����j�L��`��q��ԡRR��E.�Z������,�C�6pV90���
:5+Q���I#�]^Apt�t0.�\�
=̹��|��	K^�G��ի�S�"�yWK�r
F�Ă-�ߙ�q������Yiz:�:�}�s� W�I�3}��E�G#i{�c���m��;<8������ lŵ�DG�
=���m�k侕=���)���0�a*&*��:.�\�d!N�d=4sp� �Y��LZx��X�Ö�݋8<����͕�f����p����iT�x��?5������=e] ঌ�����˴��L�Vɡ��;�B)Hqi�jn���>�-G	e���l1���K��4��%�g��I+�%Ax��&��j�UrLO��u'�ɋ�G�%*PV��׆"�k�5��!ɑ٘�G�V?�c7���|s�j0��`&]����)2�w�>
�)�ᫍ�K��sb�]mn�:�'*9��`�b58;���T�ھ�������-���2q��c;����6��i�s�]G��,E<D��'8L�yǴ0��8Rr�i��z=��{A':��Oɭ���q���9�Qg��p�_H���\p
r��2L]K�t@��,eanf�$ ����l�"zgH�Rw����'�O�g�%�(��(HP��"�v�����[� Q��Φ�O�	].�j�1$B�r�9��<+��KƧ��ee��ff����0�|�L:�9�ܦ�9���x�~C�
���پ�+mEsU��β��8�Ջ ĺ��w�a}R�� ǉ��s��u����'���yIL�*��~lԶ��N�T.Aډl*����d��D���+�Ou�>������E��ߔ[x~9��/�
pt]v���
�q$� �ƅ%�p�bٰ�h�]�d�T��ӻ� ����v�u�f���m���0����y�E,J��o�<gZ��Ԡ/��S��[�.*A�)VxT�q��T��2��S�b���U�`��P�N<�����_Ԍ�p��������{����$��w��f���@X�\i�:k�J��0��fU
�����C�b�r"�%�B�|w!�Y�Y�j�����<o:I�0i2l�E`���s�,Ԣ6��*aߴ�[��i�~����L�S���)x�-���W�s�����w>w|?��*�����h����o�v�6[���nk����n���~�ޫ�R����@�����vYy���6�k����Zc�n-���jk{������{����tKt�+���X��N�O�Bz������޻.��]������L��D��W��	%R2'��T�ݣ)HB�$� �eu*��Η����y�~���m_p�@I�;9q%j��u�����.'�|�y�_}|�tΞ|�|2	���j2��@��S�����ݝ\~�l�t���y�����\>
������o�_?W]:�ǒرs��P]1k�rb�ec�
 z$M��h�f]���p'n<��kѰ�!��G����IK����
+`7�4�{[��t����g��|�̨VՐ�U�TB���o�_1Ӓ��s0�}�Z��c�jK0B�eyk@�*/��M�����v�I��QR�,R"4I�ɍ�����m�dcF�j�
ʡ{k�R/ؚ�H�qJ*�mcl���smӫxmKh�����#����&�Ɏ�1W��r@������A:��0�&��F�f,j&�_~����/?���.'ɖ� ��\]�<�`��_�L0�&��)���[;�+ꮕG<Y7ȵwi�!W����z�q���2�3�2�iO�jF�Ԉ�(�6��-�R�\ջ{���!�H&��D�&���Zƛ'��[�')Կ��k�\�C,9eT�ׂ�l����'�W��	�CjKw/� �>>N���?�?���sS����'Ϟ<��_�??ſ�������n{|6�g�"��z��(���.���
��]I�M����(W��p�����)z˩�<­@ѓi����O+�|JRRRʯϯ�]��F���(Sd��4�3����`��Ԁݖ�#'�R�S������,�̛k�
d8V������q���̃�jP�%�Dg;E~��~n�v����֪�j-��+%��jh���P�2� ��|.����l5e�L~ϑ�9w��������?+��x��� p�v �vk�9����-)8��U5L�G!]M�UU�!�+h#k\��]�U�ɛ����ۦ���K����a�r\�L&=|A�pX�>�7(�3,��(�b��%�ۘ=���`$2̡�,sV�1�����@R7�/R��Q�>\(�!�K#�Si4�,Jу�"����i2gK!�:�@E,�M�y�$���Ҹ�/$O��״�$�*�g�y'.d��PN�qd�?�[ț�}���hU�, N�x�Ϧ�;�}q�~��f�YJm���u:�}�w}g<��� �r-�*MȪ��53E\��K!�H�!����YO̳Z�Ń	Jڴ�-Ψb�I��eE�B����W�귿}��0��qjtA�d�1���|&�l0����}|�	�S��}�N�C��J��P�]���%>N�y5(f�	��F�ۃ��`?�.�*9.���)Ɵ�ca>E��P��~&aX�ȡy
�yͨxlHa�p�π
g�<����,6�PA���#h7��f@q�B���ӻDr�^ۊ��3��:�2��i� Z2vsK�8w��<�)��m�	��.pF��`\rt��[����o\M`�, �R�(���=R`���p�#�6e�e���	'A�|%�NWh�V��?t�u�(����sXu�c(DP�������!k;���C��U��u?�ꑷ�k���}���WKu����!�"-)�2��cH-�13�`]�����'L�~��V�^�O�X9�U���L6.C�ű���p�=}���pF$�<�a���#&���&.��m��Ȝf�51
�$5=�;9�dD31&��]Ņ����{���X(�_>��i1�}��깾�0U�h� *���!ʸ\�	�"/i���3Ϯ�ʰ�yD���(���ט����p7���r��T3�M�����HC��v���]	�m��pHa\S��
t3`�ˎx�yЫ��վi�Q��ʱ$���S ��Z�fa�!�ݐ��o[���8�d:�v#��&ږ�'$��J'��&��_��vߎ��� l��b��R��3����j��h�.�,�i�J�,
�Ȝ��ׯ����S���P@�/��nl��L9�D拡W���8&��~?əL$ck�Y�I��Cu�,w~�e
hj�e�X�6g���W߆ }8��B�c��ơE�����s�ZA�����}\T{+U]��.�唒���-O
�Y�"�E�:�ԖQː�����V�s�Xx��������s]R�a2��h֗�4H���4a:���8��@!�{h�)��U/榱�t���ۛ$Ep�`��U0�`HXL����*WBڱdj��J�`���-0����-a�fʙԂ�S�%up�/�q�hh;\�`1օ
���mN����6=�Eލ���(��R��$�)q�v`݊��o+~� ��h��=�P�o�o��P�g��t���?��r&1v`��8U��N�EЫ�
�R6�,BP��E�ֶO�&�
`�w�a�`�TE�J��L饭�Kx��b��d>�����`��WS	�(�R"I�����Q�;:j��wY���(���ϸ�%Q��?�M����l�C�W�T0���NN�e���o��Y$խ��D�ꗵ�k�����qa���`�dC��i�Zv;`��u�T�}~C6tPH�����ShQ�1��Q>a۽�\�̡��N'�k��m�{}�������%[�
~���_����/�=k��{;�ƛ˃��,��NE�0�_alY��m�y��䲊�О����dJ��m<\N�>о����e�*y� X�Yc���G�.�ȉ�P�����H^��]�a�����9:4A#Ś��c1A�:.o*BSW���`�5�*Z�-ʖ@-v��K���lO���k�̬"46��K��!4�b�����G܏Ϣg7�r��R�Q�b��~�ɡ6��Ϊ���9��,�E�ʇİ���~Q�75����O�l
1�����mSnY	Q����C��R�L��D|%O<Yj�PL�l�2�y��
\�s�p�u��\p�U�x!j�#Ȍb$x2��d6�������w�ث!�,�|�m�z��&�X@��e9��];����K;��$�Ky~Q�
V ���"��!��6y���$ay�%|�����ֹ����$�e~����_7�8��
���O�<�����y��ԏf��{�v�� ���5@V����q��>�)Q����H���/[_�~�]�Y)�\7C
�
-��3ǆ�Y����&��y�|���J�+��S̈n�-��
���(PZ����a�#��5�v�ֺ�o�o~�#��O������m������ԧ��&?=s�:����*��V��P�B>����G��VK�`����:��.7�.��Yn{�c����Ȑ.�Ã׽���{����뗺$�+�Q�|�(�HA�h�bQJ����[9�bK��w�N@�Bp���h��7���v(����4-A`�Sy�������Rπ+��^�H�I�E�_~���]��
�k�*�P���2ia�X7�~S���ES]��4!N��G������G���
f���ɢƨ�5��d�V `���WWe&��-���{�59m�U4���as�Y�r	qC�	�	�C�E�Al��&t�;��]��m2>fXzh�sI.
���r'e�+{��Q�/�S�dW,�+MH�!q[b�(��ⅰ�-}y�:u>$�^�%�8�2��'%��|�Z�:��RRGQ����}�g�D,n��Ǝ��)l5��"ר��%x���^���������/�g'��Ҁ��P��b!t������v�)�Ay�T02oF�N�p����x�1z�?�w.F������Pn�{��i���/ʘ#4 �ߢzH��������o�I=�p����Z�.�Pe�"\v�lF
A,%��"�۷o]D A�)t�n\�KR"����Q���_C�!$0G�	�ɛ�9��Y815A��E�V7�c*�l���|�N0&�*3�`����^���E�]�/�kXO��|�u�{�~i����S/���
�(,���c M�T{^PE�8^!g|�e��,
��z$��KJ��z�Wi�Za��N����k/)K��p"I`i��.&`[�
���ٴ��Z�u��z����.���0Qnt�^�6�V]I�f���{�ԛ���5�|A�^(�5+���(�5޵�C^F��[���Z3�3�l�@���o�ǐim�k�t�{&�]�F0��P��y.�v��.rF b�`]����!�Fw	Z�髦*$T"p�uZonnZ3��ZIz�g��<�]&J��ݛ^��pWpS��u���&w������s��~WP���7���<
�TX��K�2t��<'I~�lʄ�[� �AW!���7�1Hq�I�1H#ف��1��!�=
䫜�_��xʦ+u'F-Ӌr����q� �X��K4X��9�`��2��~|��+�w�8:[$�DϿ�aE�Kǹ���5�+
��6Ʀ�-T��Z�fc>N�&,�Q���[g�~�b����T��h��_��q��b8e�
�y�@[)2p� �`�}���x��_F�,.�s
ZQ���;��V�y�����Q�a	���[rHh���A�a��G��5��Ξ(m:z�J�e���a� .F'�TDp�S�|�Z��~������94��| :������LH��^0CF�m�� � R9Pr�v8�7��x�<
�"M�(-:��=�U"�<�4�B�3��x�d�N_�ǷV���Zfp��p�8�i�0T��>T�����?Ե��B-Lِׄ덋�
䈁\�]�`�U��| �И�4r��W�e-ҚR��^�q⸁}'���u�Gv�x%=g�Ҿ� 1rط([E���Y)���S�B�bT%4�)����������bF���D��@LRXH����Y�����՛�� ���K�FYBDz��
�Rc�b,xU#��:�3�ouB�h��� �D`9���-B������� ��:t�`b*v��>�����d�p%��VНA��^Q��W��'v�?*���e��Pjx��Ča��fl�� ��;���肷n6�L�N
3B:曚t��T���-��z{��h<��/N�Ó�h$1~�܂�YL�p2Qe�]�%q���E�L��?Uv�=ϫ��Ƨ�܂{¢x�iy� ̈<E|�	0�h/IA��4�eP��!���Q����Z���Y���1���F{��nls ���5��An$8��-��wn�]��%3����FQp��?$��Js���}����l���][��@�sX�!�](
���2�l
1�!
�
F���!�j^b��`��v��8[3;i+k���X���(b��CA���m�H����0�<�PF�0��QߩO�T���{#�0����>k�j���w���Fq,�HS*�!A`f��6ޒm_��X��]�ϫ�c�����>�v�Hf�E����p�I�;��9�	!�u����$L�U������������Ҩ�T�2�푅۞��\���RÐк���2il�Ю1#k��r�puv���j��J��b��-�������؟e;6_���`�?��"j�<��C���w�<�<y�����-`B������s�s��,�Ӯ'#h9
�~��ȏ��(s��2�\��.x���Z�0�?z�;9��~p|vb�3�O�EJ�,�������j�d��3�A�'m�
�NG�/o����|ΐ�^A�]��cy����[s1�5�`���� q�B؟��䃺QӴR<k�{^���
��2�'�S��6�M7���
�>l����v�Z���D��R2O �O�##�G�+ggd7 {
�ea�F"���1t�V�~+
�6྅![eof;��� z$�	,�M�PJ�~�b�X9���ǧv��g�7!������Q�9Zy�8Ӗ�<���&��&`�$B2se���7	9��b�&B'��O��NRK�t��b�rǪ��m�I��[B B�	�� '���%������z!n2�g&���-�z	�nG� �ݲ�F�l!� �A�m��P5��h�R��,�dڅ���)��L��9��cR��R�"�	n��0`�u�ei�u����|���IK#_C	D����jO��ւ7� b&�IR�E�Bk���(��  B=��P��M����Y��S���
A�c���F���=��� � �G�*ɰ����h����X6ƥf��Z�9��Ls���f�I�`�@�x�(
f�Í�8��`.r�բ�2"LƉ�}֓�MY�7��]>vw��)D$H���*c����q��	y��i�Ɏ��w��]bw�D{,��уd�Iv���N��U��e�7D��W�V���`��:,}h!�Ćo�%w�dbh~ޒ�E��e�}�Hl"�����:�#r
r�g���X�b�l�*�*6���M��b�TΪA�#���EE��.d0�kU��P�"�Qyw�j�Z,��U�葆c3u46�*���]>��� lU�|� ��a�=c۪>�VR%G�1�	�SG�+$,�+�Bd��9��V��h�Zy��U�m��@
2%u<�B�јC��q�G�=��q$F���ѡ�2��u�'X⧵��?��>v{o�	z�ְn��l����U�v����h��B�A�f�!�2,j�:奮޴��E������lܵ�x4���c��n����Q�x��p0�d^�J8�-�m�Q��@k|��t�/����q�ס3�rGRf��'�f,��`Y���ɜ�R�Rz������dY��`c;c��(��8��` A�)V,L���r�A��MH��Ո�I{�LY.��1ە�=�B\vR%$`:�P��P�I@a��^���z��EԳ���{�T΁��p!a��R�@8��P�$+�]7r��Ӟq\�z�<��;�����\��3�Xt́Sj%�,���S����۟����ş%aF^uh�Ԕ�8k[���]�$�S����ɻL�6c�U[���(������I�E��A�&V�E17Mn����Ea1
r+�h�?��Mv��:���V0g��?�Wo�E�hfS�:_�N�Mqc���.�$k�^fkV�ˢ�9&I���3��*���ѝ5�?^e�*�K�q�Zd��l-�C"�;\&�`�q��r ���R���u��b#9��2.�)?O����YR����X�)��M+^@4����r<8=�~�=6b+�|%9��y�8�u�� ]��DpL9�r(U2�X#+!(�̬ŀI,���ծI/�X1GktV�L�{r:*qޙ!�mk~a�q�ec�n�zjn����q�g���i��1���d/p��4؆@��,&�2,[J��3?��cK���S�!���O���6_O�h�A�8�"BR�#�H*3�t�I1ܳ�`��4�G���l�qr�"����[�wW�v��Y��~L�S^�i��*O�>8�CG�s�����o�M��/?�?�(�z�"6np�����9�w�c��P�!\2���p�Fow<rc�el��<�]��/;� ��C��xp�sbS�c�(�Z�X_q�|&�(:o߾�#/MX��1��9f�h}��k�����x�P�(d�2�N1vS��`f�I�!��� �4���I�H�SHY�$�+�N��K��/�$�QR�U�u���y4���Vb�XC;h��C
�j��!���C�a�2 #�<'�C�+��sᭆz-���N
߫~g+JpUT��Z�E�z��&z�������,���8�<��v��-c��!�&_����g���;i��c����\T����
�YBl�z�l�w�ԲvG܀� �W��@s�UQ6�1oqLe�����.�f�9v;�~B}x��"a�(k�����Y4;d�gz��y:��ڛꎔ��jTbz1�dk +dn$h�J��_���ۍ����q�����<��K�?����bgI+��&�w:�^�vH��+E�lt[�0-t3բ���;|S���1Y�Է�ݪh'��(_�[e���ꁚ��(��& ӂ1f��p����XM��xF6zy	�{�S=M�0�m��d�����:**��l�1�4#P���J�����p�y<���g{I�R\�O9O������R��NL�Y���P��͐�6�5c����IP�ށ��O��xAv��$��Sr���k��Kt:-�4YH�Lq:VFŖ���� �Z%���'g)�N'@2ɪVr��J��=�(Т:N.QK(�l�8�zK�lmHVg�q>�
�d����4V0�v�z�sj�Lmc�jtH��
D�<�����ˊ��p�B�6��@Rs�(��j`?�x�j�����U�[��,�zP���˞E�cq��1��!�B��msP��j����+�o��N	kΚ��1I�W�޵|'���X���e���K�a!�Nuq0+��E��,�D9��{?bl���a~���C��������B�Ë���E{�DH����Ѿ�������_{gM�9� L~F67\��� ��`��{�+܏�������;����Hꢐr|��: �~�p[Ыb@�KpӺ4C�~"]c���/���՘Y�x�
�(�.m����a�M� {��g�ǽ�k�V��&@3���69mqx���X����i+�������;��#:gc�z`lE�ɒ ��܄��_7/B�#7�����;��Cv;q�&���gR��)VtF�A�ӊ�q�$.A�����?�T��}1:Dal<�7���ug�k5l�i�HC}���o#�2m<���Ѡ8�yr��``EVz��:{��X}q}X�Ya�+��N����@��"H�U��F��g���>X�
}N��QU��W��M��=
�vEw� M]B��܄Ý�Q~;�!?��c{ع�P�z�3h����R�I2S�=Tʯ�0M���`dY4-���Er.��:����&�)yV�34P�}=PP�ͦ�BT�����a���n���X�:T�l�d\?���R�8��A2O4��ۇīl5ῶ V����c�/LնHC����������﵁�q{8�8���Lܡsgj5M��`�	�©�w.�Q~���RI�br�r�Y�i��u�\��TS�
C-jץ�@��`�w��{�+TgXQ�RM���i(a�&Ĩ�ڝ�^��c��l� �"��Z�;PY�ަT��8E*���Q$�"�RD��:�%`�FP��;�,&�!��� =o:
�t����:ك�1
���(�������z�z������H�	LU}�$�:R���m!˖�Iǯ��R��]J��ՙ�;*41��[d�N,h�-�n��NA��\�m��H�Z��(�	�!��A�f��'�D9Eg��}�Q!��d��|U��d#��Ȯ�#�Q1udpԃX�EK��Z)GD#�c%vX�t��c��â}��p�τݣ������1m�-�[�{�[�,��Eן�ڡ�q	�W�P���@�7�Z@� f��{
	crL`C��[be������qwQ?%�6�.j�Zu�J���J��^�L�����N��x
�Qm�<8�?����BZ���`�ҢgTGh��
�J���*)����*�A.�:+��Ԑ!��8���.RG�)-nTY�	���7�q%�;Ӟ��7.Em��JQ��2����j>�P��m�a�<��c4��n�e�\l	z�C�����z��3�a*��P�cI�_ߴGq�����R3���W�V�6���ᓳyG�1�@%��Ê����\�:�ˮh�4~�����Πg�Ϣ�P�Ǧ���������5���N�S�	G
�~o|�&c��e�#?&�S�D� �kh����7�|Hݷ�a��4�%��y]��M���QP�����l^Eq�U�,�7��x;NbO�9
w[�z\�y�/�� 1.��r�w�8�
1��o�*�E)%	�{����7X�oR�#�t��ؽ�.Ŝ@��%��p'�n� ��q�i��}X��v7�7@��Z=(�8�j����VR�~��0I��a������h��`EV�(#^�?pء-r��9��t�,>��Lҵ���Y����[F� O7yh�_�"C]B|ϵ/X7p��݃�a0��
-���Z���(��';%_=&p��2F)DTA�������&�?a;k@H)+����y�S Hd5���]X���߫���'�_(�i�2�v���#�Ǹ8i��`��V��^_}J����j��N^����`S�^��SIz��<�F�ؑ�_��_eRY)Rum*OD��? !Q�Z��Fn�[�����=�]�V�!s20�Tɞ���pp��T�c�䀝yԙv-�� R�v����J�qB��Ulȣ��4ο�c$y6u�:#�?,)j2u��\��`�A���҈r�1�Yc�mY@��g�n5$嶅�I���uS)�ڵp�u0~�ok@�`+�Ɛ;7@��\���_�2�n��bS��;�yfzI�i�Y�t�b��K"��Y����n=b���r�T��1�;���VZEm�W'oD��T�y{�0�=&��u2��Z�7��ZL���VJzN����ļJcv�xFg��Mc�ls�Sй����ؼ�?����V	���c�a�G
x����l���!��Cn�dū+%��_t�a̦Y�BA��R�q��7,�9X
C�(���x?�9����l�E6�$z��_� �y�Fa<�Td������
R�}l��~�z�����s@U���#@��G��F����w����H�W�uw���r�ݺh�8�n�}^o���Ǖ^sZ����+�6=�����*U����C� �%gS
�<ך9���Tv�0A�|�!�nc�5\}�6j�:�&��8��;��:k�:���#,M�g��p� �|٬��` ~�%{5�Ѯ����f9��/?|���q��]���PLi���ճ���:�T��X�R����T��lW���/�JQ��=xy����U�^�[��ݵ��U<da���.Ċ�M���}�]���H�����nW�;*���Q���f��+?&�#Eh	K̠���1~?'Nb�r��6�$�[L���g���Y�5n5�|�M9^绳p�seK�y�ޅ�7I*~.�J��P�j�fS��&�=X�T�ba�ė<�📧�v���^��R�t!%S�x��u�jC������
6��!p@됤y4]̓Ԭ�-���n���A���u�<@��`��n��;LޒN�ZDD惋�W��E�,A%�r{�x��$�9�m��Hl���d����5�.�7�U&����f��%�����&�W��U�� c�6�;�4	IE_��L1��`�� X��;Yc���V�-��Z�)dVq����>4�%���	!���-�]�$7�;�y�E��3��������:�ou
?��g�绗\
5:	)a�I�%�p�B:#�1PMU����F��1A9�j"�G�j»0HD�ѱxڝ0�j�ĬȠ	s�sE�QS�Ȱ���( �<e*���(reY�����}k^3��_�P��B$��juX�)c'AE�螺��)򭐢�p����E���-�S
'�o��K��{�o/�.���1�Z�<p�M����ÞCYÛ�$���-tJg|2�Mt%�6ǀ'nR�G�w9��+���4p��m�p=�3tU2:�B�T�*8�aD�-0+<�w`q�1�~���b�_�|6��\՛��V�\�f�&z�u�)��6�^W�VP��Y@�\ה��$t�'v(�]Z<�,���e�)��B�J=C5��A�Z|��Rk�
\lΎ�f�I������l�N�\2�֖[	�X�X$dC,V�]��$G>�q^n=J��0� �T�:8e��#Xu��9U�Vx�D�`��jN3�����@.H�`�k ӝϭX>����y0i��ں�����@[X�ju�0g{�
�t7f�`L8��,\�hT$�K)'�o
�V{�~my���Ã׽q�`|6l(78o��N&��S)�ͷO	�v��Hf�����g�@c�g
.�w��9�W����?zp#����VZ�_{��<��,����-d���w����}8Y����Aq.?��_�,`����@sڨ�E���"�otI���& ���V��c�2�k�@���e Q5���aU���YzEZ�ekV��,�
%�_�d(]�B:�g
�CW ���z�X2`����ə@�{Q���A��N���S�3CT����F�����ubj{|U�v�4���*J@R;�dG�ý8@�!G�0�i��~�ɳ�B�?$B���5L�'��1vvƘ���"�_lzkFM���D}	��
�:U�g$��k��Iæj�xN�z�i��\ܣ�돲�j�g�a1ݨn���z�5������j�dX�77A���Γ���aFP�Ό�M �0�	�F��j �A�k��xS�����X���j7_�����������o�
� (����Z���`��2�b�'7�����?/���л;�;�Ϭ	���J}7�>�&?(ˠ�����_^��L�z0���1%������_�[��b��1�ɼ�(�Lw��~c	�֛q>|�����ܾ�IY�	���8$��"K�L�h������f	T��՝��4�('�4�<q�=�ƛn:�R��I��m7�����uo�Z�϶�g
�Px��L�9dfy1�6 ^�\�T5�����
KJ�~V�5+I���%��-�
u��K�JmU׀�V�+|i�$���ɒeH�*;��߄��ic�\
�R;���<�ⶵ�f����9F[�Xl̴�h�P��q!�ʻK�-0���)�&�=�B���؎E� �SAS�o��B Q���;� �)�LC�
L���ډ��̮*�fT����u�;����+��ߛD�^��6��,
���XҪ�>!8'���H���,U�����X�ܾ�8>
H:%pRXu�4����Gf�OH0�)Y�=Q���-d�#�>	�>8�:��<�`v�}<;ߝ��%�&7�W$L��3�ӪpWW�ÈMS�Ѿ��&ˏ
"�N��<Ku)�[�x[�;hC����	$;�A*�5�u�uʽ`��t G2����N� ����փq*B�㿫α�|*�bKb��S��R���&�ش5�~)$q�6K��0ʩ���� )O���J�`��|5��D�4l�?#L�$�[�Vb�`㜯��3_���5Onx>@��|���'>!�D�A�uFZ��C�F)ZJj����5s:�U�1��(<�Q)�$�F`�1hm�%�e�>|��먃�����[$�mA��m3��*�z��Jέ	@�XC}@#��jS������Ǥ�2p<`l;\��	�<���ɓ�4Ir���W�J#E8iT��T�h%��3��9���CA�x3�ܪ=	�ΓΝq�.2�B�k��c�"d���B{֠�Y��T�Au��Nm6��Ƃ���v��{<8"��ۘK6O�>��R�˦�;���f�x�_湺e��|���t�R����c�!6��t���bV�Z���?��bԚ�{�,�`��_�M��h��/�?�~�%��A�֯{�L�s��h�Lk��á�q!�l��9M߄@���Y�LCœިO.����F]:�emI�]q)A��zY@��(G����e�SĶ�9�q�z��1�Gʼ�v� ��{|0݌*�xQy�F����
Sr=�^�;���lT��a�^`
?�a�԰����!�^�;k��K7� �d(�_��TP�MA� ��`%oY�������cQaA؍���Ky��u:��I����P�ꥩ9L����R܀O��$
;�vjw{oY,�R���NRV�d<5��Hr�5�%e{�.Ģg͔�1�PrX@�#��] ���se`�iEɇ����"�ȗ�d�8ZB��;?�]�������	��a���Nv���w�փ��+�����m���jO��e��	d�b�i��l�
�,	?��=�
��'�5*�
F�	��g��;���-@MQ$8jt��,��6���Kkc.�IO��
}Zj�>�h��`�E�V��R+��n�Y��IcJH٘Ċ�4�0K��tf�����^N@�E���cl���oz��H'p�^�,>��^���*|�7>����Ѐ�z��'�&ICm>h���IlK���b�1�H����*.脓(`H�Һ�Ə���1zYa�M��N�m��%��hQ�S��5�u1d�#CCf��l{��xD���`4bsG��zq֋�Ctu��݀k�X���x|y.8�l��w���µ������\f�B���/�y���h�������᯶=֨���L�g�!��9"Iq���o�n!�]}��i���UM��Mr�G��H�;�2��O !OZ�.���Ø�-�h[j�LBħ4FAS�����U[2#�qMʑ�H�����u��b�I�e#З��ZC�8���V��.��]��n�j+���C��4=�ocf\1˨-�YoI/tyk	=��
��.H��.�����:��64�i�K���+%U��K�S����m&'vFs*�P���j�{��.��&6��% �R@��N�4�+�D�n@���N�]�
�EF�/��$-���Э21J�O-�&1�_��w����hn^�_X<\7vɋ�#�����^$-#�@|F�д��ަ�r���iz�kF��RdMh��˱gde\�����9
b</�[���gR��V��f�>K\Ȏ���T
Ar>�u³�6���۹ۃ�B�A��4]� �Z`΅Uv�씁�Ţ�^�x9s!}q^Y�'3
r����i�X�����B���HwT1���^�p V��ن�ǹ艄�XBBa���֏UE��X�ϫ麥�M���,�"B�f����"�����N}�S����*���S;
��BB��<�.��☦:��D6�{�4�#���Ʉ�@_�k����^/�����[력�"}h�>�l抹D�c��ϑ]���� yx�b������XP�
�o�)���7�d���x�@��C*-��i�{�NX��K�AG�ղ(AX]Ob�LI�r]�����KKV1���i�q���+��\|F�)i%�@�.����xf�[���{i��j�^/v�Ru�u�����8�~��odO�{��{��x~����{�H^��nДS֧�vcZ�B�3s;ʂ�����X�C��T�x)���%
q=�ޤ_�L�Z%s�;�YG��9B��15�֑�=wdR�hA�_��c-0.{ �w&9ZPHĚDZ �%���?���7�+������9���C�] �g}���f�\� �P���+IZ��s��}g�|x�(gr}=Z�{�e� I��a�j��S���$�i�Ҕ�	�ϗ/��wO[�q�<	i�P�k�n�M8��P�"V�|��H*X���p�b��+n�OMؘY�`��\j�
�Gs���rǌ9����ݰ�uʙSiֳ!1� Ȗ�<b���A�-��j��qֆ��^(��V#\��uJ�m��O�kT]�|�T�󸶘Ń��B7�U�
j!�.���:m'�%������z����ܟׄ�O*K�NU�B�j�U�j�Mf���B��c�$W�q����2.곝���K�Y��*�����-�
�M�)A(�I�5��P� ��ٴ���i/A+!�����%��U�^o[�S�(�aQ)U�� 2
��Ծ��ZU]l
5s�aZ�	������7����e�^�("TA���������%2�z��S䏫T��Ρ�_� w˻�(_�XY�I�װȁ������
qQw�����L�W�dB�V�yz��8���߂Qo㛰|�V��K�ibz~��d�m�f3�*�B}�0��# Z��1��TL�O��.�[G9�ءñl
1�����%Ua\�A$�E��2�g(X����MBp� ,Z����i۳k��(%�-�/�G٭R�?4=�o���n�O��@��Ḅ����ށO����Ku�6҅�=g�U�"�;	��A��`L'�	��$�f�w .��#:B}�������h�.a�4�����$I1¯0v3#��]�7Y:�0�X��O	�W8�p�u5wi�3������p|����\_��-yݘ�wY�@���J�D+�/	��|F(ή(��|7�Z��G��V�����z�l��1�f�\u��7��LfV�y�`3�l|x��-{N�^S�<x�A�qН��%��tЬ�/pb�M�x�b6�� �Փ��|��7-.�
�W�I�w�c���������kכ��{
�ǒKw5)�� ��'B�x�|ϊu-Pn�-��'rC.v�.
}�㛸��T�:k�-������1ߒx�5�� #h�Vs���{F�#:��R�u�$����d�������O�Y�������k�� ��u�/_���DZ�I�mV��9�O����������"�~�0��|Q�?�n�4�X�1G���4�л��������J�[Ox�͇̩~��Lc���*��u��O���#�w�`�48�9>��h�L2�z�^6>����k�,x_oO�9^{�L�����w�n����s=E���,Ё@Iv��Mk� �6Ip P��^XE�HVD!��(������Z�_���$���RU JN�4��#�:�}����f=�]OpZX����p��	i�M���y��|b�e
���B�
��G^��<t�>�VST����K^=h5��r[ O,6#(4SBt��QC'�XxV��(������xbc��ũlY�Z�GXư�q�5�k�����`�t �"�3��u�L7�ܳ�u#�o�����|kg�a�4ĩ����+��-�rDsb2�O�=��0�[:�k����]wX�����f+l�[p�l�a�I���Z$��VH����.(t�S��~'��h�e��Z��ݦqX�> 5:��bQ�eb�S�
�1�7rlL~3��MܓS1o/ ��t�p�$���
v:��~��J�]c��Ĕɧ^L�������ƽ���՗$��)����ӄA�e��O�]$,��%�M�#NжPP����b9L�)�A�L�$'@����;A��9x�
���6ANQ!�S��6�%�sBqh��
���Ǐ?z���B��� �
��&��qRK��O��n�r�q4
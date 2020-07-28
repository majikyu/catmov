# �T�v
ffmpeg �� concat �R�}���h�ɂ�铮�挋�����ȒP�ɍs�����߂� windows powershell �̃R�}���h���b�g�ł��B

# �g����
## ffmpeg�̃C���X�g�[��
ffmpeg���C���X�g�[�����āCpowershell�Ŏg�����Ԃɂ��Ă��������B

https://ffmpeg.org/

## �t�@�C���̃C���|�[�g
�R�}���h�����s����ɂ́Cpsm1 �t�@�C����powershell�ɃC���|�[�g����K�v������܂��B

���̏�Ŏ��p�݂̂̏ꍇ�� Import-Module �R�}���h�𗘗p���܂��B

```
Import-Module ./catmov.psm1
```

powershell �N�����ɖ���C���|�[�g���s���ꍇ�́C���ϐ��� PSModulePath ���Ƀt�@�C����u���܂��B

PSModulePath�z���ɁA

```
(PSModulePath)/catmov/catmov.psm1
```

�Ƃ����`�ŕۑ����Ă��������B

����ŁA�N�����Ɏ����C���|�[�g����܂��B

## �R�}���h�̎��s
### ����t�@�C���̗p��
�������铮��t�@�C����p�ӂ��Ă��������B

���̎��t�@�C�����́A`<���於><�����q><�Y����>.<�g���q>` �Ƃ��Ă��������B

`hoge-1.mp4 hoge-2.mp4 hoge-3.mp4`�Ƃ������`�ł��B

### �R�}���h���s
catmov�R�}���h�����s���܂��B

`hoge-1.mp4 hoge-2.mp4 hoge-3.mp4`����������R�}���h�́A

```
catmov hoge -sep -
```

�ƁA�Ȃ�܂��B

hoge�̕������A��������t�@�C����<���於>�ł��B

sep�I�v�V������<�����q>���w�肵�܂��B���w��̏ꍇ�A<�����q>�͖����Ƃ݂Ȃ��܂��B�i��Fhoge1.mp4�j

�S�I�v�V�����ɂ��Ă͎��͂ŏ����܂��B

## �I�v�V����

|�I�v�V������|�L�q��|�Ӗ�|�f�t�H���g|
|:---:|:---:|:---:|:---:|
|out|�o�̓t�@�C�����̎w��|-out hoge|<���於>.<�g���q>|
|start|�擪�ɂȂ���͓���̓Y����|-start 3|1|
|end|�����ɂȂ���͓���̓Y����|-end 5|�Ȃ�(���݂��邾������)|
|sep|�����q�̎w��|-sep -|�Ȃ�|
|ext|����̊g���q�w��|-ext avi|mp4|
|copy|������ăG���R�[�h���Ȃ�|-copy |False|
|alp|�Y�����ɃA���t�@�x�b�g���g�p|-alp |False(����)|

### ���s��
�t�H���_��

`hoge_A.avi hoge_B.avi hoge_C.avi hoge_D.avi hoge_E.avi`

�����݂��A`hoge_B.avi hoge_C.avi hoge_D.avi`���ăG���R�[�h�Ȃ��Ō������A`hogehoge.avi`���o�͂���ꍇ�A

```
catmov hoge -out hogehoge -start B -end D -sep _ -ext avi -copy -alp
```

�ƂȂ�܂��B
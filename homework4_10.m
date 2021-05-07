%% ��ʼ��
close all
A1 = 1;
f1 = 60;
A2 = 0.5;
f2 = 40;
fs = 20000;
M = 200;
N = 1024*8;
f0 = 9500;
deltf = 200;

%% �����ź������
N1 = N-M;
dt = 1/fs;
t = 0:dt:dt*(N1-1);
x1 = sin(2*pi*f1.*t);
x2 = sin(2*pi*f2.*t);
n = random('norm',0,2,[1,N1]);%����N-M����˹���������Ϊ����
x =  x1+x2+n;%�ϳ��ź�
xm = cos(2*pi*f0.*t).*x;%�����ź�

%% ������ͨϵͳ
fn = f0/(2*fs);%��һ������Ƶ��
dfn = deltf/fs;%��һ������ע�������ǰ�ߵĴ���
ht = fir1(M,[fn-dfn fn+dfn]);
y = conv(xm,ht);%���N��խ������ź������Ĳ���

%% �����׹���
Nt = 2*N-1;
f = fs/Nt:fs/Nt:fs/2;
Ry = xcorr(y,'biased');%����غ���
Sy = abs(fft(Ry));
figure,plot(f,10*log10(Sy(1:N-1)+eps))
xlabel('f/Hz');ylabel('Sy(f)/dB')

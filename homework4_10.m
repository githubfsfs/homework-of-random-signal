%% 初始化
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

%% 生成信号与调制
N1 = N-M;
dt = 1/fs;
t = 0:dt:dt*(N1-1);
x1 = sin(2*pi*f1.*t);
x2 = sin(2*pi*f2.*t);
n = random('norm',0,2,[1,N1]);%产生N-M个高斯随机数，作为噪声
x =  x1+x2+n;%合成信号
xm = cos(2*pi*f0.*t).*x;%调制信号

%% 经过带通系统
fn = f0/(2*fs);%归一化中心频率
dfn = deltf/fs;%归一化带宽。注：这里是半边的带宽
ht = fir1(M,[fn-dfn fn+dfn]);
y = conv(xm,ht);%输出N个窄带随机信号样本的采样

%% 功率谱估计
Nt = 2*N-1;
f = fs/Nt:fs/Nt:fs/2;
Ry = xcorr(y,'biased');%自相关函数
Sy = abs(fft(Ry));
figure,plot(f,10*log10(Sy(1:N-1)+eps))
xlabel('f/Hz');ylabel('Sy(f)/dB')

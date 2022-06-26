clc; clf; 
N=44100; e=zeros(1,N); e(5)=N;
%e=(rand(1,N)-0.5)*2;
%--------------------------------Synthèse passe-bas 1 
fcoupure=400; 
fn=2*fcoupure/N; %---Fréquence normalisée 
n=1; [B,A] = butter(n,fn,'low')
s = filter(B,A,e); 
Fs=fft(s); 
Ss=sqrt(Fs.*conj(Fs))/N; 
freq=0:(N-1);

%--------------------------------Synthèse passe-bas 2 
 n=2; [D,C] = butter(n,fn,'low') 
 ss = filter(D,C,s); 
 Fss=fft(ss); 
 Sss=sqrt(Fss.*conj(Fss))/N; 
 subplot(4,1,1); 
 semilogx(freq,20*log10(Ss),'b',freq,20*log10(Sss),'c'); 
 grid; ylabel ('Passe-bas I et II'); xlim([10 10000]);
%--------------------------------Synthèse passe-haut 1 
fcoupure=400; 
fn=2*fcoupure/N; %---Fréquence normalisée 
n=1; [F,E] = butter(n,fn,'high')
z = filter(F,E,e); 
Fz=fft(z); 
Ss=sqrt(Fz.*conj(Fz))/N; 
freq=0:(N-1);

%--------------------------------Synthèse passe-haut 2 
 n=2; [D,C] = butter(n,fn,'high') 
 zz = filter(D,C,z); 
 Fzz=fft(zz); 
 Zzz=sqrt(Fzz.*conj(Fzz))/N; 
 subplot(4,1,2); 
 semilogx(freq,20*log10(Ss),'b',freq,20*log10(Zzz),'c'); 
 grid; ylabel ('Passe-haut I et II'); xlim([10 10000]);
 %--------------------------------Synthèse band pass
n=1; LB=[190 210]; 
LBn=2*LB/N ; [V,U] = butter(n,LBn,'bandpass'); 
y = filter(V,U,e); 
Fy=fft(y); 
Sy=sqrt(Fy.*conj(Fy))/N; 
subplot(4,1,3); 
semilogx(freq,20*log10(Sy),'b'); 
grid; ylabel ('Passe-bande'); xlim([10 10000]); %--------------------------------------------------------Fin ;-)
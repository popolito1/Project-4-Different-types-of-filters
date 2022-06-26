clc; clf; N=44100; 
frequence= 20;                     %Fréquence réelle en Hertz
frcoupure=1000;                     %Fréquence de coupure des I°ordre en Hertz
frcentral=2000; 
deltafreq=20  ;     %Fréq. centrale & LB du passe-bande en Hertz
f1=50;
f2=10000;
%------ Normalisations et calcul des constantes de temps ------
f=frequence/N;	fc=frcoupure/N;	f0=frcentral/N;	Df=deltafreq/N;      
k =1/(2*pi*fc); k2=1/(2*pi*Df); k1=Df/(2*pi*f0*f0);

%---------------------- Initialisation des tableaux ------------------------------
temp=zeros(1,N); freq=zeros(1,N); e=zeros(1,N); s=zeros(1,N); 
z=zeros(1,N); ss=zeros(1,N); zz=zeros(1,N); y=zeros(1,N);
for t=1:N       temp(t)=(t-1)/N; freq(t)=(t-1);     end
% 1°) PROGRAMMATION D'UNE ENTREE SINUSOIDALE
      for t=1:N e(t)=sin(2*pi*f1*t)+ sin(2*pi*f2*t); e(10)=N; end  
% 2°, 3°, 4°) ENTREE IMPULSIONNELLE, INDICIELLE, BRUIT ...
Fe=fft(e); Se=sqrt(Fe.*conj(Fe))/N;	%soundsc(e,N);

%-----------------------Programmation des filtres --------------------------------
for t=2:N   s(t)=(e(t)/(1+k))+((k*s(t-1))/(1+k)); end
for t=2:N   ss(t)=[1/(k+1)]*s(t) + [k/(1+k)]*ss(t-1); end
for t=2:N  z(t)=(k/(k+1))*[e(t)-e(t-1)+z(t-1)]; end
for t=2:N   zz(t)=k/(k+1)*[z(t)-z(t-1)+zz(t-1)]; end 
for t=3:N   y(t)= [(k1)/(1+k1+k1*k2)]*[e(t)-e(t-1)]+[(k1+2*(k1*k2))/(1+k1+k1*k2)]*y(t-1)-[(k1*k2)/(1+k1+k1*k2)]*y(t-2); end      

sound(ss,N); soundsc(zz,N); %ecoute des singnaux du II ordre

Fb1=fft(s); s=sqrt(Fb1.*conj(Fb1))/N;    %soundsc(s,N);
Fb2=fft(ss);    ss=sqrt(Fb2.*conj(Fb2))/N; %soundsc(ss,N);
Fh1=fft(z); z=sqrt(Fh1.*conj(Fh1))/N; %soundsc(z,N);
Fh2=fft(zz);    zz=sqrt(Fh2.*conj(Fh2))/N; %soundsc(zz,N);
Fbp=fft(y); y=sqrt(Fbp.*conj(Fbp))/N; %soundsc(y,N);


figure(1);   %----------Trac des Chronogrammes------------------------------------
subplot(4,1,1); plot(temp,e,'r'); grid; ylabel ('Entrée'); title('CHRONOGRAMMES');
subplot(4,1,2); plot(temp,s,'b',temp,ss,'c'); grid; ylabel ('Passe-bas I et II');
subplot(4,1,3); plot(temp,z,'b',temp,zz,'c'); grid; ylabel ('Passe-haut I et II');
subplot(4,1,4); plot(temp,y,'g'); grid; ylabel ('Passe-bande'); xlabel('Temps(s)');

%-------------- Tracé des Spectres------------------------------
figure(2); 
subplot(4,1,1); semilogx(freq,Se,'r'); grid; 
ylabel('Entr�e'); title('SPECTRES'); 
xlim([20 10000]); 

subplot(4,1,2); 
semilogx(freq,20*log10(s),'b',freq,20*log10(ss),'c'); 
grid; ylabel ('Passe-bas I et II'); xlim([20 10000]);

subplot(4,1,3); 
semilogx(freq,20*log10(z),'b',freq,20*log10(zz),'c'); 
grid; ylabel ('Passe-haut I et II'); xlim([20 10000]);

subplot(4,1,4); semilogx(freq,20*log10(y),'g'); grid; 
ylabel ('Passe-bande'); xlabel('Fréq.(Hz)'); 
xlim([20 10000]);


Fe=fft(e); Se=sqrt(Fe.*conj(Fe))/N;	%soundsc(e,N);
Fb1=fft(s); s=sqrt(Fb1.*conj(Fb1))/N;    %soundsc(s,N);
Fb2=fft(ss);    ss=sqrt(Fb2.*conj(Fb2))/N; %soundsc(ss,N);
Fh1=fft(z); z=sqrt(Fh1.*conj(Fh1))/N; %soundsc(z,N);
Fh2=fft(zz);    zz=sqrt(Fh2.*conj(Fh2))/N; %soundsc(zz,N);
Fbp=fft(y); y=sqrt(Fbp.*conj(Fbp))/N; %soundsc(y,N);
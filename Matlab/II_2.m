clc; clf;
N= 44100;          %Nombre d'échantillons
frequence =50000 ;   %Fréquence réelle en Hertz
f=frequence/N;    %-- Normalisations de la fréquence --

%------ Initialisation de tableaux à N zéro -----------
temp=zeros(1,N); freq=zeros(1,N); e=zeros(1,N); 

%------ L'échelle des temps et des fréquences----------
for t=1:N	temp(t)=(t-1)/N; freq(t)=(t-1);	end

%------------------------ Programmation de l'entrée ---
% 1°) ENTREE SINUSOIDALE
      for t=1:N e(t)=(sin(2*pi*f*t)); end  
% 2°) ENTREE IMPULSIONNELLE
      %t0=3; e(t0)=N;
% 3°) ENTREE INDICIELLE
      %t0=3; for t=t0:N e(t)=1; end;
% 4°) ENTREE BRUIT BLANC 
      %e=(rand(1,N)-0.5)*2; 

Fe=fft(e); Se=sqrt(Fe.*conj(Fe))/N;	%Calcul du Spectre--
%soundsc(e,N); %Ecoute du signal --
%pause;
figure(1); %------------Tracé de Chronogrammes---------
subplot(4,1,1); plot(temp,e,'r'); title('CHRONOGRAMME');
xlabel('Temps: : sec'); ylabel ('Amplitide'); grid;               
%-----------------------Tracé de Spectres--------------
subplot(4,1,2); semilogx(freq,Se,'r'); title('SPECTRE'); 
xlabel('Fréquence: : Hz'); ylabel('Se'); grid;
%xlim([20 20000]);                

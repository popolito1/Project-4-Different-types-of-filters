clc; clf;
N=100; t0=20; 
k=1; k1=0.1; k2=20;               %Déclaré des constantes
e=zeros(1,t0); temp=zeros(1,N); 
d=zeros(1,N); s=zeros(1,N);       %Initialisé de tableaux
y=zeros(1,N); z=zeros(1,N);  
ss=zeros(1,N); zz=zeros(1,N);
for t=t0:N-1    e(t+1)=1; end     %Programé d'un échelon
for t=1:N       temp(t)=t-1; end  %Tableau des temps

%---------------Programe d'une dérivée-------------------

for t=2:N    d(t)=k*(e(t)-e(t-1)); end  
 
%-----------------------Tracé des Chronogrammes--------------------------------------
figure(1);
subplot(2,2,1); plot(temp,e,'r');           % 'r'=red
grid; title ('Entrée');
subplot(2,2,2); plot(temp,d,'g');           % 'g'=green
grid; title ('Dérivée');
subplot(2,2,3); plot(temp,e,'x',temp,d,'g'); 
grid; title ('Lentree et la sortie');

%-----------------------Programmation d'un passe-bas d'ordre I------------------------
                        
                        %for t=2:N   s(t)=(e(t)/(1+k))+((k*s(t-1))/(1+k)); end 
                       
%-----------------------Programmation d'un passe-bas d'ordre II-----------------------
                        %for t=2:N   ss(t)=[1/(k+1)]*s(t) + [k/(1+k)]*ss(t-1); end 
                         
%-----------------------Programmation d'un passe-haut d'ordre I-----------------------
                        %for t=2:N  z(t)=(k/(k+1))*[e(t)-e(t-1)+z(t-1)]; end
                         
%-----------------------Programmation d'un passe-haut d'ordre II----------------------
                        %for t=2:N   zz(t)=k/(k+1)*[z(t)-z(t-1)+zz(t-1)]; end          	                        

%-----------------------Programmation d'un passe-bande-------------------------------
                        for t=3:N   y(t)= [(k1)/(1+k1+k1*k2)]*[e(t)-e(t-1)]+[(k1+2*(k1*k2))/(1+k1+k1*k2)]*y(t-1)-[(k1*k2)/(1+k1+k1*k2)]*y(t-2); end      


figure(2);                   
subplot(4,1,1); plot(temp,e,'r'); grid; ylabel ('Entrée'); title('CHRONOGRAMMES');                
subplot(4,1,2); plot(temp,s,'b',temp,ss,'c'); grid; ylabel ('Passe-bas I et II');  
subplot(4,1,3); plot(temp,z,'b',temp,zz,'c'); grid; ylabel ('Passe-haut I et II');  
subplot(4,1,4); plot(temp,y,'g'); grid; ylabel ('Passe-bande'); xlabel('Temps(s)');
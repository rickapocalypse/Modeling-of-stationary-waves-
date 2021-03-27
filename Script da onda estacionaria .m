clc
clear all
xi=0;             %ponto incial                      
xf=1;             %Ponto final
ti=0.00;          %tempo incial
tf=0.05;          %tempo final
dt=0.0001;        %passo no tempo
%nt=lenght(t);         %numero de loops no tempo
vi=50;            %velocidade da onda em m/s
dx=vi*dt;         %passo no espaco
%nx=length(x);         %numero de loops no espaco
r=vi*(dt/dx);     %constannte de proporcionalidade
xc=0.3;           %centro da gaussiana
k=1000;           %constante


x=xi:dx:xf;
t=ti:dt:tf;
nx=length(x);         %numero de loops no espaco
nt=length(t);         %numero de loops no tempo
y=@(x) exp(-k.*((x-xc).^2));
%Condicao de conntorno%
F(1,1:nt) = 0;
F(nx,1:nt) = 0;
%=====================%
for i = 1 : nx - 1
  F(i+1,1)= y(x(i));
endfor
for i = 2: nx - 2
  F(i,2)= 2.*(1-r.^2).*F(i,1) + (r.^2).*(F(i+1,1)+F(i-1,1))-F(i,1);
endfor
%=====================%
for j = 2 : nt-2         
  for i = 2 : nx-1
    F(i,j+1) = 2.*(1-r.^2).*F(i,j)+ (r.^2).*(F((i+1),j) + F((i-1),j)) - F(i,j-1); 
  endfor
endfor
%=====================%


%=====================%
figure1 = figure(1);
set(figure1,'color','white');
winsize = get(figure1,'position');
winsize(1:2) = [0 0];
clear M;
count=1;
p1 = plot(x,F(:,1),'bo'); %plota o ponto
ylim([-0.8 0.8]);               %Mantem a escala do grafico
pause(0.001);
%M(count)=getframe(figure1,winsize);% armazena o frame em "M"
M(count)=getframe(figure1);
delete(p1); %deleta o grafico (já esta armazenado em "M")
count=count+1;


for j = 2 : nt             
    p1=plot(x,F(:,j),'bo');
    ylim([-0.8 0.8]);               
    pause(0.001);
    M(count)=getframe(figure1);
    delete(p1); %deleta o grafico (já esta armazenado em "M")
    count=count+1;   
endfor

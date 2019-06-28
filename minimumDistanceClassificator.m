clc
clear
close all

rand('seed',0);

randn('seed',0);

c1 = randnorm([0 0],[1 0.8; 0.8 2], 1000);
c1tipo = zeros(1,1000);

c2 = randnorm([3 3],[1 -0.9; -0.9 2],1000);
c2tipo = ones(1,1000);

ct = [c1, c2];
cttipo=[c1tipo, c2tipo];

[ctdesor  cttipodesor]= shuffle(ct,cttipo);

xtrn = ctdesor(:,1:1600);
ytrn = cttipodesor(:,1:1600);

xtst = ctdesor(:,1601:end);
ytst = cttipodesor(:,1601:end);

%% Distancia m?xima Ejercicio 1 apartado a)

% 0 y 3 son las medias de los patrones, pero los tendriamos que calcular
io =find(ytrn == 0), m0= meanpat(xtrn(:,io));
io =find(ytrn == 1), m1= meanpat(xtrn(:,io));

d0 = sum(subpat(xtst,m0).^2); 
d1 = sum(subpat(xtst,m1).^2);

[a,b] = min ([d0;d1;]);

clases = b-1;

acierto = sum(clases==ytst); %clases acertadas
tasaerror_total = (((length(ytst)-acierto)/length(ytst)))*100
tasacierto_total = acierto / length(ytst)*100 

posc1 = find(clases==0);
aciertoc1 = sum(clases(posc1)==ytst(posc1));
tasaaciertoc1= aciertoc1/length(posc1)*100;
tasaerrorc1 = (((length(posc1)-aciertoc1)/length(posc1)))*100;


posc2 = find(clases==1);
aciertoc2 = sum(clases(posc2)==ytst(posc2));
tasaaciertoc2= aciertoc2/length(posc2)*100;
tasaerrorc2 = (((length(posc2)-aciertoc2)/length(posc2)))*100;
matriz_confusion_distancias_minimas = [ tasaaciertoc1 tasaerrorc1 ; tasaaciertoc2 tasaerrorc2]

tasaerror_total
tasacierto_total


%% Distancia de Mahalanobis  Ejercicio 1 b) 
% Debido a la forma de la nube de puntos, tal como se
% esperaba, la distancia de mahalanobis es mas efectiva ( un 98% frente a un
% 95% de tasa de cierto con respecto al método de la distancia mínima. Pero
% curiosamente, el método de la distancia mínima, es más efectivo en la
% clase 0 como se puede observar en la matriz de confusión.

d0 = d_mahal(xtst,0,[1 0.8; 0.8 2]);
d1 = d_mahal(xtst,3,[1 -0.9; -0.9 2]);

[a,b] = min([d0;d1]);

clases = b-1;

tasaerror = 100*length(find(clases~=ytst))/length(ytst)
tasaacierto = 100*length(find(clases==ytst))/length(ytst)

posc1 = find(clases==0);
aciertoc1 = sum(clases(posc1)==ytst(posc1));
tasaaciertoc1= aciertoc1/length(posc1)*100;
tasaerrorc1 = (((length(posc1)-aciertoc1)/length(posc1)))*100;


posc2 = find(clases==1);
aciertoc2 = sum(clases(posc2)==ytst(posc2));
tasaaciertoc2= aciertoc2/length(posc2)*100;
tasaerrorc2 = (((length(posc2)-aciertoc2)/length(posc2)))*100;
matriz_confusion_Mahalanobis = [ tasaaciertoc1 tasaerrorc1 ; tasaaciertoc2 tasaerrorc2];

tasa_error_total = tasaerror;
tasa_acierto_total = tasaacierto;

%% Representación grafica de los puntos con sus medias. Ejercicio 1 apartado c) 
%Es una cónica que divide el espacio en dos regiones
figure,plotpat(ctdesor,cttipodesor);hold on;
plotbon([0 0]',[1 0.8; 0.8 2],[3 3]',[1 -0.9; -0.9 2]);
%axis([-10 10 -10 10])





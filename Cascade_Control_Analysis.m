%% Portfolio: Identificatie en controle van biotechnische processen

%% Simulatie van het dynamisch gedrag van de solenoÃ¯deklep zonder positieregeling (zonder negatieve terugkoppeling)
close all
clear all
clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = [0.4 0.15 0.15]; %[Ns/m]
Ke = [0 0 500]; %[Vs/m]
Ca1 = Cd*pi*da1*sqrt(Ps*(2/rho));

% Toestandsvorm: klepstand voor zowel evaluatie- als ontwerpmodel
figure(1)
xlabel('Tijd (s)')
ylabel('Klepstand (m)')
title('Klepstand van de solenoÃ¯dklep zonder positieregelaar')
t1 = 0:0.001:10; %[s]
vin = [zeros(1,(length(t1)-1)*0.2) 4*ones(1,((length(t1)-1)*0.8)+1)]; %[V]
vruis = [-1*ones(1,length(t1))]; %[V]
v = vin + vruis; %[V]
for i = 1:3 %for-loop voor evaluatiemodel
    A = [0 1 0; -k/m -c(i)/m Kc/m; 0 -Ke(i)/L -R/L]; %Toestandsmatrix
    B = [0;0;1/L]; %Inputmatrix
    C = [1 0 0; Ca1 0 0]; %Outputmatrix
    D = []; %Doorkoppelmatrix
    sys1 = ss(A,B,C,D);
    [y,t1]= lsim(sys1,v,t1);
    hold on
    plot(t1,y(:,1))
    P_evaluatie{i} = pole(sys1);
end
for i=1:3 %for-loop voor ontwerpmodel
    E = [0 1; -k/m -((Kc*Ke(i))/(m*R))-(c(i)/m)]; %Toestandsmatrix
    F = [0;Kc/(m*R)]; %Inputmatrix
    G = [1 0 ; Ca1 0 ]; %Outputmatrix
    H = []; %Doorkoppelmatrix
    sys2 = ss(E,F,G,H);
    [Y,t1]= lsim(sys2,v,t1);
    hold on
    plot(t1,Y(:,1),'--')
    P_ontwerp{i} = pole(sys2);
end
legend('evaluatie: c=0.4 Ke=0','evaluatie: c=0.15 Ke=0','evaluatie: c=0.15 Ke=500','ontwerp: c=0.4 Ke=0','ontwerp: c=0.15 Ke=0','ontwerp: c=0.15 Ke=500','Location','southeast')

% Toestandsvorm: Debiet voor zowel evaluatie- als ontwerpmodel
figure(2)
xlabel('Tijd (s)')
ylabel('Debiet (m^3/s)')
title('Debiet zonder positieregelaar')
t1 = 0:0.001:10; %[s]
vin = [zeros(1,(length(t1)-1)*0.2) 4*ones(1,((length(t1)-1)*0.8)+1)]; %[V]
vruis = [-1*ones(1,length(t1))]; %[V]
v = vin + vruis; %[V]
for i = 1:3 %for-loop voor evaluatiemodel
    A = [0 1 0; -k/m -c(i)/m Kc/m; 0 -Ke(i)/L -R/L]; %Toestandsmatrix
    B = [0;0;1/L]; %Inputmatrix
    C = [1 0 0; Ca1 0 0]; %Outputmatrix
    D = []; %Doorkoppelmatrix
    sys1 = ss(A,B,C,D);
    [y,t1]= lsim(sys1,v,t1);
    hold on
    plot(t1,y(:,2)+ 0.003*Ca1)
end
for i=1:3 %for-loop voor ontwerpmodel
    E = [0 1; -k/m -((Kc*Ke(i))/(m*R))-(c(i)/m)]; %Toestandsmatrix
    F = [0;Kc/(m*R)]; %Inputmatrix
    G = [1 0 ; Ca1 0 ]; %Outputmatrix
    H = []; %Doorkoppelmatrix
    sys2 = ss(E,F,G,H);
    [Y,t1]= lsim(sys2,v,t1);
    hold on
    plot(t1,Y(:,2)+ 0.003*Ca1,'--')
end
legend('evaluatie: c=0.4 Ke=0','evaluatie: c=0.15 Ke=0','evaluatie: c=0.15 Ke=500','ontwerp: c=0.4 Ke=0','ontwerp: c=0.15 Ke=0','ontwerp: c=0.15 Ke=500','Location','southeast')
%% Simulatie van het dynamisch gedrag van de solenoÃ¯dklep met positieregeling voor de mechanische spoel: P-regelaar
close all
clear all
clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = 0.4;      %[Ns/m]
Ke = 0;       %[Vs/m]
Ca1 = Cd*pi*da1*sqrt(Ps*(2/rho));
Krc = [10000 20000 30000 50000 100000 400000]; %[V/m] Variabele versterkingsparameter van de P-regelaar

% Toestandsvorm: klepstand voor zowel evaluatie- als ontwerpmodel
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
for i = 1:6 %for-loop voor evaluatiemodel
    A = [0 1 0; -k/m -c/m Kc/m; -Krc(i)/L -Ke/L -R/L]; %Toestandsmatrix
    B = [0 0;0 0; Krc(i)/L 1/L]; %Inputmatrix
    C = [1 0 0]; %Outputmatrix
    D = []; %Doorkoppelmatrix
    sys1 = ss(A,B,C,D);
    [y,t1]= lsim(sys1,v,t1);
    if i == 6
        figure(2)
        plot(t1,y(:,1))
        legend('evaluatie: Krc=400000','Location','southwest')
    else
        figure(1)
        plot(t1,y(:,1))
        hold on
    end
    P_evaluatie{i} = pole(sys1);
end
for i=1:6 %for-loop voor ontwerpmodel
    E = [0 1; (-k/m)-((Kc*Krc(i))/(m*R)) -((Kc*Ke)/(m*R))-(c/m)]; %Toestandsmatrix
    F = [0 0;(Kc*Krc(i))/(m*R) Kc/(m*R)]; %Inputmatrix
    G = [1 0]; %Outputmatrix
    H = []; %Doorkoppelmatrix
    sys2 = ss(E,F,G,H);
    [Y,t1]= lsim(sys2,v,t1);
    if i == 6
        figure(3)
        plot(t1,Y(:,1),'--')
        legend('ontwerp: Krc=400000','Location','southeast')
    else
        figure(1)
        plot(t1,Y(:,1),'--')
        hold on
    end
    P_ontwerp{i} = pole(sys2);
end
figure(1)
xlabel('Tijd (s)')
ylabel('Klepstand (m)')
title('Klepstand van de solenoÃ¯dklep met P-regelaar')
legend({'evaluatie: Krc=10000','evaluatie: Krc=20000','evaluatie: Krc=30000','evaluatie: Krc=50000','evaluatie: Krc=100000','ontwerp: Krc=10000','ontwerp: Krc=20000','ontwerp: Krc=30000','ontwerp: Krc=50000','ontwerp: Krc=100000'},'Location','southeast','FontSize',8)
figure(2)
title('Klepstand van de solenoÃ¯dklep met P-regelaar')
xlabel('Tijd (s)')
ylabel('Klepstand (m)')
figure(3)
title('Klepstand van de solenoÃ¯dklep met P-regelaar')
xlabel('Tijd (s)')
ylabel('Klepstand (m)')
%% Simulatie van het dynamisch gedrag van de solenoÃ¯dklep met positieregeling voor de mechanische spoel: PI-regelaar
close all
clear all
clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = 0.4;      %[Ns/m]
Ke = 0;       %[Vs/m]
Ca1 = Cd*pi*da1*sqrt(Ps*(2/rho));
Krc = 20000; %[V/m]
Ti = [0.5 1 1.5 2]; %[s] integratietijd

% Toestandsvorm: klepstand voor zowel evaluatie- als ontwerpmodel
figure(1)
xlabel('Tijd (s)')
ylabel('Klepstand (m)')
title('Klepstand van de solenoÃ¯dklep met PI-regelaar')
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
for i = 1:4 %for-loop voor evaluatiemodel
    A = [0 1 0 0; -k/m -c/m Kc/m 0; 0 -Ke/L -R/L 1/L; -Krc/Ti(i) -Krc 0 0]; %Toestandsmatrix
    B = [0 0; 0 0; 0 1/L; Krc/Ti(i) 0]; %Inputmatrix
    C = [1 0 0 0]; %Outputmatrix
    D = []; %Doorkoppelmatrix
    sys1 = ss(A,B,C,D);
    [y,t1]= lsim(sys1,v,t1);
    hold on
    plot(t1,y(:,1))
    P_evaluatie{i} = pole(sys1);
end

for i=1:4 %for-loop voor ontwerpmodel
    E = [0 1 0; (-k/m) -((Kc*Ke)/(m*R))-(c/m) Kc/(m*R); -Krc/Ti(i) -Krc 0]; %Toestandsmatrix
    F = [0 0; 0 Kc/(m*R); Krc/Ti(i) 0]; %Inputmatrix
    G = [1 0 0]; %Outputmatrix
    H = []; %Doorkoppelmatrix
    sys2 = ss(E,F,G,H);
    [Y,t1]= lsim(sys2,v,t1);
    hold on
    plot(t1,Y(:,1),'--')
    P_ontwerp{i} = pole(sys2);
end
legend('evaluatie: Ti=0.5','evaluatie: Ti=1','evaluatie: Ti=1.5','evaluatie: Ti=2','ontwerp: Ti=0.5','ontwerp: Ti=1','ontwerp: Ti=1.5','ontwerp: Ti=2','Location','southeast')

%% Poolbanen van 4 verschillende transferfuncties
close all
clear all
clc

% Transferfunctie 1
G1 = tf([1 1],[1 4 6 4 0]);
% plot van polen en nulpunten
figure(1)
pzplot(G1)
title('Polen (x) en nulpunten (o) transferfunctie 1')
xlabel('Reële as')
ylabel('Imaginaire as')
% plot van poolbanen
figure(2)
rlocus(G1)
xlabel('Reële as')
ylabel('Imaginaire as')
title('Poolbanen van transferfunctie 1')

% Transferfunctie 2
G2 = tf([1],[1 4]);
% plot van polen en nulpunten
figure(3)
pzplot(G2)
title('Polen (x) en nulpunten (o) transferfunctie 2')
xlabel('Reële as')
ylabel('Imaginaire as')
% plot van poolbanen
figure(4)
rlocus(G2)
xlabel('Reële as')
ylabel('Imaginaire as')
title('Poolbanen van transferfunctie 2')

% Transferfunctie 3
G3 = tf([1],[1 40 300 0]);
% plot van polen en nulpunten
figure(5)
pzplot(G3)
title('Polen (x) en nulpunten (o) transferfunctie 3')
xlabel('Reële as')
ylabel('Imaginaire as')
% plot van poolbanen
figure(6)
rlocus(G3)
xlabel('Reële as')
ylabel('Imaginaire as')
title('Poolbanen van transferfunctie 3')

% Transferfunctie 4
G4 = tf([1 3],[1 3 2]);
% plot van polen en nulpunten
figure(7)
pzplot(G4)
title('Polen (x) en nulpunten (o) transferfunctie 4')
xlabel('Reële as')
ylabel('Imaginaire as')
% plot van poolbanen
figure(8)
rlocus(G4)
xlabel('Reële as')
ylabel('Imaginaire as')
title('Poolbanen van transferfunctie 4')
%% Poolbanen van de gesloten-kring transferfunctie van de solenoÃ¯dklep in functie van de versterking Krc
close all
clear all
clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = 0.4;      %[Ns/m]
Ke = 0;       %[Vs/m]

% Gesloten-kring systeem met P-regelaar: evaluatiemodel
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
A = [0 1 0; -k/m -c/m Kc/m; 0 -Ke/L -R/L]; %Toestandsmatrix
B = [0;0;1/L]; %Inputmatrix
C = [1 0 0]; %Outputmatrix
D = []; %Doorkoppelmatrix
sys1 = ss(A,B,C,D);
G1 = tf(sys1); %Transferfunctie van het proces: G1 = Gp
Polen{1} = pole(sys1); %Berekent de polen van G1 (zijn dezelfe polen voor Go (open-kring)) en voor Krc 0 = zijn dit de gesloten-kring polen -> startpunten op de poolbaan
figure(1)
rlocus(G1)
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met P-regelaar: evaluatiemodel')
figure(2)
rlocus(G1)
xlim([-4,1])
ylim([-20,20])
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met P-regelaar: evaluatiemodel')

% Gesloten-kring systeem met P-regelaar: ontwerpmodel
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
A = [0 1; -k/m -((Kc*Ke)/(m*R))-(c/m)]; %Toestandsmatrix
B = [0;Kc/(m*R)]; %Inputmatrix
C = [1 0]; %Outputmatrix
D = []; %Doorkoppelmatrix
sys2 = ss(A,B,C,D); 
G2 = tf(sys2); %Transferfunctie van het proces: G2 = Gp
Polen{2} = pole(sys2);
figure(3)
rlocus(G2)
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met P-regelaar: ontwerpmodel')

% Gesloten-kring systeem met PI-regelaar: evaluatiemodel
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
A = [0 1 0; -k/m -c/m Kc/m; 0 -Ke/L -R/L]; %Toestandsmatrix
B = [0;0;1/L]; %Inputmatrix
C = [1 0 0]; %Outputmatrix
D = []; %Doorkoppelmatrix
sys3 = ss(A,B,C,D); 
G3 = tf([1 1],[1 0])*tf(sys3); %Transferfunctie van het proces vermenigvuldigd met transferfunctie van de PI-regelaar zonder Krc zodat Go = Krc*(1/(Ti*s))*Gp = Krc*G3
Polen{3} = pole(sys3);
figure(4)
rlocus(G3)
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met PI-regelaar: evaluatiemodel')
figure(5)
rlocus(G3)
xlim([-4,1])
ylim([-15,15])
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met P-regelaar: evaluatiemodel')

% Gesloten-kring systeem met PI-regelaar: ontwerpmodel
t1 = 0:0.001:10; %[s]
vruis = [-1*ones(1,length(t1))];
xref = [zeros(1,(length(t1)-1)*0.2) 0.002*ones(1,((length(t1)-1)*0.8)+1)]; %[m] referentiewaarde van de klep (gewenste positie van de solenoÃ¯dklep)%[V]
v = [xref; vruis]; %[V]
A = [0 1; -k/m -((Kc*Ke)/(m*R))-(c/m)]; %Toestandsmatrix
B = [0;Kc/(m*R)]; %Inputmatrix
C = [1 0]; %Outputmatrix
D = []; %Doorkoppelmatrix
sys4 = ss(A,B,C,D); 
G4 = tf([1 1],[1 0])*tf(sys4);  %Transferfunctie van het proces vermenigvuldigd met transferfunctie van de PI-regelaar zonder Krc zodat Go = Krc*(1/(Ti*s))*Gp = Krc*G4
Polen{4} = pole(sys4);
figure(6)
rlocus(G4)
xlabel('ReÃ«le as')
ylabel('Imaginaire as')
title('Poolbanen van gesloten-kring systeem met PI-regelaar: ontwerpmodel')

%% Bodediagramma's van de transferfuncties van de solenoïdklep: evaluatiemodel
close all
clear all
clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = 0.4;      %[Ns/m]
Ke = 0;       %[Vs/m]
Krc = [10000 20000 30000 50000 100000 400000]; %[V/m] Variabele versterkingsparameter van de P-regelaar
Ti = 1;       %[s] integratietijd

% Evaluatiemodel
TF_evP = cell(1,3);  % Opslaan van de transferfuncties in een cell voor P-regelaar
TF_evPI = cell(1,3); % Opslaan van de transferfuncties in een cell voor PI-regelaar
A = [0 1 0; -k/m -c/m Kc/m; 0 -Ke/L -R/L]; %Toestandsmatrix
B = [0;0;1/L]; %Inputmatrix
C = [1 0 0]; %Outputmatrix
D = []; %Doorkoppelmatrix
sys1 = ss(A,B,C,D);
Gp = tf(sys1);
for i = 1:length(Krc)
    Gr_P = tf([Krc(i)],[1]);
    G0_P = Gp*Gr_P;
    [Gm_evP(i),Pm_evP(i),Wg_evP(i),Wp_evP(i)] = margin(G0_P);
    TF_evP{1,i} = G0_P;
    Gt_P = G0_P/(1+G0_P);
    TF_evP{2,i} = Gt_P;
    S_P= 1/(1+G0_P);
    TF_evP{3,i} = S_P;
    s = tf('s');
    Gr_PI = Krc(i)*(1+(1/(Ti*s)));
    G0_PI = Gp*Gr_PI;
    [Gm_evPI(i),Pm_evPI(i),Wg_evPI(i),Wp_evPI(i)] = margin(G0_PI);
    TF_evPI{1,i} = G0_PI;
    Gt_PI = G0_PI/(1+G0_PI);
    TF_evPI{2,i} = Gt_PI;
    S_PI= 1/(1+G0_PI);
    TF_evPI{3,i} = S_PI;
end

% Open-kring transferfunctie: evaluatie en P-regelaar
figure(1)
hold on
for i = 1:length(Krc)
    margin(TF_evP{1,i})
end
grid on
title('Bode-diagramma van open-kring transferfunctie met P-regelaar: evaluatiemodel')
legend({'Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000'},'Location','southwest','FontSize',8)

% Gesloten-kring transferfunctie: evaluatie en P-regelaar
figure(2)
hold on
for i = 1:length(Krc)
    bodemag(TF_evP{2,i})
end
grid on
title('Magnitudeplot van gesloten-kring transferfunctie met P-regelaar: evaluatiemodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southwest')

% Sensitiviteitsfunctie: evaluatie en P-regelaar
figure(3)
hold on
for i = 1:length(Krc)
    bodemag(TF_evP{3,i})
end
grid on
title('Magnitudeplot van sensitiviteitsfunctie met P-regelaar: evaluatiemodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southeast')

% Open-kring transferfunctie: evaluatie en PI-regelaar
figure(4)
hold on
for i = 1:length(Krc)
    margin(TF_evPI{1,i})
end
grid on
title('Bode-diagramma van open-kring transferfunctie met PI-regelaar: evaluatiemodel')
legend({'Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000'},'Location','southwest','FontSize',8)

% Gesloten-kring transferfunctie: evaluatie en PI-regelaar
figure(5)
hold on
for i = 1:length(Krc)
    bodemag(TF_evPI{2,i})
end
grid on
title('Magnitudeplot van gesloten-kring transferfunctie met PI-regelaar: evaluatiemodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southwest')

% Sensitiviteitsfunctie: evaluatie en PI-regelaar
figure(6)
hold on
for i = 1:length(Krc)
    bodemag(TF_evPI{3,i})
end
grid on
title('Magnitudeplot van sensitiviteitsfunctie met PI-regelaar: evaluatiemodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southeast')

%% Bodediagramma's van de transferfuncties van de solenoïdklep: ontwerpmodel
close all
%clear all
%clc
% Parameterwaarden voor de solenoÃ¯dklep
Cd = 0.64;
da1 = 0.05;   %[m]
Ps = 200000;  %[Pa]
rho = 1000;   %[kg/m^3]
m = 0.125;    %[kg]
k = 0.20;     %[N/m]
L = 0.06;     %[H]
R = 4;        %[Ohm]
Kc = 4*10^-4; %[N/A]
c = 0.4;      %[Ns/m]
Ke = 0;       %[Vs/m]
Krc = [10000 20000 30000 50000 100000 400000]; %[V/m] Variabele versterkingsparameter van de P-regelaar
Ti = 1;       %[s] integratietijd

% Ontwerpmodel
TF_ontP = cell(1,3);  % Opslaan van de transferfuncties in een cell voor P-regelaar
TF_ontPI = cell(1,3); % Opslaan van de transferfuncties in een cell voor PI-regelaar
E = [0 1; -k/m -((Kc*Ke)/(m*R))-(c/m)]; %Toestandsmatrix
F = [0;Kc/(m*R)]; %Inputmatrix
G = [1 0]; %Outputmatrix
H = []; %Doorkoppelmatrix
sys2 = ss(E,F,G,H);
Gp = tf(sys2);
for i = 1:length(Krc)
    Gr_P = tf([Krc(i)],[1]);
    G0_P = Gp*Gr_P;
    [Gm_ontP(i),Pm_ontP(i),Wg_ontP(i),Wp_ontP(i)] = margin(G0_P);
    TF_ontP{1,i} = G0_P;
    Gt_P = G0_P/(1+G0_P);
    TF_ontP{2,i} = Gt_P;
    S_P= 1/(1+G0_P);
    TF_ontP{3,i} = S_P;
    s = tf('s');
    Gr_PI = Krc(i)*(1+(1/(Ti*s)));
    G0_PI = Gp*Gr_PI;
    [Gm_ontPI(i),Pm_ontPI(i),Wg_ontPI(i),Wp_ontPI(i)] = margin(G0_PI);
    TF_ontPI{1,i} = G0_PI;
    Gt_PI = G0_PI/(1+G0_PI);
    TF_ontPI{2,i} = Gt_PI;
    S_PI= 1/(1+G0_PI);
    TF_ontPI{3,i} = S_PI;
end

% Open-kring transferfunctie: ontwerp en P-regelaar
figure(1)
hold on
for i = 1:length(Krc)
    margin(TF_ontP{1,i})
end
grid on
title('Bode-diagramma van open-kring transferfunctie met P-regelaar: ontwerpmodel')
legend({'Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000'},'Location','southwest','FontSize',8)

% Gesloten-kring transferfunctie: ontwerp en P-regelaar
figure(2)
hold on
for i = 1:length(Krc)
    bodemag(TF_ontP{2,i})
end
grid on
title('Magnitudeplot van gesloten-kring transferfunctie met P-regelaar: ontwerpmodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southwest')

% Sensitiviteitsfunctie: ontwerp en P-regelaar
figure(3)
hold on
for i = 1:length(Krc)
    bodemag(TF_ontP{3,i})
end
grid on
title('Magnitudeplot van sensitiviteitsfunctie met P-regelaar: ontwerpmodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southeast')

% Open-kring transferfunctie: ontwerp en PI-regelaar
figure(4)
hold on
for i = 1:length(Krc)
    margin(TF_ontPI{1,i})
end
grid on
title('Bode-diagramma van open-kring transferfunctie met PI-regelaar: ontwerpmodel')
legend({'Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000'},'Location','southwest','FontSize',8)

% Gesloten-kring transferfunctie: ontwerp en PI-regelaar
figure(5)
hold on
for i = 1:length(Krc)
    bodemag(TF_ontPI{2,i})
end
grid on
title('Magnitudeplot van gesloten-kring transferfunctie met PI-regelaar: ontwerpmodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southwest')

% Sensitiviteitsfunctie: ontwerp en PI-regelaar
figure(6)
hold on
for i = 1:length(Krc)
    bodemag(TF_ontPI{3,i})
end
grid on
title('Magnitudeplot van sensitiviteitsfunctie met PI-regelaar: ontwerpmodel')
legend('Krc=10000','Krc=20000','Krc=30000','Krc=50000','Krc=100000','Krc=400000','Location','southeast')

%% Polair diagramma van transferfuncties
close all
clear all
clc

tau1 = 1
tau2 = 2
tau3 = 3

% transferfuncties definiëren
num1 = [1,0]; den1 = [1];G1=tf(num1,den1); G{1} = G1; 
num2 = [1,0,0]; den2 = [1];G2=tf(num2,den2); G{2} = G2;
num3 = [1]; den3 = [1,0,0];G3=tf(num3,den3); G{3} = G3;
num4 = [tau1,1]; den4 = [1];G4=tf(num4,den4); G{4} = G4;
num5 = [1]; den5 = [tau1,1];G5=tf(num5,den5); G{5} = G5;
num6 = [tau1,0]; den6 = [tau1,1];G6=tf(num6,den6); G{6} = G6;
num7 = [1]; den7 = [tau1*tau2,(tau1+tau2),1];G7=tf(num7,den7); G{7} = G7;
num8 = [1]; den8 = [tau1*tau2*tau3,(tau3*tau1)+(tau3*tau2)+(tau1*tau2),tau3+tau1+tau2,1];G8=tf(num8,den8); G{8} = G8;
num9 = [tau1,1]; den9 = [tau2*tau3,(tau2+tau3),1,0];G9=tf(num8,den9); G{9} = G9;
 
Polairdiagrammatransferfunction ={'Polair diagramma transfer functie G1','Polair diagramma transfer functie G2','Polair diagramma transfer functie G3','Polair diagramma transfer functie G4','Polair diagramma transfer functie G5','Polair diagramma transfer functie G6','Polair diagramma transfer functie G7','Polair diagramma transfer functie G8','Polair diagramma transfer functie G9'}

for i = 1:9
[MAG{i}, PHASE{i}]=bode(G{i});
PHASE{i} = squeeze(PHASE{i})/180 * pi;
MAG {i}= squeeze(MAG{i});
end 

for i = 1:9
figure
polarplot(PHASE{i},MAG{i},'Linewidth',1.5);
title (Polairdiagrammatransferfunction{i});
end 

% Polair diagramma tf 10 met w=3
z = [0.3 0.5 0.7]
for i = 1:3
G10=tf([9],[1, 2*z(i)*3, 9, 0]);
[MAG10, PHASE10]=bode(G10);
PHASE10 = PHASE10(1,:)/180 * pi;
MAG10= MAG10(1,:);
hold on 
figure(10)
polarplot(PHASE10,MAG10,'Linewidth',1.5);
title ('Polair diagramma transfer functie 10');
end 
legend('\zeta = 0.3','\zeta=0.5','\zeta=0,7')

% Polair diagramma tf 11 en tf 12 met z = 0.4 en w = 3
Td = 1
G11=tf([9],[1, 2*0.4*3, 9]);
G12= tf([9],[1, 2*0.4*3, 9],'InputDelay',Td);
w = logspace(0,1,1000)

%tf 11
[MAG11, PHASE11]=bode(G11,w);
PHASE11 = PHASE11(1,:)/180 * pi;
MAG11= MAG11(1,:);
hold on 
figure(11)
polarplot(PHASE11,MAG11,'Linewidth',1.5);

%tf 12
[MAG12, PHASE12]=bode(G12,w);
PHASE12 = PHASE12(1,:)/180 * pi;
MAG12= MAG12(1,:);
hold on
figure(11)
polarplot(PHASE12,MAG12,'Linewidth',1.5);
title ('Polair diagramma transfer functie 11 en 12');

legend('zonder delay','met delay')

% bijhorende faseplot
figure (12)
hold on 
h = bodeplot(G11);
setoptions(h,'MagVisible','off')
figure (12)
hold on 
h = bodeplot(G12);
setoptions(h,'MagVisible','off')
title ('Bijhorende faseplot')
ylim([-500 0])
legend('zonder delay','met delay')
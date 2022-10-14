clear, clc;
close all;

%{ 
    Relevant gas info:
    Nitrogen specific heat value (k) = 1.4
    Nitrogen boiling point = 77.36 Kelvin
    Nitrogen gas constant = 296.80 J/kg K
%}

% RP = py.ctREFPROP.ctREFPROP.REFPROPFunctionLibrary('C:\Program Files (x86)\MINI-REFPROP');
% RP.SETPATHdll('C:\Program Files (x86)\MINI-REFPROP');
% 
% MOLAR_BASE_SI = RP.GETENUMdll(0, "MOLAR BASE SI").iEnum;
% p_Pa = 101325;
% Q = 0.0;
% r = RP.REFPROPdll("Water","PQ","T",uint8(MOLAR_BASE_SI),0,0,p_Pa,Q,[1.0]);
% r.Output(0)

psi2bar = 0.0689476;
ft3tolit = 28.3168;

% required variables
% everything is in SI
compZI = 1; % compressibility factor, you can find this out with NIST refprop
compZF = 1;
compU = 1; % ullage compressibility
polyExponent = 1; % choose based on isothermal or isentropic
chamberPress = 400;
loxDensity = 68;
keroDensity = 50;
loxMass = 20.74;
keroMass = 9.43;
Pp = 1.38*chamberPress;
gasPressureI = linspace(6*Pp,8*Pp,10); 


vol = isotherm(chamberPress,loxDensity,keroDensity,loxMass,keroMass,gasPressureI);

SI_pressure = gasPressureI.*psi2bar;
SI_volume = vol.*ft3tolit;

figure
subplot(2,1,1)
plot(gasPressureI,vol)
title('which tank to buy Murica')
xlabel('Rated pressure (psi)')
ylabel('Tank volume (cubic ft)')
hold on; grid on;

subplot(2,1,2)
plot(SI_pressure,SI_volume)
title('which tank to buy SI')
xlabel('Rated pressure (Bar)')
ylabel('Tank volume (Litre)')
hold on; grid on;

function pressurantTankVolume = isotherm(Pc, rhoO2, rhoker, mlox, mker, P0)
    
    numerator = 1.38*Pc*(mlox/rhoO2 + mker/rhoker);
    denominator = P0 - .207*Pc;
    pressurantTankVolume = numerator./denominator;

end
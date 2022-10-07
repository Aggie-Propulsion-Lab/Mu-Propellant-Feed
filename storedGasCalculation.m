clear, clc;
close all;

%{ 
    Relevant gas info:
    Nitrogen specific heat value = 1.4
    Nitrogen boiling point = 77.36 Kelvin
    Nitrogen gas constant = 296.80 J/kg K
%}

% fixed volume
% required variables
% gas indicates pressurant
compZI = 1; % compressibility factor, you can find this out with NIST refprop
compZF = 1;
compU = 1; % ullage compressibility
gasVol = 0; % non-specific in cubic meter
propVolume = .0139; % non-specific in cubic meter
propPressure = 3.45e6; % Pa
gasPressureI = 4e6:8e5:2e7;
gasPressureF = 1.15*propPressure;
gasConst = 296.8; % 296.8 J/kgK for N2
gasTempI = 77.36;
gasTempF = 77.36;
ullageTemp = 77.36;
polyExponent = 1; % choose based on isothermal or isentropic

% calculations

%fixing volume
%{ 
a = (compZI*gasTempI*propPressure*propVolume)./(gasVol*compU*ullageTemp);
b = (compZI*gasTempI*gasPressureF)./(compZF*gasTempF);
gasPressureI = a+b;
gasPressurePSI = gasPressureI*.000145;
%}

%fixing pressure isothermal
a = (propPressure*propVolume)./gasPressureI;
b = (1-(gasPressureF./gasPressureI)).^-1;
gasVol = a.*b;

gasVolFt = gasVol*35.3;
gasPressurePSI = gasPressureI*.000145;

figure
plot(gasPressurePSI, gasVolFt)
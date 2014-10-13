function IKr = f_IKr( t,X )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

% /*-----------------------------------------------------------------------------
% PARAMETERS FOR INITIAL CONDITIONS
% ------------------------------------------------------------------------------*/
%Initial values of state variables
Volt = -86.2;
Volt2 = -86.2;
Cai = 0.00007;
CaSR = 1.3;
CaSS = 0.00007;
Nai = 7.67;
Ki = 138.3;
M = 0.;
H = 0.75;
J = 0.75;
Xr1 = 0.;
Xr2 = 1.;
Xs = 0.;
R = 0.;
S = 1.;
D = 0.;
F = 1.;
F2 = 1.;
FCass = 1.;
RR = 1.;
OO = 0.;
Itot = 0.;

%Cell type should be either 'Epi' or 'M' or 'Endo'
celltype = 'M';

%External concentrations
Ko = 5.4;
Cao = 2.0;
Nao = 140.0;

%Intracellular volumes
Vc = 0.016404;
Vsr = 0.001094;
Vss = 0.00005468;

%Calcium buffering dynamics
Bufc = 0.2;
Kbufc = 0.001;
Bufsr = 10.;
Kbufsr = 0.3;
Bufss = 0.4;
Kbufss = 0.00025;

%Intracellular calcium flux dynamics
Vmaxup = 0.006375;
Kup = 0.00025;
Vrel = 0.102;%40.8;
k1_ = 0.15;
k2_ = 0.045;
k3 = 0.060;
k4 = 0.005;%0.000015;
EC = 1.5;
maxsr = 2.5;
minsr = 1.;
Vleak = 0.00036;
Vxfer = 0.0038;

%Constants
R = 8314.472;
F = 96485.3415;
T = 310.0;
RTONF = (R*T) / F;

%Cellular capacitance         
CAPACITANCE = 0.185;

%Parameters for currents
%Parameters for IKr
Gkr = 0.153;
%Parameters for Iks
pKNa = 0.03;
if strcmp('Epi',celltype)
    Gks = 0.392;
elseif strcmp('ENDO', celltype)
    Gks = 0.392;
else
    Gks = 0.098;
end
% //Parameters for Ik1
GK1 = 5.405;
% //Parameters for Ito
if strcmp('Epi',celltype)
    Gto = 0.294;
elseif strcmp('ENDO', celltype)
    Gto = 0.073;
else
    Gto = 0.294;
end
% //Parameters for INa
GNa = 14.838;
% //Parameters for IbNa
GbNa = 0.00029;
% //Parameters for INaK
KmK = 1.0;
KmNa = 40.0;
knak = 2.724;
% //Parameters for ICaL
GCaL = 0.00003980;
% //Parameters for IbCa
GbCa = 0.000592;
% //Parameters for INaCa
knaca = 1000;
KmNai = 87.5;
KmCa = 1.38;
ksat = 0.1;
n = 0.35;
% //Parameters for IpCa
GpCa = 0.1238;
KpCa = 0.0005;
% //Parameters for IpK;
GpK = 0.0146;


% /*------------------------------------------------------------------------------
% PARAMETER FOR INTEGRATION
% ------------------------------------------------------------------------------*/
%timestep (ms)
HT = 0.02;

% /*--------------------------------------- ------------------------------------
% PARAMETER FOR SIMULATION DURATION
% ---------------------------------------------------------------------------*/
%duration of the simulation 
STOPTIME = 10000;

% /*-----------------------------------------------------------------------------
% PARAMETERS FOR STIMULATION PROTOCOLS
% -----------------------------------------------------------------------------*/

%S1S2RESTPROTOCOL
i_low = 0; i_high = 1;
j_low = 0; j_high = 1;
stimduration = 1.;
stimstrength = -52;
tbegin = 0;
tend = tbegin + stimduration;
counter = 1;
dia = 5000;
basicperiod = 1000.;
basicapd = 274;
repeats = 10;

Ek = RTONF*(log((Ko / Ki)));
sxr1 = Xr1;
sxr2 = Xr2;
svolt = Volt;
IKr = Gkr*sqrt(Ko / 5.4)*sxr1*sxr2*(svolt - Ek);
end


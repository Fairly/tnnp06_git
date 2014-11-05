clear all
close all

% /*-----------------------------------------------------------------------------
% PARAMETERS FOR INITIAL CONDITIONS
% ------------------------------------------------------------------------------*/
%Initial values of state variables
Volt = -86.2;
Cai = 0.00007;
CaSR = 1.3;
CaSS = 0.00007;
Nai = 7.67;
Ki = 138.3;
INa_m = 0.;
INa_h = 0.75;
INa_j = 0.75;
IKr_xr1 = 0.;
IKr_xr2 = 1.;
IKs_xs = 0.;
Ito_r = 0.;
Ito_s = 1.;
ICaL_d = 0.;
ICaL_f = 1.;
ICaL_f2 = 1.;
ICaL_fCaSS = 1.;
RR = 1.;
%OO = 0.;

CL = 1000;
beats = 20;
X0 = [Volt Cai CaSR CaSS Nai Ki INa_m INa_h INa_j IKr_xr1 IKr_xr2 IKs_xs Ito_r Ito_s ICaL_d ICaL_f ICaL_f2 ICaL_fCaSS RR];
options=[];

for n=1:beats
    [time, X]=ode15s(@model,[0 CL],X0,options,1);
    X0=X(size(X,1),:);
    n; %output beat number to the screen to monitor runtime progress
end

%rename values in the state variables vector
v=X(:,1);
Cai=X(:,2);
CaSR=X(:,3);
CaSS=X(:,4);
Nai=X(:,5);
Ki=X(:,6);
INa_m=X(:,7);
INa_h=X(:,8);
INa_j=X(:,9);
IKr_xr1=X(:,10);
IKr_xr2=X(:,11);
IKs_xs=X(:,12);
Ito_r=X(:,13);
Ito_s=X(:,14);
CaL_d=X(:,15);
CaL_f=X(:,16);
CaL_f2=X(:,17);
CaL_fCaSS=X(:,18);
RR=X(:,19);

%calculate and name dependent variables for the final beat in the
%simulation (i.e. currents and fluxes)
IKr =zeros(1,size(X,1));
IKs=zeros(1,size(X,1));
IK1=zeros(1,size(X,1));
Ito=zeros(1,size(X,1));
INa=zeros(1,size(X,1));
IbNa=zeros(1,size(X,1));
INaK=zeros(1,size(X,1));
ICaL=zeros(1,size(X,1));
IbCa=zeros(1,size(X,1));
INaCa=zeros(1,size(X,1));
IpCa=zeros(1,size(X,1));
IpK=zeros(1,size(X,1));
Istim=zeros(1,size(X,1));
for i=1:size(X,1);
    IsJs=model(time(i),X(i,:),0);
    IKr(i)=IsJs(1);
    IKs(i)=IsJs(2);
    IK1(i)=IsJs(3);
    Ito(i)=IsJs(4);
    INa(i)=IsJs(5);
    IbNa(i)=IsJs(6);
    INaK(i)=IsJs(7);
    ICaL(i)=IsJs(8);
    IbCa(i)=IsJs(9);
    INaCa(i)=IsJs(10);
    IpCa(i)=IsJs(11);
    IpK(i)=IsJs(12);
    Istim(i)=IsJs(13);
end

figure
subplot(3,3,1),plot(time,INa),title('INa')
subplot(3,3,3),plot(time,Ito),title('Ito')
subplot(3,3,5),plot(time,ICaL),title('ICaL')
subplot(3,3,6),plot(time,IKr),title('IKr')
subplot(3,3,7),plot(time,IKs),title('IKs')
subplot(3,3,8),plot(time,INaCa),title('INaCa')
subplot(3,3,9),plot(time,INaK),title('INaK')

figure
plot(time,v,time,Istim),title('v,Istim'),axis([0,400,-100,70])
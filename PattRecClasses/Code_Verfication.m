
%% Test MC%%
clear all;
mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);%State generator
x=rand(mc, 100000); %Generate an output sequence
s1=sum(x==1)/100000;
s2=sum(x==2)/100000;

%% Test HMM
g1=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
g2=GaussD('Mean',3,'StDev',2) ;%Distribution for state=2
h=HMM(mc, [g1; g2]); %The HMM

[Y,S]=rand(h,1000000);
mU=mean(Y);
vr=var(Y);

%% Samples of X_t
[X_t,S_t] =rand(h,500);
X_t=reshape(X_t,1,500);
t=1:500;
plot(t,X_t);
title('Samples from Hidden Markov Model')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')

%% Samples of X_t new distribution

g11=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
g22=GaussD('Mean',0,'StDev',2) ;%Distribution for state=2
h2=HMM(mc, [g11; g22]); %The HMM

[X_1t,S_1t] =rand(h2,500);
X_1t=reshape(X_1t,1,500);
%t=1:500;
plot(t,X_1t);
title('Samples from Hidden Markov Model with equal Means')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')

%% Finite Duration
mcf=MarkovChain([0.75;0.25], [0.99 0.01 0;0.02 0.97 0.01]);
gf1=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
gf2=GaussD('Mean',3,'StDev',2) ;%Distribution for state=2
gf3=GaussD('Mean',1,'StDev',1) ;%Distribution for state=2
hf=HMM(mcf, [gf1; gf2;gf3]);

[Yf,Sf]=rand(hf,1000);
mU=mean(Yf);
vr=var(Yf);




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
clear all;
mcf=MarkovChain([0.75;0.25], [0.99 0.01 0;0.02 0.97 0.01]);
gf1=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
gf2=GaussD('Mean',3,'StDev',2) ;%Distribution for state=2
%gf3=GaussD('Mean',1,'StDev',1) ;%Distribution for state=2
hf=HMM(mcf, [gf1; gf2]);

[Yf,Sf]=rand(hf,1000);
Yf=reshape(Yf,1,size(Yf,3));
mUf=mean(Yf);
vrf=var(Yf);
t=1:size(Sf,2);
t1=1:(size(Sf,2)-1);
plot(t,Sf,'--o');
title('State samples over time')
xlabel('Time Steps t')
ylabel('Hidden Markov State ')
ax=gca;
ax.YTick=[0 1 2 3 4];
figure()
plot(t1,Yf);
title('Samples from Hidden Markov Model of Finite Duration')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')

%% Random Vector Generation
clear all;
mcv=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
g1v=GaussD('Mean',[4; 5],'Covariance',[1, 0;0, 1]);%Distribution for state=1
g2v=GaussD('Mean',[1; 3],'Covariance',[2, 1;1, 4]); 
hv=HMM(mcv, [g1v; g2v]);
[Yv,Sv]=rand(hv,10000);


scatter(Yv(1,Sv==1),Yv(2,Sv==1),[],'b');
hold on
scatter(Yv(1,Sv==2),Yv(2,Sv==2),[],'y','*');
title('Scatter Plot of Generated Output for Two Dimensional Gaussian Emisions')
xlabel('Emission (X_1)')
ylabel('Emission (X_2)')
legend('State 1', 'State 2')




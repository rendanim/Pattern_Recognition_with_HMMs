%%  Set Randomseed

 rng(1000);
%%  Question 2 Test MC%%
clear all;
mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);%State generator
x=rand(mc, 10000); %Generate an output sequence
s1=sum(x==1)/10000; %State Means
s2=sum(x==2)/10000;

%%  Question 3 Test HMM
g1=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
g2=GaussD('Mean',3,'StDev',2) ;%Distribution for state=2
h=HMM(mc, [g1; g2]); %The HMM

[Y,S]=rand(h,10000);% HMM Samples
mU=mean(Y);
vr=var(Y);

%% Question 4 500 Samples of X_t
[X_t,S_t] =rand(h,500);
X_t=reshape(X_t,1,500);
t=1:500;
% plot(t,X_t);
stat_plot = zeros(size(t));
stat_plot(S_t == 2) = 3;
plot(t,X_t,'b', t(S_t == 1), stat_plot(S_t == 1), 'r.', t(S_t == 2), stat_plot(S_t == 2), 'y.');
legend('Emission (X_t)','Mean of State 1','Mean of State = 2');
title('Samples from Hidden Markov Model')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')

%% Question 5 Samples of X_t new distribution

g11=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
g22=GaussD('Mean',0,'StDev',2) ;%Distribution for state=2
h2=HMM(mc, [g11; g22]); %The HMM

[X_1t,S_1t] =rand(h2,500);
X_1t=reshape(X_1t,1,500);
%t=1:500;
stat_plot = zeros(size(t));
plot(t,X_1t,'b',t(S_1t==1),stat_plot(S_1t==1),'r.',t(S_1t==2),stat_plot(S_1t==2),'y.');
legend('Emission (X_t)','State 1','State 2');
%plot(t,X_1t);
title('Samples from Hidden Markov Model with equal Means')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')

%% Question 6 Finite Duration
%clear all;
mcf=MarkovChain([0.75;0.25], [0.99 0.01 0;0.02 0.97 0.01]);
gf1=GaussD('Mean',0,'StDev',1) ;%Distribution for state=1
gf2=GaussD('Mean',3,'StDev',2) ;%Distribution for state=2
%gf3=GaussD('Mean',1,'StDev',1) ;%Distribution for state=2
hf=HMM(mcf, [gf1; gf2]);

[Yf,Sf]=rand(hf,1000);
mUf=mean(Yf);
vrf=var(Yf);
t=1:size(Sf,2);
t1=1:(size(Sf,2)-1);
plot(t,Sf,'r-*');
title('State samples over time')
xlabel('Time Steps t')
ylabel('Hidden Markov State ')
ax=gca;
%ax.YTick=[0 1 2 3 4];
hold on
plot(t1,Yf);
title('Samples from Hidden Markov Model of Finite Duration')
xlabel('Time Steps t')
ylabel('Hidden Markov Emission (X_t)')
legend('State','Output')
hold off

%% Question 7 Random Vector Generation
clear all;
mcv=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
g1v=GaussD('Mean',[4; 5],'Covariance',[1, 0;0, 1]); % State 1 distribution
g2v=GaussD('Mean',[1; 3],'Covariance',[2, 1;1, 4]); % State 2 distribution
hv=HMM(mcv, [g1v; g2v]);
[Yv,Sv]=rand(hv,10000);


scatter(Yv(1,Sv==1),Yv(2,Sv==1),[],'b');
hold on
scatter(Yv(1,Sv==2),Yv(2,Sv==2),[],'y','*');
title('Scatter Plot of Generated Output for Two Dimensional Gaussian Emisions')
xlabel('Emission (X_1)')
ylabel('Emission (X_2)')
legend('State 1', 'State 2')




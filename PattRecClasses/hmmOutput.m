clc
clear

S = load('./HMM/HMMsmall_state5_pseudo0.5.mat');
D = load('./HMM/HMM40_state5_pseudo0.5.mat')

%% Test on Character 4
hmmS = S.hmm(4,2);
hmmD = D.hmm(4,5);

[Xs,Ss] = rand(hmmS,40);
[Xd,Sd] = rand(hmmD,40);

load('4.mat');
feature = Feature_Exreaction(data(3));

%% Output distribution
Emiss = [0.0026	0.0024	0.0027	0.0024	0.0024	0.2846	0.6804	0.003	0.0024	0.0024	0.0024	0.0024	0.0024	0.0024	0.0024	0.0024
0.4027	0.0114	0.033	0.0114	0.0114	0.0137	0.032	0.3933	0.0114	0.0114	0.0114	0.0114	0.0114	0.0114	0.0114	0.0114
0.9313	0.0267	0.0037	0.0025	0.0048	0.0025	0.0028	0.0056	0.0025	0.0025	0.0025	0.0025	0.0025	0.0025	0.0025	0.0025
0.0137	0.0342	0.1721	0.0105	0.0633	0.0105	0.0512	0.0624	0.0105	0.0105	0.0312	0.4883	0.0105	0.0105	0.0105	0.0105
0.0053	0.0018	0.0621	0.0053	0.0018	0.0018	0.8842	0.0231	0.0018	0.0018	0.0018	0.0023	0.0018	0.0018	0.0018	0.0018]

imagesc(Emiss)

%% Transition Matrix
A = full(hmmS.StateGen.TransitionProb)

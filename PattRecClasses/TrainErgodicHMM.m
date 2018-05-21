function [ hmm ] = TrainErgodicHMM( X, n_X, nStates, nFeature, pseudoCount)
%TRAINLEFTRIGHTHMM Train one HMM model from a dataset
%   X: A dataset, each data is stored as a cell
%   n_X: number of data
%   nStates: expected number of state
%   nFeature: identical to number of features

emiss = cell(n_X ,1);

for i = 1 : n_X
    e_temp = Feature_Exreaction( X(i) );
    emiss(i) = {e_temp};
end

pD = DiscreteD(ones(nStates, nFeature) ./ nFeature); %initialize
for i = 1 : nStates
    pD(i) = init(pD(i), [cell2mat(emiss(1)), 1:16]); 
    %round observation to 16, in case of not observed
    % However, it doesn't really seems to work for final distribution
    % after training?
    %pD(i).ProbMass
    pD(i).PseudoCount = pseudoCount; % set pseudocount
end

nData = size(emiss, 1);
lData = zeros(1, nData);
obsData = [];
for i = 1 : nData
    data = cell2mat(emiss(i));
    lData(i) = size(data,2); 
    obsData = [obsData, data];
end

%hmm = MakeLeftRightHMM(nStates,pD,obsData,lData);
hmm = MakeErgodicHMM(nStates,[],pD,obsData,lData);

end


%logP=logprob(hmm,x) gives conditional log(probability densities)
%for an observed sequence of (possibly vector-valued) samples,
%for each HMM object in an array of HMM objects.
%This can be used to compare how well HMMs can explain data from an unknown source.
%
%Input:
%hmm=   array of HMM objects
%x=     matrix with a sequence of observed vectors, stored columnwise
%NOTE:  hmm DataSize must be same as observed vector length, i.e.
%       hmm(i).DataSize == size(x,1), for each hmm(i).
%       Otherwise, the probability is, of course, ZERO.
%
%Result:
%logP=  array with log probabilities of the complete observed sequence.
%logP(i)=   log P[x | hmm(i)]
%           size(logP)== size(hmm)
%
%The log representation is useful because the probability densities
%exp(logP) may be extremely small for random vectors with many elements
%
%Method: run the forward algorithm with each hmm on the data.
%
%Ref:   Arne Leijon (20xx): Pattern Recognition.
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

function logP=logprob(hmm,x)
hmmSize=size(hmm);%size of hmm array
T=size(x,2);%number of vector samples in observed sequence
logP=zeros(hmmSize);%space for result
for i=1:numel(hmm)%for all HMM objects
    %Note: array elements can always be accessed as hmm(i),
    %regardless of hmmSize, even with multi-dimensional array.
    %
    %logP(i)= result for hmm(i)
    %continue coding from here, and delete the error message.
    %error('Not yet implemented');
    %i
    if hmm(i).DataSize ~= size(x,1)
        logP(i) = 0;
        return
    end
    
    [pX logS] = prob(hmm(i).OutputDistr, x); %logS=  log scale factor(s)
    %pX = pX .* exp(repmat(logS, size(pX,1), 1));
                % the true probability densitiy: pX= p*exp(logS); Numerically unstable
    [alfaHat, c] = forward(hmm(i).StateGen ,pX);
    
    %%%calculate log probability%%%
    %%% P(x1,x2,...xt) = c1c2...ct
    %%% logP = logc1 + logc2 + ... + logct
    logC = log(c);
    
    %%%return to true prob%%%
    %%% pX= p*exp(logS)
    %%% c_true = c * exp(logS)
    %%% logC_true = logC + logS
    if hmm(i).StateGen.finiteDuration()
        logC(1:end-1) = logC(1:end-1) + logS;
    else
        logC = logC + logS;
    end
    
    logP(i) = sum(logC);
end;
clc
clear

%% 5-fold cross validation
nCharacter = 15;
nfold = 5;
nSample = 40;
nSampleTrain = nSample - nSample/nfold;

nStates = 5;
nFeature = 16;
pseudoCount = 0.5;

sample = randperm(nSample);
indice = reshape(sample, nfold, ceil(nSample / nfold)); 

hmms = cell(nCharacter, nfold);

% train
label_test = [];
data_test = cell(nfold,1);
for i = 1 : nCharacter
    load(['./Data_NonVar_Large/', num2str(i),'.mat']);
    label_test =[ label_test; ones((nSample / nfold), 1) * i];
    for j = 1 : nfold
        % Extract training data
        ind = indice;
        ind(j,:) = [];
        ind = reshape(ind,1, nSampleTrain);
        data_temp = data(ind);
        
        % Extract testing data
        ind_test = indice(j, :);
        data_test{j} = [data_test{j}; data(ind_test)];
        
        
        hmm(i,j) = TrainLeftRightHMM(data_temp , nSampleTrain, nStates, nFeature, pseudoCount );      
    end
end


%%
%test
nTest = size(label_test,1);
result = zeros(nCharacter, nfold);
CM = zeros(nCharacter, nCharacter);
for j = 1 : nfold
    for i = 1 : nTest
        LP = logprob(hmm(:,j), Feature_Exreaction({data_test{j}{i}}));
        predict= find(LP == max(LP));
        if predict == label_test(i)
            result(predict, j) = result(predict, j) + 1;
        else
            disp(['testdata:',num2str(j), ' ',num2str(i),', Predicted:', num2str(predict), ', Truth:', num2str(label_test(i))]);
        end
        CM(label_test(i), predict) = CM(label_test(i), predict) + 1;
    end
end

%% Accuracy
disp(['HMMpure_featureImproved_state',num2str(nStates),'_pseudo',num2str(pseudoCount),'.mat']);
for i = 1:nfold
    disp(['Accuracy Fold ', num2str(i), '= ', num2str(sum(result(:, i))/(nSample/nfold * nCharacter))]);
end
for i = 1:nCharacter
    disp(['Accuracy Character ', num2str(i), '= ', num2str(sum(result(i, :))/(nSample/nfold * nfold))]);
end

acc_avg = sum(diag(CM))/sum(sum(CM));
disp(['Average accuracy = ', num2str(acc_avg)]);
imagesc( CM./nCharacter);
xlabel('Prediction');
ylabel('True label');
title(['Confusion Matrix: State = ', num2str(nStates)]);

saveas(gcf,['./HMM/HMM',num2str(nSample),'_featureImproved_state',num2str(nStates),'_pseudo',num2str(pseudoCount),'.png'],'png');
save(['./HMM/HMM',num2str(nSample),'_featureImproved_state',num2str(nStates),'_pseudo',num2str(pseudoCount),'.mat'],'hmm','CM', 'result');


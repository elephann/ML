function CONF = ApplyBoost(features,thresholds,polarities,alphas,T1,T2)
% assumes feature, threshold, polarity and alpha are column vectors
% of equal size, that is each has t rows and 1 column
% T1 are test samples from class 1, T2 are test samples from class 2
% outputs the confusion matrix CONF

t = size(alphas,1);
C = [T1(:,features);T2(:,features)];

numSamples = size(C,1);

T=repmat(thresholds',numSamples,1);
R = sign((T-C).*repmat(polarities',numSamples,1));
I=find( R == 0);
R(I) = -1;                     %0 means the negative class, class 2

A=repmat(alphas',numSamples,1);

R = R .*A;
R = sign(sum(R,2));
I=find( R == 0);
R(I) = -1;                     %0 means the negative class, class 2


R1 = R(1:size(T1,1),:);
R2 = R(size(T1,1)+1:numSamples,:);

CONF = zeros(2);
CONF(1,2) = size(find(R1 == -1),1);
CONF(2,1) = size(find(R2 == 1),1);
CONF(1,1) = size(find(R1 == 1),1);
CONF(2,2) = size(find(R2 == -1),1);

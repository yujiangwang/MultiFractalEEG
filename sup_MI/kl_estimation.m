function [KLest, Hest, KL_means, H_means, N]=kl_estimation(P, Q, alpha, beta, do_shuffle, number_channels)
% KL_ESTIMATION estimate KL divergence of discrete states sequences.
%
%   [KLEST, HEST] = KL_ESTIMATION(P, Q, ALPHA, BETA, DO_SHUFFLE,
%      NUMBER_CHANNELS) computes an estimation of the KL divergence
%   and negative entropy of the distributions of two sequences of states.
%   The estimation is done using a Bayesian estimator, followed by an
%   extrapolation step to reduce biases in the estimation.
%
%   Parameters:
%   P, Q: sequences of states
%   ALPHA, BETA: paramters of the Dirichlet prior (usually set to 1)
%   DO_SHUFFLE: if set to non-zero value, the data is shuffled before
%   NUMBER_CHANNELS: number of channels in the data
%
%   Output:
%   KLEST: final estimate of KL divergence between P and Q
%   HEST: final estimate of the entropy of P
%   KL_means: mean KL estimates for N/4, N/2, and N; used for extrapolation
%   H_means: mean entropy estimates for N/4, N/2, and N; for extrapolation
%   N: vector with number of points used for extrapolation

% Copyright (c) 2011 Pietro Berkes and Dmitriy Lisitsyn
% License: GPL v3

    parts=[4,2,1];

    N=length(P)./parts;

    KL_results=cell(length(parts),1);
    KL_means=zeros(length(parts),1);
    H_results=cell(length(parts),1);
    H_means=zeros(length(parts),1);
    segment=cell(length(parts),1);

    for part=1:length(parts)
        segment{part}=floor([0 (1:parts(part)).*N(part)]);
    end

    % permute datapoints if requested
    if do_shuffle==1
        elSeq=randperm(length(P));
        P=P(elSeq);
        Q=Q(elSeq);
    end

    for part=1:length(parts)
        for seg=1:parts(part)
            P_seg=P( (segment{part}(seg)+1):(segment{part}(seg+1)) );
            Q_seg=Q( (segment{part}(seg)+1):(segment{part}(seg+1)) );

            % transform state sequences to distributions
            p=states2distribution(P_seg, number_channels);
            q=states2distribution(Q_seg, number_channels);

            % compute mean KL and entropy for this part of the data
            KL_results{part}(seg)=mean_KL_estimate(p+alpha, q+beta);
            H_results{part}(seg)=mean_H_estimate(p+alpha);
        end

        % mean of the means for each data size
        KL_means(part,1)=mean(KL_results{part});
        H_means(part,1)=mean(H_results{part});
    end

    [p,S,mu] = polyfit(N,(N.*N).*KL_means',2);
    KLest=p(1)/(mu(2).^2);
    [p,S,mu] = polyfit(N,(N.*N).*H_means',2);
Hest=p(1)/(mu(2).^2);
function [features_array] = extract_Features( freq )
%% Getting Features for Training (returns an array containing all features)
%%Inputs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
% freq = the (ENF) frequency variation vs time (1 array)
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%

    % Mean
        feature_mean = mean(freq);
    % Variance
        feature_variance = log10(var(freq));  
    % Range
        feature_range= log10(max(freq)-min(freq));
    % Wavelet analysis of the signal
        [coeff,len] = wavedec(freq,9,'db20');
    % Variance of the detailed levels
        Detailed_sig_L1 = detcoef(coeff,len,1);
        feature_detailed_variance_L1 = log10(var(Detailed_sig_L1));
        Detailed_sig_L2 = detcoef(coeff,len,2);
        feature_detailed_variance_L2 = log10(var(Detailed_sig_L2));
        Detailed_sig_L3 = detcoef(coeff,len,3);
        feature_detailed_variance_L3 = log10(var(Detailed_sig_L3));
        Detailed_sig_L4 = detcoef(coeff,len,4);
        feature_detailed_variance_L4 = log10(var(Detailed_sig_L4));
        Detailed_sig_L5 = detcoef(coeff,len,5);
        feature_detailed_variance_L5 = log10(var(Detailed_sig_L5));
        Detailed_sig_L6 = detcoef(coeff,len,6);
        feature_detailed_variance_L6 = log10(var(Detailed_sig_L6));
        Detailed_sig_L7 = detcoef(coeff,len,7);
        feature_detailed_variance_L7 = log10(var(Detailed_sig_L7));
        Detailed_sig_L8 = detcoef(coeff,len,8);
        feature_detailed_variance_L8 = log10(var(Detailed_sig_L8));
        Detailed_sig_L9 = detcoef(coeff,len,9);
        feature_detailed_variance_L9 = log10(var(Detailed_sig_L9));

    % Variance of the approximation
        Approximated_sig=zeros(len(1));
        for ind = 1:len(1)
            Approximated_sig(ind) = coeff(ind);
        end
        feature_approx_variance = log10( var( Approximated_sig(:,1) ) );

%     Computing the AR model 
        model = arima('ARLags',1:2,'Constant',0);
        try
            [~,EstMdl] = evalc('estimate(model,transpose(freq));');
            feature_AR1 = EstMdl.AR{1};
            feature_AR2 = EstMdl.AR{2};
            feature_AR_variance = log10(EstMdl.Variance);
        catch
            disp('------AR Unstable------------');

            feature_AR1 = 0;
            feature_AR2 = 0;
            feature_AR_variance = 0;
        end
        
        % Compute LPC model coeffecients and error

%            model = ar(freq,2);
%            Bfeature_AR1 = model.a(1);
%            Bfeature_AR2 = model.a(2);
%            if(feature_AR1 == Bfeature_AR1)
%                disp('--- 1 is correct ---');
%            end
%            if(feature_AR2 == Bfeature_AR2)
%                disp(' --- 2 is correct ---');
%            end

%         [model,feature_AR_variance] = arburg(freq,2);
%         feature_AR1 = model(1);
%         feature_AR2 = model(2);

%         [model,feature_AR_variance] = arburg(freq,2);
%         feature_AR1 = model(1);
%         feature_AR2 = model(2);

%%Our added features:

    % Median
        feature_median = median(freq);
    % Mode
        feature_mode = mode(freq);
    % Skewness
        feature_skewness = skewness(freq);
    % Kurtosis
        feature_kurtosis = kurtosis(freq);
    % Min
        feature_min = min(freq);
    % Max
        feature_max = max(freq);
   
    % Mean Crossing
        %%%% NOTE: must normalize according to recording length
        N = size(freq, 2);
        M = mean(freq);
        crossing = 0;
        for idx = 1:N-1
            if( ((freq(idx) > M) && (freq(idx+1) < M))  ||  ((freq(idx) < M) && (freq(idx+1) > M)) )
                crossing = crossing + 1;
            end
        end
        feature_mean_crossing = crossing / size(freq,2);
    % Spectral Centroid
        %%%% NOTE: this feature is used for silence removal
        NumCentroid=0;
        DenCentroid=0;
        for idx = 1:N
            NumCentroid = freq(idx) * idx + NumCentroid;
        end
        for idx= 1:N
            DenCentroid = freq(idx) + DenCentroid;
        end
        feature_spectral_centroid = NumCentroid / DenCentroid;
    % Spectral Rolloff
        T = 0.85 * DenCentroid;
        C = 0;
        Rt = 0;
        for idx = 1:N
            C = freq(idx) + C;
            if(C >= T)
                Rt = idx;
                break;
            end
        end
        feature_Rt = Rt;
    % Derivative Max
        Max = 0;
        for idx = 1:N-1
            if( abs( freq(idx+1) - freq(idx) ) > Max )
                Max = freq(idx+1) - freq(idx);
            end
        end
        feature_derivative_max = Max;
    % Outlier Ratio
        count = eps;
        scale_std = 0.3;
        for idx = 1:N
            if( freq(idx) > (feature_mean + scale_std*feature_variance) )
                count = count + 1;
            end
            if( freq(idx) < (feature_mean - scale_std*feature_variance) )
                count = count + 1;
            end
        end
        feature_outlier_ratio = count*2/N;
    % Derivative Crossing
        total_crossings = 0;
        for idx = 1:N-1
            if (idx == 1)
                positive_deriv_new = freq(idx+1) > freq(idx);
            else
                if( freq(idx+1) ~= freq(idx) )
                    positive_deriv_new = freq(idx+1) > freq(idx);
                    if xor(positive_deriv, positive_deriv_new)
                        total_crossings = total_crossings + 1;
                    end
                end
            end
            positive_deriv = positive_deriv_new;
        end
        feature_deriv_crossing = total_crossings / N;
        




% Group all the features in 1 array and return it
features_array = [feature_mean, feature_variance, feature_range, feature_detailed_variance_L1, ...
                  feature_detailed_variance_L2, ...
                  feature_detailed_variance_L3, feature_detailed_variance_L4 ...
                  feature_detailed_variance_L5, feature_detailed_variance_L6, feature_detailed_variance_L7 ...
                  feature_detailed_variance_L8, feature_detailed_variance_L9,... 
                  feature_approx_variance, ...
                  feature_AR1, feature_AR2, feature_AR_variance, ...
                  feature_median, feature_mode, ...
                  feature_skewness, feature_kurtosis,...
                  feature_min, feature_max ...
                  feature_mean_crossing, feature_spectral_centroid, feature_Rt, feature_derivative_max, ...
                  ...
                  feature_outlier_ratio, ...
                  feature_deriv_crossing
                  
                  ];

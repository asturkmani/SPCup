function [result_freq_vs_time] = extract_ENF(Recording, apply_median)
%% Extraction of ENF
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
                Fs = 1000;                   %1kHz
                Time_Step = 5;               %seconds
                Point_Step = Time_Step * Fs; %number of points per section
                Padding_Factor = 8;          %zero padding
                filter_lower_50 = 48;        %Hz
                filter_upper_50 = 52;        %Hz
                filter_lower_60 = 58;        %Hz
                filter_upper_60 = 62;        %Hz
                moving_median_width = 50;    %keep it even for simplicity
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%


% quickly decide if 50Hz or 60Hz to do very narrow filtering later
% take fft over a sample 10 times the size of our step
    mult = 10;
    recording_overall_fft_abs = abs( fft(Recording( 1:Point_Step*mult )) );
% keep the useful half of the symmetric fft
    recording_overall_fft_abs_2 = recording_overall_fft_abs( 1:floor(0.5*size(recording_overall_fft_abs,1)) );
% find the initial guess peak
    [~, quick_peak_guess] = max(recording_overall_fft_abs_2);
    quick_peak_guess = Fs * (quick_peak_guess-1) / (Point_Step*mult);
% decide if 50 or 60
    dist_to_60 = abs( quick_peak_guess - 60 );
    dist_to_50 = abs( quick_peak_guess - 50 );
    if( dist_to_50 < dist_to_60 )
        freq_is_50 = 1;
    else
        freq_is_50 = 0;
    end

% do the STFT and everything else
record_length = size(Recording, 1);
index = 1;
f_count = 1;
while( index + Point_Step - 1 <= record_length )
    % take a section of Point_Step points
    section = Recording(index : index + Point_Step - 1);
    % do zero-padding
    section_padded = zeros( 1, Padding_Factor * size(section,1) );
    section_padded(1:size(section,1)) = section(1:size(section,1));
    % take the fft over that section
    section_fft = fft(section_padded);
    % take the abs of the fft
    section_fft_abs = abs(section_fft);
    % keep the meaningful part of it
    section_fft_abs_2 = section_fft_abs( 1 : floor(0.5*size(section_fft_abs,2)) );
    % filter out frequencies
    scale_pt_to_Hz = size(section_fft, 2) / Fs;
    if(freq_is_50)
        filter_lower = floor(filter_lower_50 * scale_pt_to_Hz);
        filter_upper = ceil(filter_upper_50 * scale_pt_to_Hz);
    else
        filter_lower = floor(filter_lower_60 * scale_pt_to_Hz);
        filter_upper = ceil(filter_upper_60 * scale_pt_to_Hz);
    end
    section_fft_abs_2_filtered = section_fft_abs_2(filter_lower : filter_upper);
    % find the peak in the filtered fft abs, and do quadratic interpolation
    [beta, bin_peak] = max(section_fft_abs_2_filtered);
    if( (bin_peak > 1)  &&  (bin_peak < size(section_fft_abs_2_filtered,2)) )
        alpha = section_fft_abs_2_filtered(bin_peak-1);
        gamma = section_fft_abs_2_filtered(bin_peak+1);
            beta_dB = 20*log10(beta);
            alpha_dB = 20*log10(alpha);
            gamma_dB = 20*log10(gamma);
        p = 0.5 * (alpha_dB - gamma_dB) / (alpha_dB - 2*beta_dB + gamma_dB); %must be between +/-0.5
        interpolated_peak = bin_peak + p;
    else
        interpolated_peak = bin_peak;
    end
    % get the peak in Hz
    final_peak_Hz = (interpolated_peak + filter_lower - 1) / scale_pt_to_Hz;

    % store the peak freq
    freq_vs_time(f_count) = final_peak_Hz;
    f_count = f_count + 1;
    % move to the next section
    index = index + Point_Step;

end

% apply a moving median filter
half_width = moving_median_width/2;
for index = half_width : size(freq_vs_time,2)-half_width
    freq_vs_time_median(index-half_width+1) = median( freq_vs_time( index-half_width+1 : index+half_width ) );
end

% return median reading or not
if( apply_median )
    result_freq_vs_time = freq_vs_time_median;
else
    result_freq_vs_time = freq_vs_time;
end
function [result_freq_vs_time] = extract_ENF(Recording, apply_median, moving_median_width, Fs, Time_Step, ... 
                                            Percent_Overlap, Padding_Factor, filter_half_size, second_peak_perc_thres, use_2_peaks_code)
%% Extraction of ENF (returns an array containing f vs time)
%%Inputs~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
% Recording = the wav signal;
% apply_median = 0/1;
% moving_median_width = 50;     %keep it 'even' not odd for simplicity
% Fs = 1000;                    %1 kHz
% Time_Step = 0.75;             %seconds across which Fourier is taken
% Percent_Overlap = 0.5;        %extent of window overlapping
% Padding_Factor = 8;           %zero padding
% filter_half_size = 1;         % +/- 1Hz to filter around mean
% second_peak_perc_thres = 0.9; %if peak2mag>0.9*peak1mag  for 2peak algo
% use_2_peaks_code = 0/1;       %1 to use new 2peaks algo, 0 for old code
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%

            Point_Step = Time_Step * Fs; %number of points per section


% quickly decide if 50Hz or 60Hz to do very narrow filtering later
% take fft over the Recording
    recording_overall_fft_abs = abs( fft(Recording) );
% keep the useful half of the symmetric fft
    recording_overall_fft_abs_2 = recording_overall_fft_abs( 1:floor(0.5*size(recording_overall_fft_abs,1)) );

for harm = 0:19
    harmonics_of_50(harm+1) = 50 + 50 * harm;
    harmonics_of_60(harm+1) = 60 + 60 * harm;
end
real_peak_found = 0;
while( ~real_peak_found )
    % find the initial guess peak
    [~, quick_peak_guess_original] = max(recording_overall_fft_abs_2);
    quick_peak_guess = Fs * (quick_peak_guess_original-1) / (size(Recording,1));
    % figure out which harmonic is strongest
    for harm_idx = 1:20
        dist_to_harm_50(harm_idx) = abs( quick_peak_guess - harmonics_of_50(harm_idx) );
        dist_to_harm_60(harm_idx) = abs( quick_peak_guess - harmonics_of_60(harm_idx) );
    end
    % decide if 50 or 60
    [min_dist_to_harm_50, actual_harmonic_idx_50] = min( dist_to_harm_50 );
    [min_dist_to_harm_60, actual_harmonic_idx_60] = min( dist_to_harm_60 );

    if( min_dist_to_harm_50 < min_dist_to_harm_60 )
        freq_is_50 = 1;
        actual_harmonic_idx = actual_harmonic_idx_50 - 1;
        min_dist_found = min_dist_to_harm_50;
    else
        freq_is_50 = 0;
        actual_harmonic_idx = actual_harmonic_idx_60 - 1;
        min_dist_found = min_dist_to_harm_60;
    end
    % decide if what we have found is a REAL peak or a fake one
    max_allowed_divergence = filter_half_size* (actual_harmonic_idx+1);
    if min_dist_found > max_allowed_divergence
        recording_overall_fft_abs_2( quick_peak_guess_original ) = 0;
%         disp('fake peak');
    else
        real_peak_found = 1;
    end
end

        filter_lower_50 = quick_peak_guess - filter_half_size* (actual_harmonic_idx+1);        %Hz
        filter_upper_50 = quick_peak_guess + filter_half_size* (actual_harmonic_idx+1);        %Hz
        filter_lower_60 = quick_peak_guess - filter_half_size* (actual_harmonic_idx+1);        %Hz
        filter_upper_60 = quick_peak_guess + filter_half_size* (actual_harmonic_idx+1);        %Hz


% do the STFT and everything else
record_length = size(Recording, 1);
index = 0.5*Point_Step + 1;
f_count = 1;
while( index + 0.5*Point_Step - 1 <= record_length )
    % take a section of Point_Step points
    section(:,1) = Recording(index - 0.5*Point_Step : index + 0.5*Point_Step - 1);
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




    if(use_2_peaks_code)
        % find all local peaks
        [peaks_mag, peaks_idx] = findpeaks(section_fft_abs_2_filtered);

        if( size(peaks_mag,2) > 1)
            % find highest 2 peak magnitudes, to check if meets the second_peak_perc_thres
            [mag_of_peak1, idx_of_peak1_inpeaksidx] = max(peaks_mag);
            peaks_mag(idx_of_peak1_inpeaksidx) = 0;
            idx_of_peak1 = peaks_idx(idx_of_peak1_inpeaksidx);

            [mag_of_peak2, idx_of_peak2_inpeaksidx] = max(peaks_mag);
            idx_of_peak2 = peaks_idx(idx_of_peak2_inpeaksidx);

            %~~~~~~~~~~~~ 1 ~~~~~~~~~~~~%
            % find the peak in the filtered fft abs, and do quadratic interpolation
             %[beta, bin_peak] = max(section_fft_abs_2_filtered);
            beta = mag_of_peak1;
            bin_peak = idx_of_peak1;
            if( (bin_peak > 1)  &&  (bin_peak < size(section_fft_abs_2_filtered,2)) )
                alpha = section_fft_abs_2_filtered(bin_peak-1);
                gamma = section_fft_abs_2_filtered(bin_peak+1);
                    beta_dB = 20*log10(beta);
                    alpha_dB = 20*log10(alpha);
                    gamma_dB = 20*log10(gamma);
                if( (alpha_dB - 2*beta_dB + gamma_dB) ~= 0 ) %avoid rare division by 0
                    p = 0.5 * (alpha_dB - gamma_dB) / (alpha_dB - 2*beta_dB + gamma_dB); %must be between +/-0.5
                    interpolated_peak = bin_peak + p;
                else
                    interpolated_peak = bin_peak;
                end
            else
                interpolated_peak = bin_peak;
            end
            % get the peak in Hz
            final_peak_Hz_1 = (interpolated_peak + filter_lower - 1) / scale_pt_to_Hz;
            %~~~~~~~~~~~~ 2 ~~~~~~~~~~~~%
            beta = mag_of_peak2;
            bin_peak = idx_of_peak2;
            if( (bin_peak > 1)  &&  (bin_peak < size(section_fft_abs_2_filtered,2)) )
                alpha = section_fft_abs_2_filtered(bin_peak-1);
                gamma = section_fft_abs_2_filtered(bin_peak+1);
                    beta_dB = 20*log10(beta);
                    alpha_dB = 20*log10(alpha);
                    gamma_dB = 20*log10(gamma);
                if( (alpha_dB - 2*beta_dB + gamma_dB) ~= 0 ) %avoid rare division by 0
                    p = 0.5 * (alpha_dB - gamma_dB) / (alpha_dB - 2*beta_dB + gamma_dB); %must be between +/-0.5
                    interpolated_peak = bin_peak + p;
                else
                    interpolated_peak = bin_peak;
                end
            else
                interpolated_peak = bin_peak;
            end
            % get the peak in Hz
            final_peak_Hz_2 = (interpolated_peak + filter_lower - 1) / scale_pt_to_Hz;

            %~~~~~~~~~~~~ choosing 1 or 2? ~~~~~~~~~~~~%
            if( f_count == 1 )
                final_peak_Hz = final_peak_Hz_1;
            else
                distance_1_to_prev = abs( final_peak_Hz_1 - freq_vs_time(f_count - 1) );
                distance_2_to_prev = abs( final_peak_Hz_2 - freq_vs_time(f_count - 1) );
                if(  (mag_of_peak2 > (mag_of_peak1*second_peak_perc_thres) ) && ( distance_2_to_prev < distance_1_to_prev ) && (use_2_peaks_code) )
                    final_peak_Hz = final_peak_Hz_2;
                else
                    final_peak_Hz = final_peak_Hz_1;
                end
            end

        else
            % find the peak in the filtered fft abs, and do quadratic interpolation
            [beta, bin_peak] = max(section_fft_abs_2_filtered);
            if( (bin_peak > 1)  &&  (bin_peak < size(section_fft_abs_2_filtered,2)) )
                alpha = section_fft_abs_2_filtered(bin_peak-1);
                gamma = section_fft_abs_2_filtered(bin_peak+1);
                    beta_dB = 20*log10(beta);
                    alpha_dB = 20*log10(alpha);
                    gamma_dB = 20*log10(gamma);
                if( (alpha_dB - 2*beta_dB + gamma_dB) ~= 0 ) %avoid rare division by 0
                    p = 0.5 * (alpha_dB - gamma_dB) / (alpha_dB - 2*beta_dB + gamma_dB); %must be between +/-0.5
                    interpolated_peak = bin_peak + p;
                else
                    interpolated_peak = bin_peak;
                end
            else
                interpolated_peak = bin_peak;
            end
            % get the peak in Hz
            final_peak_Hz = (interpolated_peak + filter_lower - 1) / scale_pt_to_Hz;
        end


    else
        % find the peak in the filtered fft abs, and do quadratic interpolation
        [beta, bin_peak] = max(section_fft_abs_2_filtered);
        if( (bin_peak > 1)  &&  (bin_peak < size(section_fft_abs_2_filtered,2)) )
            alpha = section_fft_abs_2_filtered(bin_peak-1);
            gamma = section_fft_abs_2_filtered(bin_peak+1);
                beta_dB = 20*log10(beta);
                alpha_dB = 20*log10(alpha);
                gamma_dB = 20*log10(gamma);
            if( (alpha_dB - 2*beta_dB + gamma_dB) ~= 0 ) %avoid rare division by 0
                p = 0.5 * (alpha_dB - gamma_dB) / (alpha_dB - 2*beta_dB + gamma_dB); %must be between +/-0.5
                interpolated_peak = bin_peak + p;
            else
                interpolated_peak = bin_peak;
            end
        else
            interpolated_peak = bin_peak;
        end
        % get the peak in Hz
        final_peak_Hz = (interpolated_peak + filter_lower - 1) / scale_pt_to_Hz;
    end
    
    
    % store the peak freq
    freq_vs_time(f_count) = final_peak_Hz;
    f_count = f_count + 1;
    % move to the next section
    index = index + round( (1-Percent_Overlap)*Point_Step );

end




% re-scale frequencies to base harmonic
freq_vs_time = freq_vs_time ./ (actual_harmonic_idx+1);


% return median reading or not
if( apply_median )

    % apply a moving median filter
    half_width = moving_median_width/2;
    % pad zeros left and right
    zero_pads = zeros(1, half_width-1);
    freq_vs_time = [ zero_pads freq_vs_time zero_pads ];
    for index = half_width : size(freq_vs_time,2)-half_width
        freq_vs_time_median(index-half_width+1) = median( freq_vs_time( index-half_width+1 : index+half_width ) );
    end

    if size(freq_vs_time_median,2) > 5
        result_freq_vs_time = freq_vs_time_median;
    else
        result_freq_vs_time = freq_vs_time;
        disp('check extract_ENF median window');
    end

else
    result_freq_vs_time = freq_vs_time;
end
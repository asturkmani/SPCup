% REQUIRES SETTING THESE: 
% set_of_ensemble_guesses (the 20 guesses from ensemble)
% power_or_audio_or_general:   0 if power
%                              1 if audio
%                              2 if general
% SETS THIS:
% FINAL_GUESS_TEMP which is the final guess


total_number_of_guesses = size(set_of_ensemble_guesses, 2);

% Find the most frequent entry:
most_frequent_guess = mode( set_of_ensemble_guesses );

%check if all classifiers agree
occurancesofmode = sum( set_of_ensemble_guesses == most_frequent_guess );
if( occurancesofmode == total_number_of_guesses )

    FINAL_GUESS_TEMP = most_frequent_guess;

else
    









end
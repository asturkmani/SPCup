%% Read all training data

% Grid A
    % Power:
    [Power_Recording_A1, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P1.wav');
    [Power_Recording_A2, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P2.wav');
    [Power_Recording_A3, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P3.wav');
    [Power_Recording_A4, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P4.wav');
    [Power_Recording_A5, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P5.wav');
    [Power_Recording_A6, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P6.wav');
    [Power_Recording_A7, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P7.wav');
    [Power_Recording_A8, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P8.wav');
    [Power_Recording_A9, ~] = audioread('Grid_A/Power_recordings/Train_Grid_A_P9.wav');
    
    Power_Recording_A1A = Power_Recording_A1(1:180000);
    Power_Recording_A1B = Power_Recording_A1(90001:180000);
    Power_Recording_A2A = Power_Recording_A2(1:90000);
    Power_Recording_A2B = Power_Recording_A2(90001:180000);
    Power_Recording_A3A = Power_Recording_A3(1:180000);     
    Power_Recording_A3B = Power_Recording_A3(180001:360000);
    Power_Recording_A4A = Power_Recording_A4(1:60000);     
    Power_Recording_A4B = Power_Recording_A4(60001:120000);
    Power_Recording_A5A = Power_Recording_A5(1:180000);     
    Power_Recording_A5B = Power_Recording_A5(180001:360000);
    Power_Recording_A6A = Power_Recording_A6(1:60000);     
    Power_Recording_A6B = Power_Recording_A6(60001:120000);
    Power_Recording_A7A = Power_Recording_A7(1:180000);     
    Power_Recording_A7B = Power_Recording_A7(180001:360000);
    Power_Recording_A8A = Power_Recording_A8(1:90000);     
    Power_Recording_A8B = Power_Recording_A8(90001:180000);
    Power_Recording_A9A = Power_Recording_A9(1:90000);     
    Power_Recording_A9B = Power_Recording_A9(90001:180000);
    
    % Audio:
    [Audio_Recording_A1, ~] = audioread('Grid_A/Audio_recordings/Train_Grid_A_A1.wav');
    [Audio_Recording_A2, ~] = audioread('Grid_A/Audio_recordings/Train_Grid_A_A2.wav');
    Audio_Recording_A1A = Audio_Recording_A1(1:90000);     
    Audio_Recording_A1B = Audio_Recording_A1(90001:180000);
    Audio_Recording_A2A = Audio_Recording_A2(1:90000);     
    Audio_Recording_A2B = Audio_Recording_A2(90001:180000);

% Grid B
    % Power:
    [Power_Recording_B1, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P1.wav');
    [Power_Recording_B2, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P2.wav');
    [Power_Recording_B3, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P3.wav');
    [Power_Recording_B4, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P4.wav');
    [Power_Recording_B5, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P5.wav');
    [Power_Recording_B6, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P6.wav');
    [Power_Recording_B7, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P7.wav');
    [Power_Recording_B8, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P8.wav');
    [Power_Recording_B9, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P9.wav');
    [Power_Recording_B10, ~] = audioread('Grid_B/Power_recordings/Train_Grid_B_P10.wav');
    
    Power_Recording_B1A = Power_Recording_B1(1:180000);
    Power_Recording_B1B = Power_Recording_B1(90001:180000);
    Power_Recording_B2A = Power_Recording_B2(1:90000);
    Power_Recording_B2B = Power_Recording_B2(90001:180000);
    Power_Recording_B3A = Power_Recording_B3(1:180000);     
    Power_Recording_B3B = Power_Recording_B3(180001:360000);
    Power_Recording_B4A = Power_Recording_B4(1:60000);     
    Power_Recording_B4B = Power_Recording_B4(60001:120000);
    Power_Recording_B5A = Power_Recording_B5(1:180000);     
    Power_Recording_B5B = Power_Recording_B5(180001:360000);
    Power_Recording_B6A = Power_Recording_B6(1:60000);     
    Power_Recording_B6B = Power_Recording_B6(60001:120000);
    Power_Recording_B7A = Power_Recording_B7(1:180000);     
    Power_Recording_B7B = Power_Recording_B7(180001:360000);
    Power_Recording_B8A = Power_Recording_B8(1:90000);     
    Power_Recording_B8B = Power_Recording_B8(90001:180000);
    Power_Recording_B9A = Power_Recording_B9(1:90000);     
    Power_Recording_B9B = Power_Recording_B9(90001:180000);
    Power_Recording_B10A = Power_Recording_B10(1:90000);     
    Power_Recording_B10B = Power_Recording_B10(90001:180000);
    
    % Audio:
    [Audio_Recording_B1, ~] = audioread('Grid_B/Audio_recordings/Train_Grid_B_A1.wav');
    [Audio_Recording_B2, ~] = audioread('Grid_B/Audio_recordings/Train_Grid_B_A2.wav');
    
    Audio_Recording_B1A = Audio_Recording_B1(1:90000);     
    Audio_Recording_B1B = Audio_Recording_B1(90001:180000);
    Audio_Recording_B2A = Audio_Recording_B2(1:90000);     
    Audio_Recording_B2B = Audio_Recording_B2(90001:180000);

% Grid C
    % Power:
    [Power_Recording_C1, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P1.wav');
    [Power_Recording_C2, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P2.wav');
    [Power_Recording_C3, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P3.wav');
    [Power_Recording_C4, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P4.wav');
    [Power_Recording_C5, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P5.wav');
    [Power_Recording_C6, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P6.wav');
    [Power_Recording_C7, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P7.wav');
    [Power_Recording_C8, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P8.wav');
    [Power_Recording_C9, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P9.wav');
    [Power_Recording_C10, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P10.wav');
    [Power_Recording_C11, ~] = audioread('Grid_C/Power_recordings/Train_Grid_C_P11.wav');
    
    Power_Recording_C1A = Power_Recording_C1(1:180000);
    Power_Recording_C1B = Power_Recording_C1(90001:180000);
    Power_Recording_C2A = Power_Recording_C2(1:90000);
    Power_Recording_C2B = Power_Recording_C2(90001:180000);
    Power_Recording_C3A = Power_Recording_C3(1:180000);     
    Power_Recording_C3B = Power_Recording_C3(180001:360000);
    Power_Recording_C4A = Power_Recording_C4(1:60000);     
    Power_Recording_C4B = Power_Recording_C4(60001:120000);
    Power_Recording_C5A = Power_Recording_C5(1:180000);     
    Power_Recording_C5B = Power_Recording_C5(180001:360000);
    Power_Recording_C6A = Power_Recording_C6(1:60000);     
    Power_Recording_C6B = Power_Recording_C6(60001:120000);
    Power_Recording_C7A = Power_Recording_C7(1:180000);     
    Power_Recording_C7B = Power_Recording_C7(180001:360000);
    Power_Recording_C8A = Power_Recording_C8(1:90000);     
    Power_Recording_C8B = Power_Recording_C8(90001:180000);
    Power_Recording_C9A = Power_Recording_C9(1:90000);     
    Power_Recording_C9B = Power_Recording_C9(90001:180000);
    Power_Recording_C10A = Power_Recording_C10(1:90000);     
    Power_Recording_C10B = Power_Recording_C10(90001:180000);
    Power_Recording_C11A = Power_Recording_C11(1:90000);     
    Power_Recording_C11B = Power_Recording_C11(90001:180000);
    
    % Audio:
    [Audio_Recording_C1, ~] = audioread('Grid_C/Audio_recordings/Train_Grid_C_A1.wav');
    [Audio_Recording_C2, ~] = audioread('Grid_C/Audio_recordings/Train_Grid_C_A2.wav');

    Audio_Recording_C1A = Audio_Recording_C1(1:90000);     
    Audio_Recording_C1B = Audio_Recording_C1(90001:180000);
    Audio_Recording_C2A = Audio_Recording_C2(1:90000);     
    Audio_Recording_C2B = Audio_Recording_C2(90001:180000);

% Grid D
    % Power:
    [Power_Recording_D1, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P1.wav');
    [Power_Recording_D2, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P2.wav');
    [Power_Recording_D3, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P3.wav');
    [Power_Recording_D4, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P4.wav');
    [Power_Recording_D5, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P5.wav');
    [Power_Recording_D6, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P6.wav');
    [Power_Recording_D7, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P7.wav');
    [Power_Recording_D8, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P8.wav');
    [Power_Recording_D9, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P9.wav');
    [Power_Recording_D10, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P10.wav');
    [Power_Recording_D11, ~] = audioread('Grid_D/Power_recordings/Train_Grid_D_P11.wav');
    
    Power_Recording_D1A = Power_Recording_D1(1:180000);
    Power_Recording_D1B = Power_Recording_D1(90001:180000);
    Power_Recording_D2A = Power_Recording_D2(1:90000);
    Power_Recording_D2B = Power_Recording_D2(90001:180000);
    Power_Recording_D3A = Power_Recording_D3(1:180000);     
    Power_Recording_D3B = Power_Recording_D3(180001:360000);
    Power_Recording_D4A = Power_Recording_D4(1:60000);     
    Power_Recording_D4B = Power_Recording_D4(60001:120000);
    Power_Recording_D5A = Power_Recording_D5(1:180000);     
    Power_Recording_D5B = Power_Recording_D5(180001:360000);
    Power_Recording_D6A = Power_Recording_D6(1:60000);     
    Power_Recording_D6B = Power_Recording_D6(60001:120000);
    Power_Recording_D7A = Power_Recording_D7(1:180000);     
    Power_Recording_D7B = Power_Recording_D7(180001:360000);
    Power_Recording_D8A = Power_Recording_D8(1:90000);     
    Power_Recording_D8B = Power_Recording_D8(90001:180000);
    Power_Recording_D9A = Power_Recording_D9(1:90000);     
    Power_Recording_D9B = Power_Recording_D9(90001:180000);
    Power_Recording_D10A = Power_Recording_D10(1:90000);     
    Power_Recording_D10B = Power_Recording_D10(90001:180000);
    Power_Recording_D11A = Power_Recording_D11(1:90000);     
    Power_Recording_D11B = Power_Recording_D11(90001:180000);
    
    % Audio:
    [Audio_Recording_D1, ~] = audioread('Grid_D/Audio_recordings/Train_Grid_D_A1.wav');
    [Audio_Recording_D2, ~] = audioread('Grid_D/Audio_recordings/Train_Grid_D_A2.wav');

    Audio_Recording_D1A = Audio_Recording_D1(1:90000);     
    Audio_Recording_D1B = Audio_Recording_D1(90001:180000);
    Audio_Recording_D2A = Audio_Recording_D2(1:90000);     
    Audio_Recording_D2B = Audio_Recording_D2(90001:180000);

% Grid E
    % Power:
    [Power_Recording_E1, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P1.wav');
    [Power_Recording_E2, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P2.wav');
    [Power_Recording_E3, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P3.wav');
    [Power_Recording_E4, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P4.wav');
    [Power_Recording_E5, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P5.wav');
    [Power_Recording_E6, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P6.wav');
    [Power_Recording_E7, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P7.wav');
    [Power_Recording_E8, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P8.wav');
    [Power_Recording_E9, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P9.wav');
    [Power_Recording_E10, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P10.wav');
    [Power_Recording_E11, ~] = audioread('Grid_E/Power_recordings/Train_Grid_E_P11.wav');
    
    Power_Recording_E1A = Power_Recording_E1(1:180000);
    Power_Recording_E1B = Power_Recording_E1(90001:180000);
    Power_Recording_E2A = Power_Recording_E2(1:90000);
    Power_Recording_E2B = Power_Recording_E2(90001:180000);
    Power_Recording_E3A = Power_Recording_E3(1:180000);     
    Power_Recording_E3B = Power_Recording_E3(180001:360000);
    Power_Recording_E4A = Power_Recording_E4(1:60000);     
    Power_Recording_E4B = Power_Recording_E4(60001:120000);
    Power_Recording_E5A = Power_Recording_E5(1:180000);     
    Power_Recording_E5B = Power_Recording_E5(180001:360000);
    Power_Recording_E6A = Power_Recording_E6(1:60000);     
    Power_Recording_E6B = Power_Recording_E6(60001:120000);
    Power_Recording_E7A = Power_Recording_E7(1:180000);     
    Power_Recording_E7B = Power_Recording_E7(180001:360000);
    Power_Recording_E8A = Power_Recording_E8(1:90000);     
    Power_Recording_E8B = Power_Recording_E8(90001:180000);
    Power_Recording_E9A = Power_Recording_E9(1:90000);     
    Power_Recording_E9B = Power_Recording_E9(90001:180000);
    Power_Recording_E10A = Power_Recording_E10(1:90000);     
    Power_Recording_E10B = Power_Recording_E10(90001:180000);
    Power_Recording_E11A = Power_Recording_E11(1:90000);     
    Power_Recording_E11B = Power_Recording_E11(90001:180000);
    
    % Audio:
    [Audio_Recording_E1, ~] = audioread('Grid_E/Audio_recordings/Train_Grid_E_A1.wav');
    [Audio_Recording_E2, ~] = audioread('Grid_E/Audio_recordings/Train_Grid_E_A2.wav');

    Audio_Recording_E1A = Audio_Recording_E1(1:90000);     
    Audio_Recording_E1B = Audio_Recording_E1(90001:180000);
    Audio_Recording_E2A = Audio_Recording_E2(1:90000);     
    Audio_Recording_E2B = Audio_Recording_E2(90001:180000);

% Grid F
    % Power:
    [Power_Recording_F1, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P1.wav');
    [Power_Recording_F2, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P2.wav');
    [Power_Recording_F3, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P3.wav');
    [Power_Recording_F4, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P4.wav');
    [Power_Recording_F5, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P5.wav');
    [Power_Recording_F6, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P6.wav');
    [Power_Recording_F7, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P7.wav');
    [Power_Recording_F8, ~] = audioread('Grid_F/Power_recordings/Train_Grid_F_P8.wav');
    
    Power_Recording_F1A = Power_Recording_F1(1:180000);
    Power_Recording_F1B = Power_Recording_F1(90001:180000);
    Power_Recording_F2A = Power_Recording_F2(1:90000);
    Power_Recording_F2B = Power_Recording_F2(90001:180000);
    Power_Recording_F3A = Power_Recording_F3(1:180000);     
    Power_Recording_F3B = Power_Recording_F3(180001:360000);
    Power_Recording_F4A = Power_Recording_F4(1:60000);     
    Power_Recording_F4B = Power_Recording_F4(60001:120000);
    Power_Recording_F5A = Power_Recording_F5(1:180000);     
    Power_Recording_F5B = Power_Recording_F5(180001:360000);
    Power_Recording_F6A = Power_Recording_F6(1:60000);     
    Power_Recording_F6B = Power_Recording_F6(60001:120000);
    Power_Recording_F7A = Power_Recording_F7(1:180000);     
    Power_Recording_F7B = Power_Recording_F7(180001:360000);
    Power_Recording_F8A = Power_Recording_F8(1:90000);     
    Power_Recording_F8B = Power_Recording_F8(90001:180000);
    
    % Audio:
    [Audio_Recording_F1, ~] = audioread('Grid_F/Audio_recordings/Train_Grid_F_A1.wav');
    [Audio_Recording_F2, ~] = audioread('Grid_F/Audio_recordings/Train_Grid_F_A2.wav');

    Audio_Recording_F1A = Audio_Recording_F1(1:90000);     
    Audio_Recording_F1B = Audio_Recording_F1(90001:180000);
    Audio_Recording_F2A = Audio_Recording_F2(1:90000);     
    Audio_Recording_F2B = Audio_Recording_F2(90001:180000);

% Grid G 
 % Power:
    [Power_Recording_G1, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P1.wav');
    [Power_Recording_G2, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P2.wav');
    [Power_Recording_G3, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P3.wav');
    [Power_Recording_G4, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P4.wav');
    [Power_Recording_G5, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P5.wav');
    [Power_Recording_G6, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P6.wav');
    [Power_Recording_G7, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P7.wav');
    [Power_Recording_G8, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P8.wav');
    [Power_Recording_G9, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P9.wav');
    [Power_Recording_G10, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P10.wav');
    [Power_Recording_G11, ~] = audioread('Grid_G/Power_recordings/Train_Grid_G_P11.wav');
    
    Power_Recording_G1A = Power_Recording_G1(1:180000);
    Power_Recording_G1B = Power_Recording_G1(90001:180000);
    Power_Recording_G2A = Power_Recording_G2(1:90000);
    Power_Recording_G2B = Power_Recording_G2(90001:180000);
    Power_Recording_G3A = Power_Recording_G3(1:180000);     
    Power_Recording_G3B = Power_Recording_G3(180001:360000);
    Power_Recording_G4A = Power_Recording_G4(1:60000);     
    Power_Recording_G4B = Power_Recording_G4(60001:120000);
    Power_Recording_G5A = Power_Recording_G5(1:180000);     
    Power_Recording_G5B = Power_Recording_G5(180001:360000);
    Power_Recording_G6A = Power_Recording_G6(1:60000);     
    Power_Recording_G6B = Power_Recording_G6(60001:120000);
    Power_Recording_G7A = Power_Recording_G7(1:180000);     
    Power_Recording_G7B = Power_Recording_G7(180001:360000);
    Power_Recording_G8A = Power_Recording_G8(1:90000);     
    Power_Recording_G8B = Power_Recording_G8(90001:180000);
    Power_Recording_G9A = Power_Recording_G9(1:90000);     
    Power_Recording_G9B = Power_Recording_G9(90001:180000);
    Power_Recording_G10A = Power_Recording_G10(1:90000);     
    Power_Recording_G10B = Power_Recording_G10(90001:180000);
    Power_Recording_G11A = Power_Recording_G11(1:90000);     
    Power_Recording_G11B = Power_Recording_G11(90001:180000);
    
    % Audio:
    [Audio_Recording_G1, ~] = audioread('Grid_G/Audio_recordings/Train_Grid_G_A1.wav');
    [Audio_Recording_G2, ~] = audioread('Grid_G/Audio_recordings/Train_Grid_G_A2.wav');

    Audio_Recording_G1A = Audio_Recording_G1(1:90000);     
    Audio_Recording_G1B = Audio_Recording_G1(90001:180000);
    Audio_Recording_G2A = Audio_Recording_G2(1:90000);     
    Audio_Recording_G2B = Audio_Recording_G2(90001:180000);
    
% Grid H
 % Power:
    [Power_Recording_H1, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P1.wav');
    [Power_Recording_H2, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P2.wav');
    [Power_Recording_H3, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P3.wav');
    [Power_Recording_H4, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P4.wav');
    [Power_Recording_H5, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P5.wav');
    [Power_Recording_H6, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P6.wav');
    [Power_Recording_H7, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P7.wav');
    [Power_Recording_H8, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P8.wav');
    [Power_Recording_H9, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P9.wav');
    [Power_Recording_H10, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P10.wav');
    [Power_Recording_H11, ~] = audioread('Grid_H/Power_recordings/Train_Grid_H_P11.wav');
    
    Power_Recording_H1A = Power_Recording_H1(1:180000);
    Power_Recording_H1B = Power_Recording_H1(90001:180000);
    Power_Recording_H2A = Power_Recording_H2(1:90000);
    Power_Recording_H2B = Power_Recording_H2(90001:180000);
    Power_Recording_H3A = Power_Recording_H3(1:180000);     
    Power_Recording_H3B = Power_Recording_H3(180001:360000);
    Power_Recording_H4A = Power_Recording_H4(1:60000);     
    Power_Recording_H4B = Power_Recording_H4(60001:120000);
    Power_Recording_H5A = Power_Recording_H5(1:180000);     
    Power_Recording_H5B = Power_Recording_H5(180001:360000);
    Power_Recording_H6A = Power_Recording_H6(1:60000);     
    Power_Recording_H6B = Power_Recording_H6(60001:120000);
    Power_Recording_H7A = Power_Recording_H7(1:180000);     
    Power_Recording_H7B = Power_Recording_H7(180001:360000);
    Power_Recording_H8A = Power_Recording_H8(1:90000);     
    Power_Recording_H8B = Power_Recording_H8(90001:180000);
    Power_Recording_H9A = Power_Recording_H9(1:90000);     
    Power_Recording_H9B = Power_Recording_H9(90001:180000);
    Power_Recording_H10A = Power_Recording_H10(1:90000);     
    Power_Recording_H10B = Power_Recording_H10(90001:180000);
    Power_Recording_H11A = Power_Recording_H11(1:90000);     
    Power_Recording_H11B = Power_Recording_H11(90001:180000);
    
    % Audio:
    [Audio_Recording_H1, ~] = audioread('Grid_H/Audio_recordings/Train_Grid_H_A1.wav');
    [Audio_Recording_H2, ~] = audioread('Grid_H/Audio_recordings/Train_Grid_H_A2.wav');    

    Audio_Recording_H1A = Audio_Recording_H1(1:90000);     
    Audio_Recording_H1B = Audio_Recording_H1(90001:180000);
    Audio_Recording_H2A = Audio_Recording_H2(1:90000);     
    Audio_Recording_H2B = Audio_Recording_H2(90001:180000);

% Grid I
 % Power:
    [Power_Recording_I1, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P1.wav');
    [Power_Recording_I2, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P2.wav');
    [Power_Recording_I3, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P3.wav');
    [Power_Recording_I4, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P4.wav');
    [Power_Recording_I5, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P5.wav');
    [Power_Recording_I6, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P6.wav');
    [Power_Recording_I7, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P7.wav');
    [Power_Recording_I8, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P8.wav');
    [Power_Recording_I9, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P9.wav');
    [Power_Recording_I10, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P10.wav');
    [Power_Recording_I11, ~] = audioread('Grid_I/Power_recordings/Train_Grid_I_P11.wav');
    
    Power_Recording_I1A = Power_Recording_I1(1:180000);
    Power_Recording_I1B = Power_Recording_I1(90001:180000);
    Power_Recording_I2A = Power_Recording_I2(1:90000);
    Power_Recording_I2B = Power_Recording_I2(90001:180000);
    Power_Recording_I3A = Power_Recording_I3(1:180000);     
    Power_Recording_I3B = Power_Recording_I3(180001:360000);
    Power_Recording_I4A = Power_Recording_I4(1:60000);     
    Power_Recording_I4B = Power_Recording_I4(60001:120000);
    Power_Recording_I5A = Power_Recording_I5(1:180000);     
    Power_Recording_I5B = Power_Recording_I5(180001:360000);
    Power_Recording_I6A = Power_Recording_I6(1:60000);     
    Power_Recording_I6B = Power_Recording_I6(60001:120000);
    Power_Recording_I7A = Power_Recording_I7(1:180000);     
    Power_Recording_I7B = Power_Recording_I7(180001:360000);
    Power_Recording_I8A = Power_Recording_I8(1:90000);     
    Power_Recording_I8B = Power_Recording_I8(90001:180000);
    Power_Recording_I9A = Power_Recording_I9(1:90000);     
    Power_Recording_I9B = Power_Recording_I9(90001:180000);
    Power_Recording_I10A = Power_Recording_I10(1:90000);     
    Power_Recording_I10B = Power_Recording_I10(90001:180000);
    Power_Recording_I11A = Power_Recording_I11(1:90000);     
    Power_Recording_I11B = Power_Recording_I11(90001:180000);
    
    % Audio:
    [Audio_Recording_I1, ~] = audioread('Grid_I/Audio_recordings/Train_Grid_I_A1.wav');
    [Audio_Recording_I2, Fs] = audioread('Grid_I/Audio_recordings/Train_Grid_I_A2.wav');    

    Audio_Recording_I1A = Audio_Recording_I1(1:90000);     
    Audio_Recording_I1B = Audio_Recording_I1(90001:180000);
    Audio_Recording_I2A = Audio_Recording_I2(1:90000);     
    Audio_Recording_I2B = Audio_Recording_I2(90001:180000);

disp('Done Reading');



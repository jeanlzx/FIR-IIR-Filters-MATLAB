% This code is for IIR filter design
% Press CTRL + Shift + R to uncomment the section of code for playback

[ori_audio,fs] = audioread('Someone Like You Original.wav'); % Extract original audio
Fs = 44100; % Define new sampling rate
audio = resample(ori_audio, Fs, fs); % Resample the audio
N = length(audio); % Length of signal equivalent to 14.4M data points
t = (0:N-1)/Fs; % Time vector of the signal

% Add white Gaussian noise
SNR = 25; % Signal-to-Noise Ratio in dB
noisy = awgn(audio, SNR, 'measured');

% Define IIR filter parameters
Fc = 1650; % cutoff freq
Fc_normal = Fc/(Fs/2); % Normalised cut off freq
IIR_order = 4;

% Butterworth Filter
    [b_butter, a_butter] = butter(IIR_order, Fc_normal, 'low');
    
    % Plot magnitude and phase response
    figure(1);
    freqz(b_butter, a_butter, [], Fs)
    ylim([-200, 5]);
    
    % Apply Butterworth filter to noisy audio
    butterfilter = filter(b_butter, a_butter, noisy)
    
    % Plot Butterworth Filtered Frequency Spectrum
    Axk_butter = 2*abs(fft(butterfilter))/N;
    Axk_butter(1) = Axk_butter(1)/2;
    freq = [0:1:N/2]*Fs/N;
    figure(2), plot(freq/1000, Axk_butter(1:N/2+1)), title('One-Sided Amplitude Spectrum (Lowpass Butterworth)');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % % Play a portion of audio
    % start_sample = 1000;
    % end_sample = 500500;
    % portion_to_play = butterfilter(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% Chebyshev Filter
    [b_cheby, a_cheby] = cheby1(IIR_order, 0.5, Fc_normal, 'low');
    
    % Plot magnitude and phase response
    figure(3);
    freqz(b_cheby, a_cheby, [], Fs)
    ylim([-200, 5]);
    
    % Apply Chebyshev filter to noisy audio
    chebyfilter = filter(b_cheby, a_cheby, noisy)
    
    % Plot Chebyshev Filtered Frequency Spectrum
    Axk_cheby = 2*abs(fft(chebyfilter))/N;
    Axk_cheby(1) = Axk_cheby(1)/2;
    freq = [0:1:N/2]*Fs/N;
    figure(4), plot(freq/1000, Axk_cheby(1:N/2+1)), title('One-Sided Amplitude Spectrum (Lowpass Chebyshev)');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % % Play a portion of audio
    % start_sample = 1000;
    % end_sample = 500500;
    % portion_to_play = chebyfilter(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% filename = 'C:\Users\jean\OneDrive\Documents\Year 3 Semester 2\Digital Signal Processing\MATLAB\IIR Butterworth Filtered Audio.wav';
% audiowrite(filename,butterfilter,Fs);
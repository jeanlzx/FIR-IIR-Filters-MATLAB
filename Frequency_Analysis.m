% This code is for frequeuncy spectrum analysis of clear and noisy audio

[ori_audio,fs] = audioread('Original Audio (Clear).wav'); % Extract original audio
Fs = 44100; % Define new sampling rate
audio = resample(ori_audio, Fs, fs); % Resample the audio
N = length(audio); % Length of signal equivalent to 14.4M data points
t = (0:N-1)/Fs; % Time vector of the signal

% Original audio signal analysis
    % Plot the original audio signal in time-domain
    figure, plot(t, audio), title('Original Audio Signal');
    xlabel('Time (s)'), ylabel('Amplitude'), grid;
    
    % Analyze frequency spectrum
    X_k = abs(fft(audio)); % Apply DFT algorithm
    Axk = X_k/N; % Compute the amplitude spectrum
    freq = [0:N-1]*Fs/N; % Frequency for all frequency bins
    figure, plot(freq/1000, Axk), title('Original Amplitude Spectrum');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % Single-sided spectrum
    Axk_ss = 2*X_k/N; % Calculate the single-sided spectrum
    Axk_ss(1) = Axk_ss(1)/2; % DC component
    freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    figure, plot(freq/1000, Axk_ss(1:N/2+1)), title('Original One-Sided Amplitude Spectrum');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

% Add white Gaussian noise
    SNR = 25; % Signal-to-Noise Ratio in dB
    noisy = awgn(audio, SNR, 'measured');

% Noisy audio signal analysis
    % Plot the noisy audio signal in time-domain
    figure, plot(t, noisy), title('Noisy Audio Signal');
    xlabel('Time (s)'), ylabel('Amplitude'), grid;
    
    % Analyze frequency spectrum 
    X_k = abs(fft(noisy)); % Apply DFT algorithm
    Axk = X_k/N; % Compute the amplitude spectrum
    freq = [0:N-1]*Fs/N; % Frequency for all frequency bins
    figure, plot(freq/1000, Axk), title('Noisy Amplitude Spectrum');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % Single-sided spectrum
    Axk_ss = 2*X_k/N; % Calculate the single-sided spectrum
    Axk_ss(1) = Axk_ss(1)/2; % DC component
    freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    figure, plot(freq/1000, Axk_ss(1:N/2+1)), title('Noisy One-Sided Amplitude Spectrum');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % Close-up single-sided spectrum analysis
    freq_range = 1:N/10;
    figure, plot(freq(freq_range)/1000, Axk_ss(freq_range)), title('Noisy One-Sided Amplitude Spectrum (Closeup analysis)');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;
    xticks(min(freq(freq_range))/1000:0.2:max(freq(freq_range))/1000);

% Export the noisy audio
    % filename = 'C:\Users\jean\OneDrive\Documents\Year 3 Semester 2\Digital Signal Processing\MATLAB\Original Audio with Noise.wav';
    % audiowrite(filename,noisy,Fs); % Export the noisy audio

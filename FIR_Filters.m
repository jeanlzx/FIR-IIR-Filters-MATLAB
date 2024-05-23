% This code is for FIR Filter Design
% Press CTRL + Shift + R to uncomment selected code for each filter
% Press CRTL + R to comment a highlighted section of code

[ori_audio,fs] = audioread('Original Audio (Clear).wav'); % Extract original audio
Fs = 44100; % Define new sampling rate
audio = resample(ori_audio, Fs, fs); % Resample the audio
N = length(audio); % Length of signal equivalent to 14.4M data points
t = (0:N-1)/Fs; % Time vector of the signal

% Add white Gaussian noise
SNR = 25; % Signal-to-Noise Ratio in dB
noisy = awgn(audio, SNR, 'measured');

% Define filter parameters
Fc = 1650;
Fc_normal = Fc/(Fs/2);

% 1. Rectangular window
    % b_rec = fir1(40, Fc_normal, 'low', rectwin(41));
    % figure, freqz(b_rec,1,[],Fs); % Plot magnitude & phase response
    % 
    % % Apply FIR Rectangular window filter to audio
    % audio_rec = filter(b_rec, 1, noisy);
    % 
    % % Analyse frequency spectrum of filtered audio
    % Axk_rec = 2*abs(fft(audio_rec))/N;
    % Axk_rec(1) = Axk_rec(1)/2;
    % freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    % figure, plot(freq/1000, Axk_rec(1:N/2+1)), title('One-Sided Amplitude Spectrum (FIR Rectangular Window)');
    % xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;
    % 
    % % Play a portion of the audio (rectangular)
    % start_sample = 1000;
    % end_sample = 500500;
    % portion_to_play = audio_rec(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% 2. Hanning window
    % b_hann = fir1(136, Fc_normal, 'low', hann(137));
    % figure, freqz(b_hann,1,[],Fs); % Plot magnitude & phase response
    % 
    % % Apply FIR Hanning window filter to audio
    % audio_hann = filter(b_hann, 1, noisy);
    % 
    % % Analyse frequency spectrum of filtered audio
    % Axk_hann = 2*abs(fft(audio_hann))/N;
    % Axk_hann(1) = Axk_hann(1)/2;
    % freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    % figure, plot(freq/1000, Axk_hann(1:N/2+1)), title('One-Sided Amplitude Spectrum (FIR Hanning Window)');
    % xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;
    % 
    % % Play a portion of the audio (hanning)
    % start_sample = 1000
    % end_sample = 500500;
    % portion_to_play = audio_hann(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% 3. Hamming window
    % b_hamm = fir1(144, Fc_normal, 'low', hamming(145));
    % figure, freqz(b_hamm,1,[],Fs); % Plot magnitude & phase response
    % 
    % % Apply FIR Hamming window filter to audio
    % audio_hamming = filter(b_hamm, 1, noisy);
    % 
    % % Analyse frequency spectrum of filtered audio
    % Axk_hamming = 2*abs(fft(audio_hamming))/N;
    % Axk_hamming(1) = Axk_hamming(1)/2;
    % freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    % figure, plot(freq/1000, Axk_hamming(1:N/2+1)), title('One-Sided Amplitude Spectrum (FIR Hamming Window)');
    % xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;
    % 
    % % Play a portion of the audio (hamming)
    % start_sample = 1000
    % end_sample = 500500;
    % portion_to_play = audio_hamming(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% 4. Blackman window
    % b_black = fir1(242, Fc_normal, 'low', blackman(243));
    % figure, freqz(b_black,1,[],Fs); % Plot magnitude & phase response
    % 
    % % Apply FIR Blackman window filter to audio
    % audio_blackman = filter(b_black, 1, noisy);
    % 
    % % Analyse frequency spectrum of filtered audio
    % Axk_black = 2*abs(fft(audio_blackman))/N;
    % Axk_black(1) = Axk_black(1)/2;
    % freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    % figure, plot(freq/1000, Axk_black(1:N/2+1)), title('One-Sided Amplitude Spectrum (FIR Blackman Window)');
    % xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;  
    % 
    % % Play a portion of the audio (blackman)
    % start_sample = 1000
    % end_sample = 500500;
    % portion_to_play = audio_blackman(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% 5. Kaiser window
    b_kaiser = fir1(190, Fc_normal, 'low', kaiser(191,6.8));
    figure, freqz(b_kaiser,1,[],Fs); % Plot magnitude & phase response

    % Apply FIR Kaiser window filter to audio
    audio_kaiser = filter(b_kaiser, 1, noisy);

    % Plot the filtered signal in time-domain
    figure; plot(t, audio_kaiser), title('Filtered Signal (FIR Kaiser Window)');
    xlabel('Time (s)'), ylabel('Amplitude'), grid;

    % Analyse frequency spectrum of filtered audio
    Axk_kaiser = 2*abs(fft(audio_kaiser))/N;
    Axk_kaiser(1) = Axk_kaiser(1)/2;
    freq = [0:1:N/2]*Fs/N; % Frequencies up to the folding frequency
    figure, plot(freq/1000, Axk_kaiser(1:N/2+1)), title('One-Sided Amplitude Spectrum (FIR Kaiser Window)');
    xlabel('Frequency (kHz)'), ylabel('Amplitude'), grid;

    % % Play a portion of the audio (kaiser)
    % start_sample = 1000
    % end_sample = 500500;
    % portion_to_play = audio_kaiser(start_sample:end_sample);
    % sound(portion_to_play, Fs); % Play the extracted portion

% Export the filtered audio
    % filename = 'C:\Users\jean\OneDrive\Documents\Year 3 Semester 2\Digital Signal Processing\MATLAB\FIR Kaiser Filtered Audio.wav';
    % audiowrite(filename,audio_kaiser,Fs);

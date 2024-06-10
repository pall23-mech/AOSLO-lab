% Assuming frameshifts_strips_spline and timeaxis_secs are already defined
% frameshifts_strips_spline is an Nx2 matrix
% timeaxis_secs is a vector of length N

close all;

% Extract the columns from frameshifts_strips_spline
x1 = frameshifts_strips_spline(:, 1);
x2 = frameshifts_strips_spline(:, 2);

% Number of data points
n = length(timeaxis_secs);

% Compute the central difference for the interior points
dx1dt = central_difference(x1, timeaxis_secs);
dx2dt = central_difference(x2, timeaxis_secs);

% Design notch filters for 27 Hz and its multiples up to the Nyquist frequency
fs = 1 / (timeaxis_secs(2) - timeaxis_secs(1));
notch_freqs = 27:27:floor(fs / 2);
bw = 2; % Bandwidth for each notch filter

dx2dt_filtered = apply_notch_filters(dx2dt, fs, notch_freqs, bw);

% Apply a smoothing filter (e.g., moving average filter)
windowSize = 5; % Window size for smoothing
dx2dt_smoothed = apply_smoothing(dx2dt_filtered, windowSize);

% Number of sections
num_sections = 270;

% FFT Analysis for dx1dt and dx2dt_smoothed
[average_spectrum_x1, full_spectrum_x1, f] = fft_analysis(dx1dt, fs, num_sections);
[average_spectrum_x2, full_spectrum_x2, ~] = fft_analysis(dx2dt_smoothed, fs, num_sections);

% Low-pass filter cutoff frequency
cutoff = 408; % 408 Hz
H = double(f <= cutoff);

% Ensure the length of H matches the full FFT length
H_full_x1 = [H, fliplr(H(2:end-1))];
H_full_x2 = [H, fliplr(H(2:end-1))];

% Apply the low-pass filter in the frequency domain for x1 and x2
fourX_filtered = full_spectrum_x1(1:length(H_full_x1)) .* H_full_x1';
fourY_filtered = full_spectrum_x2(1:length(H_full_x2)) .* H_full_x2';

% Convert back to time domain (inverse FFT)
dx1dt_filtered = ifft([fourX_filtered; zeros(length(full_spectrum_x1) - length(fourX_filtered), 1)], 'symmetric');
dx2dt_filtered = ifft([fourY_filtered; zeros(length(full_spectrum_x2) - length(fourY_filtered), 1)], 'symmetric');

% Plot the results
plot_results(timeaxis_secs, dx1dt, dx1dt_filtered, dx2dt, dx2dt_filtered, f, average_spectrum_x1, full_spectrum_x1, average_spectrum_x2, full_spectrum_x2);

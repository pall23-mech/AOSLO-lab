function plot_results(timeaxis_secs, dx1dt, dx1dt_filtered, dx2dt, dx2dt_filtered, f, average_spectrum_x1, full_spectrum_x1, average_spectrum_x2, full_spectrum_x2)
    figure;
    subplot(2, 1, 1);
    plot(timeaxis_secs, dx1dt);
    hold on;
    plot(timeaxis_secs, dx1dt_filtered, 'r');
    title('Original and Filtered dx1dt');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original', 'Filtered');
    
    subplot(2, 1, 2);
    plot(timeaxis_secs, dx2dt);
    hold on;
    plot(timeaxis_secs, dx2dt_filtered, 'r');
    title('Original and Filtered dx2dt');
    xlabel('Time (s)');
    ylabel('Amplitude');
    legend('Original', 'Filtered');

    % Plot the results for x1
    figure;
    subplot(2, 1, 1);
    plot(f, average_spectrum_x1);
    xlim([1 420]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Average Spectrum for dx1dt (Method 1)');

    subplot(2, 1, 2);
    plot(f, full_spectrum_x1(1:length(f)));
    xlabel('Frequency (Hz)');
    xlim([1 420]);
    ylabel('Amplitude');
    title('Scaled Spectrum for dx1dt (Method 2)');

    % Plot the results for x2
    figure;
    subplot(2, 1, 1);
    plot(f, average_spectrum_x2);
    xlim([1 420]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Average Spectrum for dx2dt (Method 1)');

    subplot(2, 1, 2);
    plot(f, full_spectrum_x2(1:length(f)));
    xlim([1 420]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
    title('Scaled Spectrum for dx2dt (Method 2)');
end

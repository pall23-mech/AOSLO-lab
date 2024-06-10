function filtered_signal = apply_notch_filters(signal, fs, notch_freqs, bw)
    nyquist = fs / 2;
    filtered_signal = signal;
    for freq = notch_freqs
        if freq < nyquist
            Wo = freq / nyquist;
            BW = bw / nyquist;
            notch_filter = designfilt('bandstopiir', ...
                                      'FilterOrder', 2, ...
                                      'HalfPowerFrequency1', Wo - BW/2, ...
                                      'HalfPowerFrequency2', Wo + BW/2, ...
                                      'DesignMethod', 'butter');
            filtered_signal = filtfilt(notch_filter, filtered_signal); % Apply zero-phase filter
        end
    end
end

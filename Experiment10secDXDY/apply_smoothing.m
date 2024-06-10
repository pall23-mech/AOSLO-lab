function smoothed_signal = apply_smoothing(signal, windowSize)
    smoothed_signal = movmean(signal, windowSize);
end

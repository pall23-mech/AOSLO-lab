function [average_spectrum, full_spectrum, f] = fft_analysis(signal, fs, num_sections)
    n = length(signal);
    section_length = floor(n / num_sections);
    average_spectrum = zeros(section_length, 1);
    
    for i = 1:num_sections
        start_idx = (i-1) * section_length + 1;
        end_idx = min(i * section_length, n);
        
        section = signal(start_idx:end_idx);
        if length(section) < section_length
            section = [section; zeros(section_length - length(section), 1)];
        end
        
        section_fft = fft(section);
        section_magnitude = abs(section_fft);
        
        average_spectrum = average_spectrum + section_magnitude(1:section_length);
    end
    
    average_spectrum = average_spectrum / num_sections;
    full_fft = fft(signal);
    full_spectrum = abs(full_fft) / num_sections;
    f = (0:section_length-1) * fs / section_length;
end

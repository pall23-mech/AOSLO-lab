function dxdt = central_difference(x, timeaxis_secs)
    n = length(x);
    dxdt = zeros(n, 1);
    for i = 2:n-1
        dxdt(i) = (x(i+1) - x(i-1)) / (timeaxis_secs(i+1) - timeaxis_secs(i-1));
    end
    dxdt(1) = (x(2) - x(1)) / (timeaxis_secs(2) - timeaxis_secs(1));
    dxdt(n) = (x(n) - x(n-1)) / (timeaxis_secs(n) - timeaxis_secs(n-1));
end

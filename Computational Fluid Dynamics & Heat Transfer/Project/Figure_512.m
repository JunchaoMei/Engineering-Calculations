function [X,Y] = Figure_512(h)

% initialize h(i)
h2t = [1e-5,2e-5,5e-5,1e-4,2e-4,5e-4,1e-3,2e-3,5e-3,1e-2,2e-2,5e-2,1e-1,2e-1,5e-1,1,2,5,1e1,2e1,5e1,1e2,2e2,5e2,1e3,2e3,5e3,1e4];

% get value of X(i)
for i=1:length(h2t)
    X(i) = h2t(i);
end

% get value of t(i)
for i=1:length(h2t)
    t(i) = h2t(i)/(h^2);
end

% get value of Y(i)
for i=1:length(h2t)
    Y(i) = 1-exp(-1.662*exp(0.09*(3-h))*h*t(i));
end

end
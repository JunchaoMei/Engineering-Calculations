function [X,Y] = Figure_511(r)

% initialize k(i)
k = [0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100];

% get value of X(i)
for i=1:length(k)
    X(i) = k(i);
end

% get value of Y(i)
for i=1:length(k)
    Y(i) = ((exp(-1/(2*k(i)))-1)*r^(1.875-0.375*r))+1;
end

end
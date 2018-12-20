syms x;
f0(x) = x^3-5*x;
f1(x) = diff(f0(x));
f2(x) = diff(f1(x));

X = [0.5, 1.5];
dx = [0.00001, 0.0001, 0.001, 0.01, 0.1, 0.2, 0.3];

disp('Result(1,i) = the result of calculated i-th differential value');
disp('Result(2,i) = the error when calculating the i-th differential value');

disp([char(13),'2nd order [central] difference approximation',char(13)]);
for k = 1:length(dx) % 1-based indexing
    for j = 1:length(X)
        x0 = X(j);
        disp(['x = ',num2str(x0)]);
        result1 = eval((f0(x0+dx(k))-f0(x0-dx(k)))/(2*dx(k)));
        error1 = 100*abs(eval((result1-f1(x0))/f1(x0)));
        result2 = eval((f1(x0+dx(k))-f1(x0-dx(k)))/(2*dx(k)));
        error2 = 100*abs(eval((result2-f2(x0))/f2(x0)));
        
        disp(['step size = ',num2str(dx(k))]);
        Result = [result1,result2; error1,error2]
    end % for loop j
end % for loop k

disp([char(13),'2nd order [backward] difference approximation',char(13)]);
for k = 1:length(dx) % 1-based indexing
    for j = 1:length(X)
        x0 = X(j);
        disp(['x = ',num2str(x0)]);
        result1 = eval((f0(x0-2*dx(k))-f0(x0))/(-2*dx(k)));
        error1 = 100*abs(eval((result1-f1(x0))/f1(x0)));
        result2 = eval((f1(x0-2*dx(k))-f1(x0))/(-2*dx(k)));
        error2 = 100*abs(eval((result2-f2(x0))/f2(x0)));
        
        disp(['step size = ',num2str(dx(k))]);
        Result = [result1,result2; error1,error2]
    end % for loop j
end % for loop k

disp([char(13),'2nd order [forward] difference approximation',char(13)]);
for k = 1:length(dx) % 1-based indexing
    for j = 1:length(X)
        x0 = X(j);
        disp(['x = ',num2str(x0)]);
        result1 = eval((f0(x0+2*dx(k))-f0(x0))/(2*dx(k)));
        error1 = 100*abs(eval((result1-f1(x0))/f1(x0)));
        result2 = eval((f1(x0+2*dx(k))-f1(x0))/(2*dx(k)));
        error2 = 100*abs(eval((result2-f2(x0))/f2(x0)));
        
        disp(['step size = ',num2str(dx(k))]);
        Result = [result1,result2; error1,error2]
    end % for loop j
end % for loop k
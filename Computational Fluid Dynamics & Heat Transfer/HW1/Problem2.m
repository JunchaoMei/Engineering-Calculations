syms x;
f0(x) = sin(pi*x/2);
f1(x) = diff(f0(x));
f2(x) = diff(f1(x));
f3(x) = diff(f2(x));
f4(x) = diff(f3(x));

x0 = 1.5;
dx = [0.0005, 0.001, 0.01, 0.1, 0.2, 0.3, 0.4];

disp('Result(1,i) = the result of calculated i-th differential value');
disp('Result(2,i) = the error when calculating the i-th differential value');

for i = 1:length(dx) % 1-based indexing
    
    result1 = eval((f0(x0+dx(i))-f0(x0-dx(i)))/(2*dx(i)));
    error1 = 100*abs(eval((result1-f1(x0))/f1(x0)));
    result2 = eval((f1(x0+dx(i))-f1(x0-dx(i)))/(2*dx(i)));
    error2 = 100*abs(eval((result2-f2(x0))/f2(x0)));
    result3 = eval((f2(x0+dx(i))-f2(x0-dx(i)))/(2*dx(i)));
    error3 = 100*abs(eval((result3-f3(x0))/f3(x0)));
    result4 = eval((f3(x0+dx(i))-f3(x0-dx(i)))/(2*dx(i)));
    error4 = 100*abs(eval((result4-f4(x0))/f4(x0)));
    
    disp(['step size = ',num2str(dx(i))]);
    Result = [result1,result2,result3,result4; error1,error2,error3,error4]
end
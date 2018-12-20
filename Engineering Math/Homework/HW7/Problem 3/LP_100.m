clear;
fai=100;
load X.mat; load W.mat; load Y2.mat;
number_points = [1 2 3 5 7 10 15];

syms x li yN;
for n=4:7
    N = number_points(n);
    yN(N)=0;
    for i=1:N+1
        li(N,i)=1;
        for j=1:N+1
            if j~=i
                li(N,i) = li(N,i)*(x-X(N,j))/(X(N,i)-X(N,j));
            end
        end
        yN(N) = yN(N) + Y2(N,i)*li(N,i);
    end
end

% yN
for x = 0:0.01:1
	y(i) = cosh(fai*x)/cosh(fai);
    y5(i) = eval(yN(5));
    y7(i) = eval(yN(7));
    y10(i) = eval(yN(10));
    y15(i) = eval(yN(15));
    i=i+1;
end

% effectiveness factor
na(5) = quad(@yN5,0,1);
na(7) = quad(@yN7,0,1);
na(10) = quad(@yN10,0,1);
na(15) = quad(@yN15,0,1);

xp = linspace(0,1,116);
figure
plot(xp,y,xp,y5,xp,y7,xp,y10,xp,y15);
title('y(x) @ ¦Õ=100');
xlabel('x'); ylabel('y');
legend('analytical','LP (N=5)','LP (N=7)','LP (N=10)','LP (N=15)');

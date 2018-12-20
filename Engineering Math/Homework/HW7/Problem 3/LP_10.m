clear;
fai=10;
load X.mat; load W.mat; load Y1.mat;
number_points = [1 2 3 5 7 10 15];

syms x li yN;
for n=1:4
    N = number_points(n);
    yN(N)=0;
    for i=1:N+1
        li(N,i)=1;
        for j=1:N+1
            if j~=i
                li(N,i) = li(N,i)*(x-X(N,j))/(X(N,i)-X(N,j));
            end
        end
        yN(N) = yN(N) + Y1(N,i)*li(N,i);
    end
end

% yN
for x = 0:0.01:1;
	y(i) = cosh(fai*x)/cosh(fai);
    y1(i) = eval(yN(1));
    y2(i) = eval(yN(2));
    y3(i) = eval(yN(3));
    y5(i) = eval(yN(5));
    i=i+1;
end

% effectiveness factor
for n=1:4
    N = number_points(n);
    na(N) = eval(int(yN(N),0,1));
end

xp = linspace(0,1,106);
figure
plot(xp,y,xp,y1,xp,y2,xp,y3,xp,y5);
title('y(x) @ ¦Õ=10');
xlabel('x'); ylabel('y');
legend('analytical','LP (N=1)','LP (N=2)','LP (N=3)','LP (N=5)');

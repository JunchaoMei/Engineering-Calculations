function [t,yA,yG,yC]=analytical(a,b)
    k1=1;k2=0.5;k3=1;
    h=0.00001;
    t = a:h:b;
    N = ceil((b-a)/h);
    yA = 1./((k1+k3)*t+1);
    yG(1) = 0;yC(1) = 0;
    for i = 1:N
        yG(i+1) = yG(i)+h*fG(1/((k1+k3)*t(i)+1),yG(i));
        yC(i+1) = yC(i)+h*fC(1/((k1+k3)*t(i)+1),yG(i));
    end
end
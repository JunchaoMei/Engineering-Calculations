function [A,B,C,D,G] = abcdg(n,dr,dtheta)

% get the values of r
for i=1:n
    r(i)=(i-1)*dr;
end

% get the values of A,B,C,D
for i=1:n
    A(i) = -(r(i)-0.5*dr)/(r(i)*dr^2);
    B(i) = -(r(i)+0.5*dr)/(r(i)*dr^2);
    C(i) = (r(i)+0.5*dr)/((r(i)^2)*(dtheta^2));
    D(i) = (r(i)-0.5*dr)/((r(i)^2)*(dtheta^2));
    G(i) = 2/(dr^2)+2/(r(i)*dtheta^2);
end

end
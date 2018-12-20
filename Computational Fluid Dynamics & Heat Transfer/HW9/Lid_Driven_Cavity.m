function [fai,omega,x,y,k,u] = Lid_Driven_Cavity(maxError_fai,maxError_omega)
k=0; % iterative step
u0=5;
dx=0.01;
dy=0.01;

% get values of x & y
for i=1:41
x(i)=(i-1)*dx;
end
for j=1:31
y(j)=(j-1)*dy;
end

% initialization
fai=zeros(41,31);
omega=zeros(41,31);

error_fai = maxError_fai+1;
error_omega = maxError_omega+1;

% iteration
while (error_omega>maxError_omega || error_fai>maxError_fai)
error_fai = 0;
error_omega = 0;

for j=1:31
    for i=1:41
        % ICs
        if i==1 && j~=31
            omega_new = -2*fai(2,j)/(dx^2);
        elseif i==41 && j~=31
            omega_new = -2*fai(40,j)/(dx^2);
        elseif j==1 && i~=1 && i~=41
            omega_new = -2*fai(i,2)/(dy^2);
        elseif j==31
            omega_new = -2*(fai(i,30)+u0*dy)/(dy^2);
        else
            omega_new = -(((fai(i-1,j)-2*fai(i,j)+fai(i+1,j))/(dx^2))+((fai(i,j-1)-2*fai(i,j)+fai(i,j+1))/(dy^2)));
        end
        error_omega_new = abs(omega_new-omega(i,j));
        omega(i,j)=omega_new;
        % error judge - for all points error_omega<maxError_omega
        if error_omega_new>error_omega
            error_omega = error_omega_new;
        end
    end
end

% fai
for j=2:30
    for i=2:40
        % recursion
        fai_new = ((fai(i-1,j)+fai(i+1,j))/(dx^2)+(fai(i,j-1)+fai(i,j+1))/(dy^2)+omega(i,j+1))/((2/(dx^2))+(2/(dy^2)));
        error_fai_new = abs(fai_new-fai(i,j));
        fai(i,j)=fai_new;
        % error judge - for all points error_fai<maxError_fai
        if error_fai_new>error_fai
            error_fai = error_fai_new;
        end
    end
end

k=k+1;
end

% get values of u
for j=1:31
    for i=1:41
        if i==1 && j~=31
            u(i,j) = 0;
        elseif i==41 && j~=31
            u(i,j) = 0;
        elseif j==1 && i~=1 && i~=41
            u(i,j) = 0;
        elseif j==31
            u(i,j) = u0;
        else
            u(i,j) = (fai(i,j+1)-fai(i,j))/(y(j+1)-y(j));
        end
    end
end

end
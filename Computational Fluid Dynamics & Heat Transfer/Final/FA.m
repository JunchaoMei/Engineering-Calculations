function [R,th,x,y,t] = FA(dr,m)
da=1/(14*m);
I=1/dr+1;
J=1/da+1;
It=(I-1)*7/10+1;
Jt=(J-1)*5/14+1;
E=0;
n=0;
 
 for i=1:I
     r(i)=(i-1)*dr;
 end
 r=r';
 for j=1:J
     a(j)=(j-1)*da*7*pi/18;
 end
 
% Initial assumption;
for i=1:I
    for j=1:J
        T(i,j)=1;
    end
end
% Boundary I;
for i=1:J
    T(1,i)=1;
end
% Boundary VI;
for i=1:I
    T(i,J)=1;
end
% Boundary III
for i=Jt+1:J
    T(I,i)=1;
end
% Boundary V
for i=It+1:I-1
    T(i,Jt)=0;
end
T(I,Jt)=0.5;
W=T;
 
while E==0
   E=1;
   for i=2:I-1
       A=(2*i-1)/(2*i-2);
       B=(2*i-3)/(2*i-2);
       C=18/(7*pi*da*da*(i-1)*(i-1));
       if i<It
           for j=J-1:-1:2
               W(i,j)=(A*T(i+1,j)+B*T(i-1,j)+C*(T(i,j+1)+T(i,j-1))-2.5*dr*dr)/2/(C+1);
           end
           j=1;
           W(i,j)=(A*T(i+1,j)+B*T(i-1,j)+2*C*T(i,j+1)-2.5*dr*dr)/2/(C+1);
       elseif i==It
           for j=J-1:-1:Jt
               W(i,j)=(A*T(i+1,j)+B*T(i-1,j)+C*(T(i,j+1)+T(i,j-1))-2.5*dr*dr)/2/(C+1);
           end
           for j=Jt-1:-1:2
               W(i,j)=((A+B)*T(i-1,j)+C*(T(i,j+1)+T(i,j-1))-2.5*dr*dr)/2/(C+1);
           end
           j=1;
           W(i,j)=((A+B)*T(i-1,j)+2*C*T(i,j+1)-2.5*dr*dr)/2/(C+1);
       elseif i>It
           for j=J-1:-1:Jt+1
               W(i,j)=(A*T(i+1,j)+B*T(i-1,j)+C*(T(i,j+1)+T(i,j-1))-2.5*dr*dr)/2/(C+1);
           end
       end
       for i=1:I
           for j=1:J
               w=W(i,j)-T(i,j);
               if abs(w)<0.0001
                   E=E*1;
               else
                   E=E*0;
               end
               T(i,j)=W(i,j);
           end
       end
   end
   n=n+1;
end
T=100*T+200;
 X=10*r*cos(a);
 Y=10*r*sin(a);
 for i=1:I
     if i<It+1
         for j=1:J
             x(i,j)=X(i,j);
             y(i,j)=Y(i,j);
             t(i,j)=T(i,j);
             R(i,j)=r(i);
             th(i,j)=a(j);
         end
     else
         for j=Jt:J
             x(i,j)=X(i,j);
             y(i,j)=Y(i,j);
             t(i,j)=T(i,j);
             R(i,j)=r(i);
             th(i,j)=a(j);
         end
         for j=1:Jt-1
             x(i,j)=X(It,j+1);
             y(i,j)=Y(It,j+1);
             t(i,j)=T(It,j+1);
             R(i,j)=r(It);
             th(i,j)=a(j+1);
         end   
     end
 end
end

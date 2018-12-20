% [find the minimum and maximum points]

clear;
load P_1500.mat; load P_3000.mat; load P_4500.mat; load P_6000.mat; load P_7500.mat;
[row,col]=size(P_1500);
Min=10000; Max=0;

for i=1:row
    for j=1:col
        Min=min(P_1500(i,j),Min);Min=min(P_3000(i,j),Min);Min=min(P_4500(i,j),Min);Min=min(P_6000(i,j),Min);Min=min(P_7500(i,j),Min);
        Max=max(P_1500(i,j),Max);Max=max(P_3000(i,j),Max);Max=max(P_4500(i,j),Max);Max=max(P_6000(i,j),Max);Max=max(P_7500(i,j),Max);
    end
end

Min
Max
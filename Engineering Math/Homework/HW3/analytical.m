function [tau,y]=analytical()
    tau = 0:0.01:2;
    y = 1./(tau+1);
end
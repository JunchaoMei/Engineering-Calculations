% [Plot 3D - Pressure]

clear
% import data
load P_1500.mat; dataset=P_1500;
[row,col]=size(dataset);
X=10; Y=10; LAYER=4; T=5; time=[0 30 270 730 1825];

% get value(x,y,Layer,t)
for i=1:row
    for j=1:col
        % get x,y,Layer,t
        layer=-ceil(i/X);% negative depth
        Layer=-layer; % in Matrix value
        x=i-(Layer-1)*X;
        t=ceil(j/Y);
        y=j-(t-1)*Y;
        % get value
        value(x,y,Layer,t)=dataset(i,j);
    end
end

% plots
xplot=1:X; yplot=1:Y;
for t=1:T
    h=figure('visible','off');
    [xi,yi] = meshgrid(1:0.1:X,1:0.1:Y);
    for Layer=1:LAYER
        zi=ones(size(xi))*(-Layer);
        v = value(xplot,yplot,Layer,t);
        % interpolation
        vi = interp2(v,xi,yi,'linear');
        surf(xi,yi,zi,vi);
        hold on;
    end
    str1='Pressure Gradients (1500ppm, t='; str2=num2str(time(t)); str3=' days)';
    name=strcat(str1,str2,str3);
    title(name);
    xlabel('x'); ylabel('y');
    zlim([-Layer,0]);
    %caxis([1500,5100]);
    colormap(jet);
    colorbar;
    shading interp;
    saveas(h,name,'bmp');
    saveas(h,name,'jpg');
    hold off;
end
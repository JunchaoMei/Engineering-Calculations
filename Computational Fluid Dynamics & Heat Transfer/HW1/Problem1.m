x = 1;
dx = 0.1;
e = exp(1);

cen2 = (e^(x + dx) - e^(x - dx)) / (2*dx);  % 2nd order central difference approximation
forw1 = (e^(x + dx) - e(x)) / dx;  % 1st order forward difference approximation
accurate = e^x;
error_cen2 = 100* (cen2-accurate) / accurate;
error_forw1 = 100* (forw1-accurate) / accurate;

disp(['Result of 2nd order central difference approximation method; ' ,num2str(cen2)]);
disp(['Error of 2nd order central difference approximation method; ' ,num2str(error_cen2)]);
disp(['Result of 1st order forward difference approximation method; ' ,num2str(forw1)]);
disp(['Error of 1st order forward difference approximation method; ' ,num2str(error_forw1)]);
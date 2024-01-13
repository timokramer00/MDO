% Open the first file and read coordinates
fid1 = fopen('airfoil_init.dat', 'r');
Coor1 = fscanf(fid1, '%g %g', [2 Inf]);
fclose(fid1);

% Open the second file and read coordinates
fid2 = fopen('airfoil_optimised.dat', 'r');
Coor2 = fscanf(fid2, '%g %g', [2 Inf]);
fclose(fid2);

% Plot the first airfoil with red crosses
figure;
plot(Coor1(1, :), Coor1(2, :), 'r-', 'DisplayName', 'Initial airfoil');
hold on;

% Plot the second airfoil with a blue continuous line
plot(Coor2(1, :), Coor2(2, :), 'b-', 'DisplayName', 'Optimised airfoil');

% Set plot limits
axis([0, 1, -1.5, 1.5]);

% Add legend
legend('Location', 'Best');
xlabel('X-coordinate');
ylabel('Y-coordinate');
title('Airfoil Comparison');
grid on;
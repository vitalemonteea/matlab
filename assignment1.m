% This file is used to record eie589 assignment1
% Using Dijkstra's algorithm
clc;
clear;

% Generate a 20x20 matrix
[x, y] = meshgrid(1:20, 1:20);
all_points = [x(:), y(:)]; 
keep_points = [1, 400]; 
other_points_index = setdiff(1:400, keep_points); 

% Randomly select 120 points to remove
removed_points_index = other_points_index(randperm(length(other_points_index), 120));
remaining_points_index = setdiff(1:400, [removed_points_index, keep_points]); 
remaining_points = all_points([keep_points, remaining_points_index], :);
start_point = 1; 
end_point = find(remaining_points(:,1) == 20 & remaining_points(:,2) == 20);

% Construct adjacency matrix
num_remaining_points = size(remaining_points, 1);
G = zeros(num_remaining_points);
for i = 1:num_remaining_points
    for j = i+1:num_remaining_points
        dist = norm(remaining_points(i,:) - remaining_points(j,:));
        if dist <= sqrt(2)
            G(i,j) = dist;
            G(j,i) = dist;
        end
    end
end

% Dijkstra
[~, shortest_path] = Dijkstra(G, start_point, end_point);

%plot
figure;
hold on;
plot(remaining_points(:,1), remaining_points(:,2), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
removed_points = all_points(removed_points_index, :);
plot(removed_points(:,1), removed_points(:,2), 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r');

% Plot shortest path
if ~isempty(shortest_path)
    path_x = remaining_points(shortest_path, 1);
    path_y = remaining_points(shortest_path, 2);
    plot(path_x, path_y, 'b-', 'LineWidth', 2);
else
    disp('No path found to the end point');
end
plot(remaining_points(start_point,1), remaining_points(start_point,2), 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
plot(remaining_points(end_point,1), remaining_points(end_point,2), 'bs', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

axis([0 21 0 21]); 
xticks(0:1:21);
yticks(0:1:21);
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Adjacency matrix visualization with shortest path');
hold off;






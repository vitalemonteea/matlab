% 此文件用于记录eie589 assignment1
% 使用dj算法

clc;
clear;

% 生成节点坐标矩阵，这里是20x20的网格
[x, y] = meshgrid(1:20, 1:20);
all_points = [x(:), y(:)]; % 将坐标矩阵转换为Nx2的矩阵，N = 400

% 保留(1,1)和(20,20)两个点，获取其他398个点的索引
keep_points = [1,400]; % (1,1)对应索引1，(20,20)对应索引400
other_points_index = setdiff(1:400, keep_points); 

% 随机选择120个要移除的点的索引
removed_points_index = randperm(length(other_points_index), 120);
remaining_points_index = setdiff(other_points_index, removed_points_index); 

% 获取剩余的280个点的坐标
remaining_points = all_points(remaining_points_index, :);
start_point= [1, 1];
end_point = [20, 20];
remaining_points = [start_point; remaining_points; end_point];

% 优化只查询自己最近的9个点位置
num_remaining_points = size(remaining_points, 1);
G = zeros(num_remaining_points);
for i = 1:num_remaining_points
    for j = 1:num_remaining_points
        % 计算两点之间的距离
        dist = norm(remaining_points(i,:) - remaining_points(j,:));
        if abs(remaining_points(i,1) - remaining_points(j,1)) <= 1 &&...
           abs(remaining_points(i,2) - remaining_points(j,2)) <= 1
            G(i,j) = dist;
            G(j,i) = dist; % 因为是无向图，所以邻接矩阵是对称的
        end
    end
end



disp(size(G))
%调用Dijkstra算法
start_point = 1; % (1,1) 的索引
end_point = num_remaining_points; % (19,19) 的索引
[distances, path] = Dijkstra(G, start_point);


% 绘制图的节点和边
figure;
hold on;
num_remaining_points = size(remaining_points, 1);

% 绘制边
for i = 1:num_remaining_points
    for j = i+1:num_remaining_points % 只遍历后面的点，避免重复绘制边
        if G(i,j) > 0
            plot([remaining_points(i,1), remaining_points(j,1)], [remaining_points(i,2), remaining_points(j,2)], 'k-');
        end
    end
end

% 绘制节点
for i = 1:num_remaining_points
    if ismember(i, [1, num_remaining_points]) % 起点和终点
        plot(remaining_points(i,1), remaining_points(i,2), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    else
        plot(remaining_points(i,1), remaining_points(i,2), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
    end
end

% 绘制被移除的点
removed_points = all_points(removed_points_index, :);
plot(removed_points(:,1), removed_points(:,2), 'ro', 'MarkerSize', 4);

axis([0 21 0 21]); 
xticks(0:1:21);
yticks(0:1:21);
grid on;
hold off;
xlabel('X轴');
ylabel('Y轴');
title('邻接矩阵可视化');
legend('边', '保留的点', '移除的点', 'Location', 'best');




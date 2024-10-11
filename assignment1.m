    % 此文件用于记录eie589 assignment1
% 使用dj算法

clc;
clear;

% 生成节点坐标矩阵，这里是20x20的网格
[x, y] = meshgrid(1:20, 1:20);
all_points = [x(:), y(:)]; % 将坐标矩阵转换为Nx2的矩阵，N = 400

% 保留(1,1)和(20,20)两个点，获取其他398个点的索引
keep_points = [1, 400]; % (1,1)对应索引1，(20,20)对应索引400
other_points_index = setdiff(1:400, keep_points); 

% 随机选择120个要移除的点的索引
removed_points_index = other_points_index(randperm(length(other_points_index), 120));
remaining_points_index = setdiff(1:400, [removed_points_index, keep_points]); 

% 获取剩余的点的坐标
remaining_points = all_points([keep_points, remaining_points_index], :);

% 移除这一行，因为它重复添加了起点和终点
% remaining_points = [start_point; remaining_points; end_point];

% 优化只查询自己最近的9个点位置
num_remaining_points = size(remaining_points, 1);
G = zeros(num_remaining_points);

% ... 后面的代码保持不变 ...

% 在绘图之前，打印剩余点的数量
disp(['Number of remaining points: ', num2str(num_remaining_points)]);

% ... 绘图代码 ...



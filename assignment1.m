% 此文件用于记录eie589 第一次作业

% 生成节点坐标矩阵，这里是20x20的网格
[x, y] = meshgrid(1:20, 1:20);
all_points = [x(:), y(:)]; % 将坐标矩阵转换为Nx2的矩阵，N = 400

% 保留(1,1)和(20,20)两个点，获取其他398个点的索引
keep_points = [1; 400]; % (1,1)对应索引1，(20,20)对应索引400
other_points_index = setdiff(1:400, keep_points); 

% 随机选择120个要移除的点的索引
removed_points_index = randperm(length(other_points_index), 120);
remaining_points_index = setdiff(other_points_index, removed_points_index); 

% 获取剩余的280个点的坐标
remaining_points = all_points(remaining_points_index, :);

% 构建图的邻接矩阵
num_remaining_points = size(remaining_points, 1);
adj_matrix = zeros(num_remaining_points);
for i = 1:num_remaining_points
    for j = 1:num_remaining_points
        % 计算两点之间的距离
        dist = norm(remaining_points(i,:) - remaining_points(j,:));
        if abs(remaining_points(i,1) - remaining_points(j,1)) <= 1 &&...
           abs(remaining_points(i,2) - remaining_points(j,2)) <= 1
            adj_matrix(i,j) = dist;
            adj_matrix(j,i) = dist; % 因为是无向图，所以邻接矩阵是对称的
        end
    end
end

imagesc(adj_matrix);
colorbar;
title('邻接矩阵');
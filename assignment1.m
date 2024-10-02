% 此文件用于记录eie589 
%使用dj算法

% 生成节点坐标矩阵，这里是20x20的网格
[x, y] = meshgrid(0:19, 0:19);
all_points = [x(:), y(:)]; % 将坐标矩阵转换为Nx2的矩阵，N = 400

% 保留(0,0)和(19,19)两个点，获取其他398个点的索引
keep_points = [1; 381]; % (1,1)对应索引1，(20,20)对应索引400
other_points_index = setdiff(1:400, keep_points); 

% 随机选择120个要移除的点的索引
removed_points_index = randperm(length(other_points_index), 120);
remaining_points_index = setdiff(other_points_index, removed_points_index); 

% 获取剩余的280个点的坐标
remaining_points = all_points(remaining_points_index, :);
start_point= [0, 0];
end_point = [19, 19];
remaining_points = [start_point; remaining_points; end_point];

% % 构建图的邻接矩阵
% num_remaining_points = size(remaining_points, 1);
% adj_matrix = zeros(num_remaining_points);
% for i = 1:num_remaining_points
%     for j = 1:num_remaining_points
%         % 计算两点之间的距离
%         dist = norm(remaining_points(i,:) - remaining_points(j,:));
%         if abs(remaining_points(i,1) - remaining_points(j,1)) <= 1 &&...
%            abs(remaining_points(i,2) - remaining_points(j,2)) <= 1
%             adj_matrix(i,j) = dist;
%             adj_matrix(j,i) = dist; % 因为是无向图，所以邻接矩阵是对称的
%         end
%     end
% end

% 优化
num_remaining_points = size(remaining_points, 1);
adj_matrix = zeros(num_remaining_points);
for i = 1:num_remaining_points
    x_i = remaining_points(i,1);
    y_i = remaining_points(i,2);
    for dx = -1:1
        for dy = -1:1
            x_j = x_i + dx;
            y_j = y_i + dy;
            % 找到符合坐标范围的邻居节点索引
            index_j = find((remaining_points(:,1)==x_j)&(remaining_points(:,2)==y_j), 1);
            if ~isempty(index_j)
                dist = norm(remaining_points(i,:) - remaining_points(index_j,:));
                adj_matrix(i,index_j) = dist;
                adj_matrix(index_j,i) = dist;
            end
        end
    end
end


% 绘制图的节点和边
figure;
hold on;
num_remaining_points = size(remaining_points, 1);
for i = 1:num_remaining_points
    for j = 1:num_remaining_points
        if adj_matrix(i,j) > 0
            plot([remaining_points(i,1), remaining_points(j,1)], [remaining_points(i,2), remaining_points(j,2)], 'k-');
        end
    end
end
plot(remaining_points(:,1), remaining_points(:,2), 'ro');
axis([0 19 0 19]); % 添加这行代码，设置坐标轴范围从0到20
xticks(0:1:19);
yticks(0:1:19);
hold off;
xlabel('X轴');
ylabel('Y轴');
title('图的可视化');
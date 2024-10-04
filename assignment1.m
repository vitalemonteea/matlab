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
                G(i,index_j) = dist;
                G(index_j,i) = dist;
            end
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

plot(remaining_points(:,1), remaining_points(:,2), 'ro');
axis([0 20 0 20]); 
xticks(0:1:20);
yticks(0:1:20);
hold off;
xlabel('X轴');
ylabel('Y轴');
title('邻接矩阵');

% 绘制最短路径
if ~isempty(path)
    for k = 1:length(path)-1
        if path(k)>0 && path(k)<size(remaining_points,1) && path(k+1)>0 && path(k+1)<size(remaining_points,1)
            plot([remaining_points(path(k),1), remaining_points(path(k+1),1)], [remaining_points(path(k),2), remaining_points(path(k+1),2)], 'g-', 'LineWidth', 2);
        else
            disp(['Invalid index at iteration ', num2str(k)]);
        end
    end
else
    disp('无法绘制最短路径，可能是路径未找到或生成错误。');
end
hold off;
xlabel('X 轴');
ylabel('Y 轴');
title('图的可视化及最短路径');


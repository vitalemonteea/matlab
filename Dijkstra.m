%Dijkstra算法实现
% 输入邻接矩阵G，开始的点start_point
% 返回最短距离数组distances和路径数组path

function [distances, path] = Dijkstra(G, start_point, end_point)
    num_nodes = size(G, 1);
    distances = inf(1, num_nodes);  % 初始化距离为无穷大
    path = zeros(1, num_nodes);     % 初始化路径
    visited = false(1, num_nodes);  % 初始化访问标记

    distances(start_point) = 0;  

    for i = 1:num_nodes
        % 寻找未访问的最小距离点
        unvisited_distances = distances;
        unvisited_distances(visited) = Inf;
        [~, current_point] = min(unvisited_distances);

       % 如果当前点是终点或者没有可达的未访问节点，则退出循环
        if current_point == end_point || isinf(min(distances))
            break;
        end

        visited(current_point) = true;

        % 更新邻接点的距离
        for neighbor = 1:num_nodes
            if ~visited(neighbor) && G(current_point, neighbor) > 0
                new_distance = distances(current_point) + G(current_point, neighbor);
                if new_distance < distances(neighbor)
                    distances(neighbor) = new_distance;
                    path(neighbor) = current_point;  % 更新路径
                end
            end
        end
    end

    % 如果没有找到到终点的路径，返回空路径
    if isinf(distances(end_point))
        path = [];
    else
        % 重构最短路径
        shortest_path = end_point;
        while shortest_path(1) ~= start_point
            shortest_path = [path(shortest_path(1)), shortest_path];
        end
        path = shortest_path;
    end
end


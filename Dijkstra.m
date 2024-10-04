%Dijkstra算法实现
% 初始化
% 输入邻接矩阵，开始的点以及终点，返还最短路径
function[ distances , path] = Dijkstra (G, start_point) 
    num_nodes = size(G,1);   %记录nodes个数
    distances = inf (num_nodes);  
    path = zeros(num_nodes);  
    visited = false(num_nodes);   % 记录是否已经遍历
    

    distances(start_point) = 0;


   for i=1:num_nodes
       %寻找未访问的最小距离点
       [~, current_point]= min(distances(~visited));   %把distances的最小点记录
       visited(current_point) = true;
       
       %更新distances矩阵
       for neighbor = 1: num_nodes
           if ~visited(neighbor)&& G(current_point,neighbor)>0
               new_distance = distances(current_point) + G(current_point,neighbor);
               if new_distance < distances(neighbor)
                   distances(neighbor) = new_distance;
                   path(neighbor)= current_point; % 设置前驱节点
               end
           end
       end          
   end
end

    
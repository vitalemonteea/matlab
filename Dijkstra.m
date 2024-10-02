%Dijkstra算法实现

% 初始化
% 输入邻接矩阵，开始的点以及终点，返还最短路径
funtion [ min , path] = dijkstra (G , start_point ,end_point) 
    num_nodes = size(G);   %记录nodes个数
    min = inf (num_nodes);  
    path = zeros(num_nodes);  
    visited = false(num_nodes);   % 记录是否已经遍历
    

    min(start_point) = 0; 

    
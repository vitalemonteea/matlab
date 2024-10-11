%Dijkstra implementation
% Input: adjacency matrix G, start point
% Output: array of shortest distances and path array

function [distances, path] = Dijkstra(G, start_point, end_point)
    num_nodes = size(G, 1);
    distances = inf(1, num_nodes);  % Initialize distances to infinity
    path = zeros(1, num_nodes);     % Initialize path
    visited = false(1, num_nodes);  % Initialize visited flags

    distances(start_point) = 0;  

    for i = 1:num_nodes
        % Find the unvisited node with the minimum distance
        unvisited_distances = distances;
        unvisited_distances(visited) = Inf;
        [~, current_point] = min(unvisited_distances);

        % Exit loop if current point is the end point or if there are no reachable unvisited nodes
        if current_point == end_point || isinf(min(distances))
            break;
        end

        visited(current_point) = true;

        % Update distances to adjacent nodes
        for neighbor = 1:num_nodes
            if ~visited(neighbor) && G(current_point, neighbor) > 0
                new_distance = distances(current_point) + G(current_point, neighbor);
                if new_distance < distances(neighbor)
                    distances(neighbor) = new_distance;
                    path(neighbor) = current_point;  % Update path
                end
            end
        end
    end

    if isinf(distances(end_point))
        path = [];
    else
        % Reconstruct the shortest path
        shortest_path = end_point;
        while shortest_path(1) ~= start_point
            shortest_path = [path(shortest_path(1)), shortest_path];
        end
        path = shortest_path;
    end
end


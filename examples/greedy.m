function Pgreedy = greedy(V,maze)

freeNorth           = reshape(maze.adjacent(:,1),size(V,1),size(V,2));
freeEast            = reshape(maze.adjacent(:,2),size(V,1),size(V,2));
freeSouth           = reshape(maze.adjacent(:,3),size(V,1),size(V,2));
freeWest            = reshape(maze.adjacent(:,4),size(V,1),size(V,2));

% 0 : stay
% 1 : North
% 2 : East
% 3 : South
% 4 : West

Pgreedy             = zeros(size(V));

V_North             = [-inf*ones(1,size(V,2)) ; V(1:end-1,:)];
V_East              = [V(:,2:end) , -inf*ones(size(V,1),1) ];
V_South             = [V(2:end,:) ; -inf*ones(1,size(V,2))];
V_West              = [-inf*ones(size(V,1),1) , V(:,1:end-1)];

V_North(~freeNorth) = -inf;
V_East(~freeEast)   = -inf;
V_South(~freeSouth) = -inf;
V_West(~freeWest)   = -inf;


Pgreedy(V_North>V & V_North>V_East & V_North>V_South & V_North>V_West)  = 1;
Pgreedy(V_East>V & V_East>V_North & V_East>V_South & V_East>V_West)     = 2;
Pgreedy(V_South>V & V_South>V_North & V_South>V_East & V_South>V_West)  = 3;
Pgreedy(V_West>V & V_West>V_North & V_West>V_East & V_West>V_South)     = 4;
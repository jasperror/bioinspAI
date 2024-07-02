% Gridworld demos for lecture Advanced Flight Control, May 2009.
% Ref. "Reinforcement Learning" by Sutton & Barto, 1998 (a.o. chpt 4).
% author: Erik-Jan van Kampen E.vanKampen@TUDelft.nl

addpath('Maze')

clear
clc
close all

% Grid initialisation:
GridSize                    = [15,25];
targetCellReward            = 3;
fullscreen                  = get(0,'ScreenSize');
k                           = 0.9999; % Discount factor

% Set initial value function:
V           = rand(GridSize);

% Random target cell location:
T           = min(GridSize,ceil(rand(1,2).*GridSize));

% generate maze
maze        = generate_maze(GridSize(1,2),GridSize(1,1)); % NOTE: reversed row/col lengths
fh          = draw_maze(maze);
set(fh, 'Renderer','zbuffer')
set(fh,'Position',[399,36,1010,717]);


freeNorth   = reshape(maze.adjacent(:,1),GridSize(1,1),GridSize(1,2));
freeEast    = reshape(maze.adjacent(:,2),GridSize(1,1),GridSize(1,2));
freeSouth   = reshape(maze.adjacent(:,3),GridSize(1,1),GridSize(1,2));
freeWest    = reshape(maze.adjacent(:,4),GridSize(1,1),GridSize(1,2));

% Set up rewards
% Normal cell transition: 0
% Transition into obstacle or edge: -penalty
% Transition away from target: targetCellReward

penalty = 0.05;

R_North                     = zeros(GridSize);
R_East                      = zeros(GridSize);
R_South                     = zeros(GridSize);
R_West                      = zeros(GridSize);
R_Center                    = -penalty*ones(GridSize);
 
R_North(T(1,1),T(1,2))      = targetCellReward;
R_East(T(1,1),T(1,2))       = targetCellReward;
R_South(T(1,1),T(1,2))      = targetCellReward;
R_West(T(1,1),T(1,2))       = targetCellReward;
 
% System dynamics: probabilities of transitioning from s to s' for each
% action (aNorth,aEast,aSouth,aWest).
% Note: P_x_y where x~=center && x~=y are trivially zero, so not computed
% here.
P_Center_aNorth             = ~freeNorth;
P_Center_aEast              = ~freeEast;
P_Center_aSouth             = ~freeSouth;
P_Center_aWest              = ~freeWest;
 
P_North_aNorth              = ~P_Center_aNorth;
P_East_aEast                = ~P_Center_aEast;
P_South_aSouth              = ~P_Center_aSouth;
P_West_aWest                = ~P_Center_aWest;

% Initially policy: equal probability of every action
K_North = 1/4*ones(GridSize);
K_East  = 1/4*ones(GridSize);
K_South = 1/4*ones(GridSize);
K_West  = 1/4*ones(GridSize);
    
Delta   = inf;
loopcnt = 1;
ch      = [];
while Delta > 3
    
    % Shift Value function to determine V(s'):
    V_North = [zeros(1,GridSize(1,2));V(1:end-1,:)];
    V_East  = [V(:,2:end),zeros(GridSize(1,1),1)];
    V_South = [V(2:end,:);zeros(1,GridSize(1,2))];
    V_West  = [zeros(GridSize(1,1),1),V(:,1:end-1)]; 

    % Update value based on current policy:
    Vnew = ...
        (K_North .* ( P_North_aNorth .* (R_North + k*V_North) + P_Center_aNorth .* (R_Center + k*V))) +...
        (K_East  .* ( P_East_aEast   .* (R_East  + k*V_East)  + P_Center_aEast  .* (R_Center + k*V))) +...
        (K_South .* ( P_South_aSouth .* (R_South + k*V_South) + P_Center_aSouth .* (R_Center + k*V))) +...
        (K_West  .* ( P_West_aWest   .* (R_West  + k*V_West)  + P_Center_aWest  .* (R_Center + k*V)));

    Delta   = sum(sum(abs(V-Vnew)));
    V       = Vnew;
    loopcnt = loopcnt + 1;
    
    %Draw update
    if rem(loopcnt,500)==0
        [fh,ch] = drawValue(V,fh,ch);
        refresh(fh)
    end
end

fprintf(1,'Number of value function update loops: %d\n',loopcnt)
pause

% Plot final Value function
[fh,ch] = drawValue(V,fh,ch);

% Plot target Cell
figure(fh)
text(T(1,2)-0.5,(GridSize(1,1)-T(1,1)+1)-0.5,'T')
title('Value function')

% Determine greedy policy:
Pgreedy     = greedy(V,maze);

fh2         = draw_maze(maze);
fh2         = plotPolicy(Pgreedy,fh2);

% Plot target Cell
figure(fh2)
text(T(1,2)-0.5,(GridSize(1,1)-T(1,1)+1)-0.5,'T')
title('Policy')

disp('Finished')
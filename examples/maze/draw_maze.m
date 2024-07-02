% draw_maze(maze)
% By Jeremy Kubica, Copyright 2003
%
% Displays the maze.
%   label_cells - A Boolean variable indicating whether to label
%                 the cells.  0 = Don't Label, 1 = Label (Default = 0)
% Type 'help maze' for more information
function h1=draw_maze(maze,label_cells)

if nargin < 2
   label_cells = 0;
end

h1 = figure();
set(h1,'DoubleBuffer','on')

LW = 3; % LineWdith

hold off;
clf;
hold on;

% determine the size of the maze and set the figure accordingly
R = maze.R;
C = maze.C;
axis([-0.5 C+0.5 -0.5 R+0.5]);

% draw the grid
ind = 1;
for i = 1:C
   for j = 1:R
      
      % Label the cell if needed.
      if label_cells == 1
         text(i-0.5,(R-j+2.5),num2str(ind));
      end
      
      % Draw the northern border
      HN = line([(i-1) (i)],[(R-j+1) (R-j+1)]);
      if(maze.adjacent(ind,1) == 1)
         set(HN,'Color',[0.6 0.6 0.6]);
         set(HN,'LineStyle',':');
      else
         set(HN,'Color',[0 0 0]);
         set(HN,'LineStyle','-','LineWidth',LW);
      end
      
      % Draw the southern border
      HS = line([(i-1) (i)],[(R-j) (R-j)]);
      if(maze.adjacent(ind,3) == 1)
         set(HS,'Color',[0.6 0.6 0.6]);
         set(HS,'LineStyle',':');
      else
         set(HS,'Color',[0 0 0]);
         set(HS,'LineStyle','-','LineWidth',LW);
      end
      
      % Draw the eastern border
      HE = line([(i) (i)],[(R-j+1) (R-j)]);
      if(maze.adjacent(ind,2) == 1)
         set(HE,'Color',[0.6 0.6 0.6]);
         set(HE,'LineStyle',':');
      else
         set(HE,'Color',[0 0 0]);
         set(HE,'LineStyle','-','LineWidth',LW);
      end  
      
      % Draw the western border
      HW = line([(i-1) (i-1)],[(R-j+1) (R-j)]);
      if(maze.adjacent(ind,4) == 1)
         set(HW,'Color',[0.6 0.6 0.6]);
         set(HW,'LineStyle',':');
      else
         set(HW,'Color',[0 0 0]);
         set(HW,'LineStyle','-','LineWidth',LW);
      end  
      
      ind = ind + 1;
   end
end
axis equal
hold off;
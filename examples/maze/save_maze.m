% save_maze(filename,maze);
% By Jeremy Kubica, Copyright 2003
%
% Writes a maze to the file with the given name.
% Type 'help maze' for more information
function save_maze(filename,maze);

f = fopen(filename,'w');

% Write out the number of rows and colums
fprintf(f,'%i %i\n',maze.R,maze.C);

% Write out the remainder of the matrix (one line at a time)
for i = 1:(maze.R*maze.C)
    t = maze.adjacent(i,:);
    fprintf(f,'%i %i %i %i\n',t(1),t(2),t(3),t(4));
end

fclose(f);
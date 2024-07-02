function [fh,ch] = drawValue(v,fh,ch)

if nargin==1
    fh = figure();
else
    figure(fh);
end

v=flipud(v);
hold on

if ~isempty(ch)
delete(ch)
clear ch
end

ch=[];
% Draw 
for i=1:size(v,1)
    for j=1:size(v,2)
        x1 = j-1;
        x2 = j;
            
        y1 = i-1;
        y2 = i;
               
        % Value
        chnew = patch([x1,x1;x1,x2;x2,x2;x2,x1],[y1,y2;y2,y2;y2,y1;y1,y1],[v(i,j),v(i,j);v(i,j),v(i,j);v(i,j),v(i,j);v(i,j),v(i,j)],v(i,j),'FaceAlpha',0.5);
%         chnew = patch([x1,x1;x1,x2;x2,x2;x2,x1],[y1,y2;y2,y2;y2,y1;y1,y1],[v(i,j),v(i,j);v(i,j),v(i,j);v(i,j),v(i,j);v(i,j),v(i,j)],v(i,j));
        ch=[ch,chnew];
    end
end

h=axis();

axis([h,min(0,min(min(v))),max(0,max(max(v)))]);




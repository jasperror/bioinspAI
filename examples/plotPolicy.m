function fh = plotPolicy(P,fh)
hold on
[jN,iN] = find(flipud(P)==1);
[jE,iE] = find(flipud(P)==2);
[jS,iS] = find(flipud(P)==3);
[jW,iW] = find(flipud(P)==4);

arrow3([iN-0.5,jN-1],[iN-0.5,jN],'k',.5,.8);
arrow3([iE-1,jE-0.5],[iE,jE-0.5],'k',.5,.8);
arrow3([iS-0.5,jS],[iS-0.5,jS-1],'k',.5,.8);
arrow3([iW,jW-0.5],[iW-1,jW-0.5],'k',.5,.8);

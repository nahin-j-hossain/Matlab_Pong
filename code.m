clear; clc; close all;

%-----------------------------Setup--------------------------------%
pongFigure = figure('color',[.6 .6 .8], ...  %figure
    'KeyPressFcn',@keyboardFunction,...
    'units', 'normal','position',[.1 .1 .8 .8]);

pongAxes = axes('color','black',...          %axes
    'XLim', [0 100], 'YLim', [-5 100],'XTickLabels',[],...
    'YTickLabels',[],'position', [.05 .05 .9 .9]);

pongBallVel = [1 , 1];                       %ball
pongBallPos = [20,50];
pongBall = line(pongBallPos(1),pongBallPos(2), ...
    'marker', '.', 'markersize',50,'color', [.8 .6 .6]);

global pongBlockCenter
pongBlockCenter = 45;
pongBlock = line([pongBlockCenter - 5, pongBlockCenter + 5 ], [0 0],...   %block
    'linewidth',4,'color',[.6 .8 .6]);



%--------------------------Loop----------------------%
tic;
while toc<15
    
    if pongBallPos(1)<0 || pongBallPos(1) >100  %bounce check
        pongBallVel(1) = -pongBallVel(1);
    end
    if pongBallPos(2) <0 || pongBallPos(2) >100
        pongBallVel(2) = -pongBallVel(2);
    end
    if pongBallPos(2) <0 
        if abs(pongBallPos(1) -pongBlockCenter) <5
            pongBallPos(2) = -pongBallVel(2);
            
        else
            fprintf ('GAME OVER')
            close all; return;
        end
    end
    
    pongBallPos = pongBallPos + pongBallVel;      %update ball
    set (pongBall,'Xdata', pongBallPos(1),'YData', pongBallPos(2));
    
    set(pongBlock, 'XData',[pongBlockCenter - 5,... %update block
                            pongBlockCenter + 5])
                        pause (.02);
                      
end


%----------------Functions--------------%
function keyboardFunction (figure, event)
global pongBlockCenter
switch event.Key
    case 'leftarrow'
    pongBlockCenter = pongBlockCenter -2;
    case 'rightarrow'
        pongBlockCenter = pongBlockCenter +2;
end
end


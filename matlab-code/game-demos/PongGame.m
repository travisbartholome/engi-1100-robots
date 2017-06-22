% June 21, 2017 - Travis Bartholome
% Taking a break from robot interaction to try to design a simple game that
%   could familiarize students with the programming concepts we're trying
%   to use for robot control.

function PongGame()
    close all;
    
    % Define canvas size
    canvasWidth = 500;
    canvasHeight = 300;
    
    % Game variables
    fieldMargin = 10;
    playerX = 0 + fieldMargin;
    playerY = canvasHeight/2;
    cpuX = canvasWidth - fieldMargin;
    cpuY = canvasHeight/2;
    paddleLength = 50;
    paddleMoveDistance = 6;
    ballX = canvasWidth/2;
    ballY = canvasHeight/2;
    ballSpeedX = 10; % Note: these initial speeds will have to change.
    ballSpeedY = 25;

    % Set up the figure window
    gameFigure = figure('KeyPressFcn', @KeyPressCb);
    
    % Functions
    function UpdateGame()
        % Update game state
        % ***(Some stuff here, ball and CPU paddle movement.)***
        ballX = ballX + ballSpeedX;
        if ballX < playerX
            if (ballY < playerY + paddleLength/2 && ...
                    ballY > playerY - paddleLength/2)
                ballSpeedX = -ballSpeedX;
            else
                close(gameFigure);
                disp('* * * * * * * *');
                disp('* CPU wins... *');
                disp('* * * * * * * *');
            end
        elseif ballX > cpuX
            if (ballY < cpuY + paddleLength/2 && ...
                    ballY > cpuY - paddleLength/2)
                ballSpeedX = -ballSpeedX;
            else
                close(gameFigure);
                disp('* * * * * * * * *');
                disp('* Player wins!  *');
                disp('* * * * * * * * *');
            end
        end
        if ballY < fieldMargin || ballY > (canvasHeight - fieldMargin)
            ballSpeedY = -ballSpeedY;
        end
        ballY = ballY + ballSpeedY;
        % ***(Still need CPU paddle movement.)***
        
        
        % Update the plot
        hold off;
        % Plot the ball
        plot(ballX, ballY, 'ko', 'MarkerFaceColor', 'r', ...
            'LineWidth', 1.5, 'Color', 'r');
        hold on;
        axis([0 canvasWidth 0 canvasHeight]);
        % Player's paddle
        fplot(@(t) t.*0 + playerX, @(t) t.*1, ...
            [playerY - paddleLength/2, playerY + paddleLength/2], ...
            'LineWidth', 3, 'Color', 'k');
        % Computer's paddle
        fplot(@(t) t.*0 + cpuX, @(t) t.*1, ...
            [cpuY - paddleLength/2, cpuY + paddleLength/2], ...
            'LineWidth', 3, 'Color', 'k');
        % Note: this is just a way to use fplot for vertical lines.
    end
    
    function KeyPressCb(~, data)
        needUpdate = 1;
        switch data.Key
            % Handle keypresses
            case 'uparrow'
                if playerY < (canvasHeight - paddleLength / 2)
                    playerY = playerY + paddleMoveDistance;
                end
            case 'downarrow'
                if playerY > (paddleLength / 2)
                    playerY = playerY - paddleMoveDistance;
                end
            otherwise
                % Don't update for irrelevant keypresses.
                needUpdate = 0;
        end
        
        if needUpdate
            UpdateGame();
        end
    end

    % Start game
    UpdateGame();
end
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
    ballX = canvasWidth/2;
    ballY = canvasHeight/2;
    ballSpeedX = 0; % Note: these initial speeds will have to change.
    ballSpeedY = 0;

    % Set up the figure window
    gameFigure = figure('KeyPressFcn', @KeyPressCb, ...
        'KeyReleaseFcn', @KeyReleaseCb);
    axis([0 canvasWidth 0 canvasHeight]);
    
    % Functions
    function UpdateGame()
        % Update game state
        % ***(Some stuff here, ball and CPU paddle movement.)***
        
        % Update the plot
        hold on;
        % Plot the ball
        plot(canvasWidth/2, canvasHeight/2, 'ko', ...
            'MarkerFaceColor', 'r', 'LineWidth', 1.5, 'Color', 'r');
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
        switch data.Key
            % Handle keypresses
        end
    end

    function KeyReleaseCb(~, data)
        % Do I really even want a KeyRelease listener for this game?
        disp(data.Key); % Temporary.
    end

    % Start game
    UpdateGame();
end
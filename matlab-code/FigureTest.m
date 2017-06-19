% June 19, 2017 - Travis Bartholome
% Experimenting with the figure class as a means of controlling the robot
% in real-time, manually. First attempts.

% The figure class has several listeners for keyboard interaction.
% See `doc figure` for more information.

function FigureTest() % Run this in the command window
    % Connect to EV3
    myLEGO = legoev3('usb');
    
    % Establish motor ports
    leftMotorPort = 'A';
    rightMotorPort = 'D';
    clawMotorPort = 'B';
    
    % Connect to motors
    leftMotor = motor(myLEGO, leftMotorPort);
    rightMotor = motor(myLEGO, rightMotorPort);
    clawMotor = motor(myLEGO, clawMotorPort);
    
    % Load and display instruction, create figure
    instructionImage = imread('../resources/figure_test_driving_instructions.png');
    % Set the figure to listen for keypresses and use a callback
    % Basic callback: @(fig,data) disp(data.Key)
    controlFigure = figure('KeyPressFcn', @KeyPressCallback);
    image(instructionImage);
    axis image;
    truesize(controlFigure);
    
    % Define necessary functions
    function KeyPressCallback(~, data)
        % data.Key contains which key was pressed
        switch data.Key
            case 'uparrow'
                % Drive forward
                leftMotor.Speed = 20;
                rightMotor.Speed = 20;
                start(leftMotor);
                start(rightMotor);
            case 'downarrow'
                % Drive backward
                leftMotor.Speed = -20;
                rightMotor.Speed = -20;
                start(leftMotor);
                start(rightMotor);
            case 'q'
                % Open claw
                clawMotor.Speed = 20;
                start(clawMotor);
            case 'e'
                % Close claw
                clawMotor.Speed = -20;
                start(clawMotor);
            case 'space'
                % Stop everything
                stop(leftMotor);
                stop(rightMotor);
                stop(clawMotor);
            otherwise
                fprintf('Unsupported key: %s \n', data.Key);
        end
    end

    % Cleanup
    clear myLEGO;
end
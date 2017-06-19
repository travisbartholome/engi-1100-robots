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
        switch data.Key
            case 'uparrow'
                leftMotor.Speed = 20;
                rightMotor.Speed = 20;
                start(leftMotor);
                start(rightMotor);
            case 'downarrow'
                leftMotor.Speed = -20;
                rightMotor.Speed = -20;
                start(leftMotor);
                start(rightMotor);
            case 'q'
                clawMotor.Speed = 20;
                start(clawMotor);
            case 'e'
                clawMotor.Speed = -20;
                start(clawMotor);
            case 'space'
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
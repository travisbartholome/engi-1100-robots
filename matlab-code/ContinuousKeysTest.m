% June 20, 2017 - Travis Bartholome
% Experimenting with making driving easier and more like what we had set up
%   with previous robots.
% Ideally, this will allow me to execute commands only when keys are
%   currently pressed, then stop when those keys are lifted up.
% This will still be using the figure class to implement manual controls.

function ContinuousKeysTest() % Run this in the command window
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
    
    % Global boolean variables to track key status
    % Initialize all to 0 - no keys are initially "being pressed"
    upArrowPressed = 0;
    downArrowPressed = 0;
    qPressed = 0;
    ePressed = 0;
    
    % Load and display instruction, create figure
    % Any image would work here:
    instructionImage = imread('../resources/figure_test_driving_instructions.png');
    % Set the figure to listen for keypress and keyrelease events
    controlFigure = figure('KeyPressFcn', @KeyPressCallback, ...
        'KeyReleaseFcn', @KeyReleaseCallback);
    image(instructionImage);
    % Just cosmetic stuff, not essential:
    axis image;
    truesize(controlFigure);
    
    % Define control functions
    % MotorControl will be called to modify the state variables (which keys
    %   are pressed) any time a key is pressed or released.
    function MotorControl()
        % Control wheel movement
        if upArrowPressed
            if downArrowPressed
                % If up and down are both pressed, don't move.
                leftMotor.Speed = 0;
                rightMotor.Speed = 0;
            else
                % Drive forward
                leftMotor.Speed = 20;
                rightMotor.Speed = 20;
                start(leftMotor);
                start(rightMotor);
            end
        elseif downArrowPressed
            % Drive backward
            leftMotor.Speed = -20;
            rightMotor.Speed = -20;
            start(leftMotor);
            start(rightMotor);
        else
            % If no movement keys are pressed, stop the wheels.
            stop(leftMotor);
            stop(rightMotor);
        end
        
        % Control claw movement:
        if qPressed
            if ePressed
                clawMotor.Speed = 0;
            else
                % Open claw
                clawMotor.Speed = 20;
                start(clawMotor);
            end
        elseif ePressed
            % Close claw
            clawMotor.Speed = -20;
            start(clawMotor);
        else
            % If no claw keys are pressed, stop the claw.
            stop(clawMotor);
        end
    end
    
    % KeyPressCallback will set a given key status to 1 when that
    %   key is being pressed, then call MotorControl.
    function KeyPressCallback(~, data)
        switch data.Key
            case 'uparrow'
                upArrowPressed = 1;
            case 'downarrow'
                downArrowPressed = 1;
            case 'q'
                qPressed = 1;
            case 'e'
                ePressed = 1;
            case 'space'
                % Stop everything
                stop(leftMotor);
                stop(rightMotor);
                stop(clawMotor);
                % Set all status indicators to 0, just in case
                upArrowPressed = 0;
                downArrowPressed = 0;
                qPressed = 0;
                ePressed = 0;
            otherwise
                fprintf('Unsupported key: %s \n', data.Key);
        end
        MotorControl();
    end
    
    % KeyReleaseCallback will set a given key status to 0 when
    %   that key is released, then call MotorControl.
    function KeyReleaseCallback(~, data)
        switch data.Key
            case 'uparrow'
                upArrowPressed = 0;
            case 'downarrow'
                downArrowPressed = 0;
            case 'q'
                qPressed = 0;
            case 'e'
                ePressed = 0;
            otherwise
        end
        MotorControl();
    end

    % Cleanup
    clear myLEGO;
end
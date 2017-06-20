% June 20, 2017 - Travis Bartholome
% Refining the manual driving mechanism I made earlier today.

function ContinuousMotors() % Run this in the command window
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
    leftArrowPressed = 0;
    rightArrowPressed = 0;
    qPressed = 0;
    ePressed = 0;
    
    % Motor power levels - these are up to the user.
    % Absolute value should range from 0-100.
    powerLevel1 = 20;
    powerLevel2 = 45;
    powerLevel3 = 70;
    motorPower = powerLevel1; % Initially set a low motor power
    clawPower = 35; % Just keep the claw power constant
    
    % Load and display instruction, create figure
    % Any image would work here:
    instructionImage = imread('../resources/manual_driving_instructions.png');
    % Set the figure to listen for keypress and keyrelease events
    controlFigure = figure('KeyPressFcn', @KeyPressCallback, ...
        'KeyReleaseFcn', @KeyReleaseCallback);
    image(instructionImage);
    % Just cosmetic stuff, not essential:
    axis image;
    truesize(controlFigure);
    
    % Start the motors:
    start(leftMotor);
    start(rightMotor);
    start(clawMotor);
    % To "stop" them temporarily in the code, use `xMotor.Speed = 0`
    %   instead of using `stop(xMotor)`.
    
    % Define control functions
    % MotorControl will be called to modify the motors based on the state
    %   variables (which keys are pressed).
    % This happens any time a key is pressed or released.
    function MotorControl()
        % Control wheel movement
        if leftArrowPressed
            if ~rightArrowPressed
                % If left and right are both pressed, don't turn.
                % If not, turn left.
                leftMotor.Speed = -motorPower;
                rightMotor.Speed = motorPower;
            end
        elseif rightArrowPressed
            % Turn right
            leftMotor.Speed = motorPower;
            rightMotor.Speed = -motorPower;
        elseif upArrowPressed
            if downArrowPressed
                % If up and down are both pressed, don't move.
                leftMotor.Speed = 0;
                rightMotor.Speed = 0;
            else
                % Drive forward
                leftMotor.Speed = motorPower;
                rightMotor.Speed = motorPower;
            end
        elseif downArrowPressed
            % Drive backward
            leftMotor.Speed = -motorPower;
            rightMotor.Speed = -motorPower;
        else
            % If no movement keys are pressed, stop the wheels.
            leftMotor.Speed = 0;
            rightMotor.Speed = 0;
        end
        
        % Control claw movement
        if qPressed
            if ePressed
                % If both claw keys are pressed, don't move the claw.
                clawMotor.Speed = 0;
            else
                % Open claw
                clawMotor.Speed = clawPower;
            end
        elseif ePressed
            % Close claw
            clawMotor.Speed = -clawPower;
        else
            % If no claw keys are pressed, stop the claw.
            clawMotor.Speed = 0;
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
            case 'leftarrow'
                leftArrowPressed = 1;
            case 'rightarrow'
                rightArrowPressed = 1;
            case 'q'
                qPressed = 1;
            case 'e'
                ePressed = 1;
            otherwise
        end
        MotorControl();
    end
    
    % KeyReleaseCallback will set a given key status to 0 when
    %   that key is released, then call MotorControl.
    function KeyReleaseCallback(~, data)
        switch data.Key
            % Movement control
            case 'uparrow'
                upArrowPressed = 0;
            case 'downarrow'
                downArrowPressed = 0;
            case 'leftarrow'
                leftArrowPressed = 0;
            case 'rightarrow'
                rightArrowPressed = 0;
                
            % Claw control
            case 'q'
                qPressed = 0;
            case 'e'
                ePressed = 0;
                
            % Add "power levels" for motors
            case '1'
                motorPower = powerLevel1;
            case '2'
                motorPower = powerLevel2;
            case '3'
                motorPower = powerLevel3;
                
            % Anything else?
            otherwise
        end
        MotorControl();
    end
end
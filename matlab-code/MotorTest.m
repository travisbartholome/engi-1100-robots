% June 19, 2017 - Travis Bartholome
% First experiments using motors with MATLAB and the LEGO EV3.

% Looking through the docs, it seems like the motor control is meant to be
% done with commands, not with synchronous code?
% But that's no fun.
function MotorTest() % Call from the command window
    % Connect to the EV3
    myLEGO = legoev3('usb');

    % Establish the various motor ports
    leftMotorPort = 'A';
    rightMotorPort = 'D';
    clawMotorPort = 'B';

    % Connect to motors
    leftMotor = motor(myLEGO, leftMotorPort);
    rightMotor = motor(myLEGO, rightMotorPort);
    clawMotor = motor(myLEGO, clawMotorPort);
    
    % How long will each motor run last?
    runTime = 2; % In seconds

    % Run motors using timers
    % Note: TimerFcn will run twice, once at the start and again at the
    % end of the timer. There's probably a better way to do this, but I'm
    % not seeing it at the moment.
    % StopFcn should always shut down all the motors, then.
    % ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    % Move forward:
    forwardTimer = timer('ExecutionMode', 'fixedRate', ...
        'Period', runTime, ...
        'TasksToExecute', 2, ...
        'StopFcn', @(~,~) StopMotors(), ...
        'TimerFcn', @(~,~) MoveForward());
    start(forwardTimer);
    wait(forwardTimer);
    delete(forwardTimer);
    % Move backward:
    backwardTimer = timer('ExecutionMode', 'fixedRate', ...
        'Period', runTime, ...
        'TasksToExecute', 2, ...
        'StopFcn', @(~,~) StopMotors(), ...
        'TimerFcn', @(~,~) MoveBackward());
    start(backwardTimer);
    wait(backwardTimer);
    delete(backwardTimer);
    % Spin around:
    spinTimer = timer('ExecutionMode', 'fixedRate', ...
        'Period', runTime, ...
        'TasksToExecute', 2, ...
        'StopFcn', @(~,~) StopMotors(), ...
        'TimerFcn', @(~,~) SpinAround());
    start(spinTimer);
    wait(spinTimer);
    delete(spinTimer);
    
    % Timer functions
    function MoveForward()
        leftMotor.Speed = 20;
        rightMotor.Speed = 20;
        start(leftMotor);
        start(rightMotor);
    end

    function MoveBackward()
        leftMotor.Speed = -20;
        rightMotor.Speed = -20;
        start(leftMotor);
        start(rightMotor);
    end

    function SpinAround()
        leftMotor.Speed = 50;
        rightMotor.Speed = -50;
        start(leftMotor);
        start(rightMotor);
    end

    function StopMotors()
        stop(leftMotor);
        stop(rightMotor);
        stop(clawMotor);
    end

    % Cleanup
    clear myLEGO;
end
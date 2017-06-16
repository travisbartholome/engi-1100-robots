% June 16, 2017 - Travis BArtholome
% Trying to work out a good way to get continuous updates of sensor values
%   using the MATLAB API for Mindstorms EV3.
% As of right now, I'm just connecting to the EV3 brick via USB.
% Note: The docs for the timer object suggest that I should avoid using
%   timers for real-time applications. What do they suggest to use instead?

function ContinuousSensors() % Call this from the command window
    % Create connection to EV3
    myLEGO = legoev3('usb'); % NOTE: May need to change connection type.
    
    % Get sensor handles
    touchPort = 1;
    myTouch = touchSensor(myLEGO, touchPort);
    USPort = 2;
    myUS = sonicSensor(myLEGO, USPort);
    
    % Setting up timer object
    readingsPerSecond = 2; % Number of sensor readings per second. < 1000.
    numSeconds = 10; % Arbitrary. May want to change this.
    myTimer = timer('ExecutionMode', 'FixedRate', ...
        'Period', 1/readingsPerSecond, ...
        'StopFcn', @(~,~) StopTimer, ...
        'TimerFcn', @(~,~) SensorCallback, ...
        'TasksToExecute', readingsPerSecond * numSeconds);
    % Execute timer
    start(myTimer);
    
    % Function to get sensor data
    function SensorCallback
        fprintf('Touch sensor: %d \n', readTouch(myTouch));
        fprintf('Ultrasonic sensor: %f \n\n', readDistance(myUS));
    end
    
    % Cleanup when the timer stops - to avoid errors where the
    % connection to the EV3 brick persists. I've been having to restart
    % MATLAB to fix this issue.
    function StopTimer
        clear myLEGO;
        disp('EV3 connection cleared.');
        delete(myTimer);
        % If this doesn't work, try using `clear all` in the command
        % window, maybe? I haven't tested that since this seems to be
        % working, but the occasion may arise.
    end
end
% June 19, 2017 - Travis Bartholome
% Continuous sensor updates with touch, ultrasonic, and color sensors.

function ContinuousWithColor() % Call this from the command window
    % Create connection to EV3
    myLEGO = legoev3('usb'); % NOTE: May need to change connection type.
    
    % Get sensor handles
    touchPort = 1;
    myTouch = touchSensor(myLEGO, touchPort);
    USPort = 2;
    myUS = sonicSensor(myLEGO, USPort);
    colorPort = 3;
    myColor = colorSensor(myLEGO, colorPort);
    
    % Setting up timer object
    readingsPerSecond = 2; % Number of sensor readings per second. < 1000.
    numSeconds = 10; % Arbitrary.
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
        fprintf('Ultrasonic sensor: %f \n', readDistance(myUS));
        fprintf('Color sensor: %s \n\n', readColor(myColor));
    end
    
    % Cleanup when the timer stops
    function StopTimer
        clear myLEGO;
        disp('EV3 connection cleared.');
        delete(myTimer);
        % If there's a connection error: disconnect, `clear all`, reconnect
    end
end
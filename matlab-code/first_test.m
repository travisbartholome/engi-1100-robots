% June 14, 2017 - Travis Bartholome
% First test of the MATLAB API for LEGO Mindstorms EV3.
% Looking into this as a possible alternative to the BrickPi that we're
%   currently using for ENGI 1100H.

%% Installing the LEGO Mindstorms EV3 support package
% Navigate to this website to download the package installer. There are
% directions on the website for various ways to install.
% https://www.mathworks.com/hardware-support/lego-mindstorms-ev3-matlab.html

%% Connecting to EV3 brick
% USB
brick = legoev3('usb'); % Variable name is arbitrary as always.

% WiFi - not tested yet
% 1. Need LEGO WiFi thing.
%       LEGO Recommended: NETGEAR N150 Wireless Adapter (WNA1100). $20 each. Yikes.
% 2. Settings => WiFi, then connect to network.
% 3. Settings => Brick Info, get the IP address and hardware ID. Keep these
%       saved somewhere.
% 4. Ping the brick using cmd (ping xx.xx.xx.xx)
% 5. brick = legoev3('wifi', ip, hardwareID);

% Note: there's also a Bluetooth option.

% Test with the `beep` command
beep(brick);

% All of this information is in the documentation page:
% "Getting Started with MATLAB® Support Package for LEGO® MINDSTORMS® EV3™
% Hardware"

% This basic thing works for me with USB, June 14.

%% Other Basics

% Writing to the screen
clearLCD(brick);
writeLCD(brick, 'Hello MATLAB!');

% Changing the status light color
writeStatusLight(brick, 'orange'); % Off, red, green, orange

% Reading status of the buttons
buttonStr = 'down'; % Up, down, left, right, center
buttonStatus = readButton(brick, buttonStr); % 0 or 1 (boolean)
fprintf('Status of the %s button is %d. \n\n', buttonStr, buttonStatus);

%% Sensors and Stuff - June 16, 2017

% Touch Sensor
touchPort = 1; % Port the touch sensor is using
myTouch = touchSensor(brick, touchPort); % Get a handle/object for the sensor
touchValue = readTouch(myTouch); % Get sensor value (0 or 1)
fprintf('The value of the touch sensor is %d. \n\n', touchValue);

% Note: this only reads the value a single time, whenever you execute the
% program. I'll have to do some work to make it run continuously. The
% `timer` object seems like a good place to start -- similar to that meme I
% made with Fritz's picture and Starry Night.

% This seems to be working well for what it is, though.

% Ultrasonic Sensor
USPort = 2; % Port for ultrasonic (US) sensor
myUS = sonicSensor(brick, USPort);
USValue = readDistance(myUS); % Distance in meters
fprintf('The ultrasonic sensor is %f m from the nearest object. \n\n', ...
    USValue);

% Ultrasonic also seems to be working well. Best, I can get good readings
% from both the US and touch sensors at the same time.

% I'm going to move to a new file and start trying to continuously update
% sensors.

%% (Cleanup)
clear; close all

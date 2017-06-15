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

clearLCD(brick);
writeLCD(brick, 'Hello MATLAB!');

writeStatusLight(brick, 'orange'); % Off, red, green, orange

%% Sensors and Stuff



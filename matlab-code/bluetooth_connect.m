% June 20, 2017 - Travis Bartholome
% Figuring out how to connect to the EV3 over Bluetooth

% For everyone: use `doc legoev3` for basic instructions.

%% Using Windows 10
% https://www.mathworks.com/help/supportpkg/legomindstormsev3io/ug/connect-to-an-ev3-brick-over-bluetooth-using-windows-1.html
%{
1. On the EV3, navigate to the rightmost menu (with the wrench).
2. Use the down arrow to navigate to the "Bluetooth" option.
3. Select Bluetooth with the center button, then make sure the "Bluetooth"
    and "Visibility" boxes are checked in the window that appears.
4. Open "Bluetooth and other device settings" on your computer.
5. Turn your computer's Bluetooth visibility on (if it isn't already).
6. At the top of the menu, click the button to add a device. Select
    "Bluetooth" as the device type.
7. The search should show a device named "EV3" (or whatever your brick's
    name is). Connect to this device.
8. Go back to the EV3, where a window should have appeared. Choose
    "Connect," then set a very temporary passkey (this can be anything you
    want).
9. Go back to your computer and re-enter the passkey. This should connect
    the computer and the EV3.
10. In your computer's Bluetooth settings, select "More Bluetooth options."
11. Go to the "COM Ports" tab. Find the port with the name "EV3 'Serial
    Port'" (I'm not sure if this changes based on the name of the brick,
    so you may have a different name of the form "ROBOTNAME 'Serial Port'",
    or something like that. This is pure speculation, don't listen to me.)
12. In MATLAB, connect to the EV3 using
    `mylego = legoev3('Bluetooth', 'COM#');`, where 'COM#' is the port
    number you just found in your Bluetooth settings (e.g., 'COM3').
%}

myLEGO = legoev3('Bluetooth', 'COM3');
% myLEGO = legoev3('bt', '0016534EE751'); % Also tried this, still failing
disp(myLEGO)
% June 22, 2017 - As of right now, this is *not* working for me. -Travis
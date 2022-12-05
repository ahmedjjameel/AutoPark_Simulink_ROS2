function exampleHelperROSValetModelCallbacks(callbackType)
%exampleHelperROSValetModelCallbacks Callbacks for ROS Automated Valet
%Simulink Models for ROS and ROS 2.

switch (lower(callbackType))
    case 'preloadfcn'
    case 'startfcn'
        % close existing plots before starting the model
        closeAllROSValetParkingPlots();
    case 'closefcn'
        closeAllROSValetParkingPlots();
    case 'stopfcn'
        evalin('base','clear exampleHelperROSValetSLVisualizePath');
    otherwise
end

end



function closeAllROSValetParkingPlots()
allROSValetPlotHandles = findall(0,"type","Figure","Name", "ROS Automated Parking Valet (Simulink)");
close(allROSValetPlotHandles);
end
function exampleHelperROS2ValetStartSimulation()
% EXAMPLEHELPERROS2VALETSTARTSIMULATION
behavioralModel = 'ROS2ValetBehavioralPlannerExample';
pathPlannerModel = 'ROS2ValetPathPlannerExample';
controllerModel = 'ROS2ValetControllerExample';
vehicleModel = 'ROS2ValetVehicleExample';
modelNames = {behavioralModel, pathPlannerModel, controllerModel, vehicleModel};
pacingRates = [0.25 0.25 0.6 3];
% Open all the models
open_system(behavioralModel);
open_system(pathPlannerModel);
open_system(controllerModel);
open_system(vehicleModel);

% Set the model view
scrSize = get(0, 'screensize');
h = scrSize(4);
w = scrSize(3);

set_param(behavioralModel,'Location', [1 1 w/2-5 h/2-5]);
set_param(pathPlannerModel,'Location', [w/2+5 1 w-5 h/2-5]);
set_param(controllerModel,'Location', [1 h/2+5 w/2-5 h-5]);
set_param(vehicleModel,'Location', [w/2+5 h/2+5 w-5 h-5]);

for i=1:numel(modelNames)
    startModel(modelNames{i},pacingRates(i));
end

for i=1:numel(modelNames)
    % Start all the models together to synchronize simulation
    set_param(modelNames{i}, 'SimulationCommand','continue');
end

waitForModelToStop(modelNames{end});
waitForModelToStop(modelNames{1});
end

function startModel(modelName, pacingRate)
open_system(modelName);

set_param(modelName, 'EnablePacing', 'on');
set_param(modelName, 'PacingRate', pacingRate);
% Start and pause at first step
set_param(modelName, 'SimulationCommand', 'stepforward');
waitForModelToStart(modelName);
end

function waitForModelToStart(modelName)
while (~isequal(get_param(modelName, 'SimulationStatus'), 'paused'))
    pause(1);
end
end


function waitForModelToStop(modelName)
while (~isequal(get_param(modelName, 'SimulationStatus'), 'stopped'))
    pause(1);
end
end
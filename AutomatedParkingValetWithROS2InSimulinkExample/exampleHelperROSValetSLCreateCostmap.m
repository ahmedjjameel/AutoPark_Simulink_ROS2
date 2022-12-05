function costmap = exampleHelperROSValetSLCreateCostmap()
% exampleHelperROSValetSLCreateCostmap create a costmap for a parking lot.

% Copyright 2019 The MathWorks, Inc.

% Load occupancy maps corresponding to 3 layers - obstacles, road
% markings, and used spots.
mapLayers.StationaryObstacles = imread('exampleHelperROSValetStationary.bmp');
mapLayers.RoadMarkings        = imread('exampleHelperROSValetRoadMarkings.bmp');
mapLayers.ParkedCars          = imread('exampleHelperROSValetParkedCars.bmp');

% Combine map layers struct into a single vehicleCostmap.
combinedMap = mapLayers.StationaryObstacles + mapLayers.RoadMarkings + ...
    mapLayers.ParkedCars;
combinedMap = im2single(combinedMap);

res = 0.5; % meters
costmap = vehicleCostmap(combinedMap, 'CellSize', res);
costmap.CollisionChecker.NumCircles = 2;
end
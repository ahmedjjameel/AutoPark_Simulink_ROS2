function exampleHelperROSValetLoadLocalizationData
evalin('base','costmap = exampleHelperROSValetSLCreateCostmap();');
evalin('base','routeData = load(''rosAutomatedValetRoutePlanSL.mat'');');
evalin('base','routePlan= routeData.routePlan;');
evalin('base','startPose = routePlan.StartPose(1, :);');
evalin('base','exampleHelperROSValetSLCreateUtilityBus;');
evalin('base','[vehicleDimsStruct,costmapStruct]= exampleHelperROSValetSLCreateUtilityStruct(costmap);');
evalin('base','spot=4;');
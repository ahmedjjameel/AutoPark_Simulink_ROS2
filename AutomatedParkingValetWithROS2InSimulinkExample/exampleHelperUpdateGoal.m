function exampleHelperUpdateGoal(spot)
if spot==1
    evalin('base','load(''location1.mat'');');
elseif spot==2
    evalin('base','load(''location2.mat'');');
elseif spot==3
    evalin('base','load(''location3.mat'');');
else
    evalin('base','load(''location4.mat'');');
end
evalin('base','routeData.routePlan = routePlan;');
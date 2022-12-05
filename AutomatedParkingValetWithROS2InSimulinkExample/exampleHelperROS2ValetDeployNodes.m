function exampleHelperROS2ValetDeployNodes()
behavioralModel = 'ROS2ValetBehavioralPlannerExample';
pathPlannerModel = 'ROS2ValetPathPlannerExample';
controllerModel = 'ROS2ValetControllerExample';
modelNames = {behavioralModel,pathPlannerModel,controllerModel};
for ii=1:numel(modelNames)
    % Load the model
    load_system(modelNames{ii});
    % Generate and deploy standalone application for the model
    slbuild(modelNames{ii});
end
% wait for topics to appear on ROS 2 network
waitForTopicToAppear('/steeringangle')

end

function waitForTopicToAppear(topicName)
allTopics = ros2('topic','list');
while (~ismember(topicName, allTopics))
    pause(1);
    allTopics = ros2('topic','list');
end
end
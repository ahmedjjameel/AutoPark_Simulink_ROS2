## Automated Parking Valet with ROS 2 in Simulink

This example shows how to distribute the Automated Parking Valet application among various nodes in a ROS 2 network in Simulink® and deploy them as standalone ROS 2 nodes. Using the Simulink model in the Automated Parking Valet in Simulink example, tune the planner, controller and vehicle dynamic parameters before partitioning the model into ROS 2 nodes.

![fig1](https://user-images.githubusercontent.com/81799459/205687994-2dff0c20-e960-4ad2-91b3-54a1b6bcaf7b.jpg)


This example concentrates on simulating the Planning, Control and the Vehicle components. For Localization, this example uses pre-recorded localization map data. The Planning component is further divided into Behavior planner and Path Planner components. This results in a ROS 2 network comprised of four ROS 2 nodes: Behavioral Planner, Path Planner, Controller and Vehicle. The following figure shows the relationships between each ROS 2 node in the network and the topics used in each.

![fig2](https://user-images.githubusercontent.com/81799459/205688079-0ffb617f-a60b-4bc7-b4ec-31283e5a4803.jpg)


### Explore the Simulink ROS 2 nodes and connectivity

Observe the division of the components into four separate Simulink models. Each Simulink model represents a ROS 2 node.

![fig3](https://user-images.githubusercontent.com/81799459/205688147-f8ea4d48-336d-4460-8134-079f1cb72599.jpg)


1. Open the vehicle model.
open_system('ROS2ValetVehicleExample');
2. The Subscribe subsystem contains the ROS 2 Subscribe blocks that read input data from the Controller node.
3. The Vehicle model subsystem contains a Bicycle Model (Automated Driving Toolbox) block, Vehicle Body 3DOF, to simulate the vehicle controller effects and sends the vehicle information over the ROS 2 network through ROS 2 Publish blocks in the Publish subsystem.

### Behavioral Planner Node

![fig4](https://user-images.githubusercontent.com/81799459/205688252-9685e325-ef0d-49aa-b9d4-1ffeadaf1ebe.jpg)

1. Open the behavioral planner model.
open_system('ROS2ValetBehavioralPlannerExample');
2. This model reads the current vehicle information from ROS 2 network, sends the next goal and checks if the vehicle has reached the final pose of the segment using rosAutomatedValetHelperGoalChecker.
3. The Behavioral Planner and Goal Checker subsystem runs when a new message is available on either /currentvel or /currentpose.
4. The model sends the status if the vehicle has reached the final parking goal using the /reachgoal topic, which uses a std_msgs/Bool message type. All the models stop simulation when this message is true.

### Path Planner Node

![fig5](https://user-images.githubusercontent.com/81799459/205688565-1db4a347-6aa1-4664-b8bb-c56aa778464f.jpg)

1. Open the path planner model.
open_system('ROS2ValetPathPlannerExample');
2. This model plans a feasible path through the environment map using a pathPlannerRRT (Automated Driving Toolbox) object, which implements the optimal rapidly exploring random tree (RRT*) algorithm and sends the plan to the controller over the ROS 2 network.
3. The Path Planner subsystem runs when a new message is available on /plannerConfig or /nextgoal topics.

### Controller Node


![fig6](https://user-images.githubusercontent.com/81799459/205688732-99270bd6-654b-4a10-9e83-e9fb4299e3ee.jpg)

1. Open the vehicle controller model.
open_system('ROS2ValetControllerExample');
2. This model calculates and sends the steering and velocity commands over the ROS 2 network.
3. The Controller subsystem runs when a new message is available on the /velprofile topic.


### Simulate the ROS 2 nodes to verify partitioning

Verify that the behavior of the model remains the same after partitioning the system into four ROS 2 nodes.
1. Load the pre-recorded localization map data in MATLAB base workspace using the exampleHelperROSValetLoadLocalizationData helper function.
exampleHelperROSValetLoadLocalizationData;
2. Open the simulation model.
open_system('ROS2ValetSimulationExample.slx');
In the left parking selection area, you can also select a spot. The default parking spot is the sixth spot at the top row.
3. In the SIMULATION tab, click Run from SIMULATE section or run sim('ROS2ValetSimulationExample.slx') in MATLAB Command Window. A figure opens and shows how the vehicle tracks the reference path. The blue line represents the reference path while the red line is the actual path traveled by the vehicle. Simulation for all the models stop when the vehicle reaches the final parking spot.
sim('ROS2ValetSimulationExample.slx');


![fig7](https://user-images.githubusercontent.com/81799459/205690313-9e46b8da-88fb-41a7-91e9-4c2cb11f5e02.gif)



### Simulation Results

The Visualization subsystem in vehicle model generates the results for this example.
open_system('ROS2ValetVehicleExample/Vehicle model/Visualization');
The visualizePath block is responsible for creating and updating the plot of the vehicle paths shown previously. The vehicle speed and steering commands are displayed in a scope.
open_system("ROS2ValetVehicleExample/Vehicle model/Visualization/Commands")

![fig8](https://user-images.githubusercontent.com/81799459/205689423-329e8c18-3504-4e63-9cbb-48d207fe2877.jpg)



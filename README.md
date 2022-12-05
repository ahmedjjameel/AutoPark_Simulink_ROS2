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


### Deploy ROS 2 Nodes

Generate ROS 2 applications for Behavioral Planner, Path planner and Controller nodes. Simulate the Vehicle node in MATLAB and compare the results with simulation.
Generate and deploy Behavioral Planner, Path Planner and Controller node applications using exampleHelperROS2ValetDeployNodes helper function. The helper function calls slbuild (Simulink) command with the name of the Simulink model as input argument, for each model, to generate C++ code and deploy the application on the host computer.
exampleHelperROS2ValetDeployNodes(); % generate C++ code and deploy the application for ROS 2 nodes
### Starting build procedure for: ROS2ValetBehavioralPlannerExample
### Generating code and artifacts to 'Model specific' folder structure
### Generating code into build folder: C:\Users\joshchen\OneDrive - MathWorks\Documents\MATLAB\Examples\ros-ex88924338\ROS2ValetBehavioralPlannerExample_ert_rtw
### Generated code for 'ROS2ValetBehavioralPlannerExample' is up to date because no structural, parameter or code replacement library changes were found.
### Evaluating PostCodeGenCommand specified in the model
### Using toolchain: Colcon Tools
### Building 'ROS2ValetBehavioralPlannerExample': all
Running colcon build in folder 'C:/Users/joshchen/OneDrive - MathWorks/Documents/MATLAB/Examples/ros-ex88924338'.Done.
Success
### Successfully generated all binary outputs.
### Successful completion of build procedure for: ROS2ValetBehavioralPlannerExample
### Creating HTML report file ROS2ValetBehavioralPlannerExample_codegen_rpt.html

Build Summary

Top model targets built:

Model                              Action         Rebuild Reason                           
===========================================================================================
ROS2ValetBehavioralPlannerExample  Code compiled  Compilation artifacts were out of date.  

1 of 1 models built (0 models already up to date)
Build duration: 0h 1m 32.504s
### Starting build procedure for: ROS2ValetPathPlannerExample
### Generating code and artifacts to 'Model specific' folder structure
### Generating code into build folder: C:\Users\joshchen\OneDrive - MathWorks\Documents\MATLAB\Examples\ros-ex88924338\ROS2ValetPathPlannerExample_ert_rtw
### Generated code for 'ROS2ValetPathPlannerExample' is up to date because no structural, parameter or code replacement library changes were found.
### Evaluating PostCodeGenCommand specified in the model
### Using toolchain: Colcon Tools
### Building 'ROS2ValetPathPlannerExample': all
Running colcon build in folder 'C:/Users/joshchen/OneDrive - MathWorks/Documents/MATLAB/Examples/ros-ex88924338'.Done.
Success
### Successfully generated all binary outputs.
### Successful completion of build procedure for: ROS2ValetPathPlannerExample
### Creating HTML report file ROS2ValetPathPlannerExample_codegen_rpt.html

Build Summary

Top model targets built:

Model                        Action         Rebuild Reason                           
=====================================================================================
ROS2ValetPathPlannerExample  Code compiled  Compilation artifacts were out of date.  

1 of 1 models built (0 models already up to date)
Build duration: 0h 1m 53.874s
### Starting build procedure for: ROS2ValetControllerExample
### Generating code and artifacts to 'Model specific' folder structure
### Generating code into build folder: C:\Users\joshchen\OneDrive - MathWorks\Documents\MATLAB\Examples\ros-ex88924338\ROS2ValetControllerExample_ert_rtw
### Generated code for 'ROS2ValetControllerExample' is up to date because no structural, parameter or code replacement library changes were found.
### Evaluating PostCodeGenCommand specified in the model
### Using toolchain: Colcon Tools
### Building 'ROS2ValetControllerExample': all
Running colcon build in folder 'C:/Users/joshchen/OneDrive - MathWorks/Documents/MATLAB/Examples/ros-ex88924338'.Done.
Success
### Successfully generated all binary outputs.
### Successful completion of build procedure for: ROS2ValetControllerExample
### Creating HTML report file ROS2ValetControllerExample_codegen_rpt.html

Build Summary

Top model targets built:

Model                       Action         Rebuild Reason                           
====================================================================================
ROS2ValetControllerExample  Code compiled  Compilation artifacts were out of date.  

1 of 1 models built (0 models already up to date)
Build duration: 0h 2m 1.851s
Open the vehicle model and start simulation.
open_system("ROS2ValetVehicleExample"); 
set_param("ROS2ValetVehicleExample","SimulationCommand","start"); 
Verify that the results from simulation match with the deployed ROS 2 nodes.

#### References

[1] https://de.mathworks.com/help/ros/ug/automated-valet-using-ros2-simulink.html

[2] https://etheses.whiterose.ac.uk/26711/7/PhD%20thesis%20-%20Mohammed%20Al-Nuaimi.pdf

[3] https://d-nb.info/1261800761/34

[4] https://www.youtube.com/watch?v=xKyY7jK0GPw&ab_channel=MATLAB




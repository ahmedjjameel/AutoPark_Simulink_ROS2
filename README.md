## Automated Parking Valet with ROS 2 in Simulink

This example shows how to distribute the Automated Parking Valet application among various nodes in a ROS 2 network in Simulink® and deploy them as standalone ROS 2 nodes. Using the Simulink model in the Automated Parking Valet in Simulink example, tune the planner, controller and vehicle dynamic parameters before partitioning the model into ROS 2 nodes.

![fig1](https://user-images.githubusercontent.com/81799459/205684395-4bdba4d1-6a67-4279-abfd-1156f24c1187.jpg)

This example concentrates on simulating the Planning, Control and the Vehicle components. For Localization, this example uses pre-recorded localization map data. The Planning component is further divided into Behavior planner and Path Planner components. This results in a ROS 2 network comprised of four ROS 2 nodes: Behavioral Planner, Path Planner, Controller and Vehicle. The following figure shows the relationships between each ROS 2 node in the network and the topics used in each.

![fig2](https://user-images.githubusercontent.com/81799459/205684808-9b04f66c-dec5-4af1-b938-9de71949880d.jpg)





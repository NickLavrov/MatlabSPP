# MatlabSPP
Matlab example code for the Self Propelled Particle (SPPM) Model

This is a portion of the work I did on my senior thesis, A Dimensional
Reduction Analysis of the Self-Propelled Particle Model. Put simply, there are a number of particles or "locusts" on a 1-dimensional ring. At each time step, their motion is governed by one simple rule: update the velocity based on the average velocity of each particle within a certain interaction radius. This results in interesting behavior where the whole "swarm" will move clockwise, then switch to counterclockwise ater some time, and so forth. My thesis analyzed that behavior, focusing on the points where switches in direction occured

Here is what each file does in this selection of code:

## Functions
* SPPModel2.m - Outputs the positions and velocities of an SPP simulation
* initializedSpp.m - Outputs the positions and velocities of an SPP simulation with given initial conditions
* switchFrequency.m - Outputs how many times a switch occurs if the simulation is rerun multiple times with a given initial state
* switchPoints.m - Identifies where the switch points occur
* switchChecker.m - Verifies if a switch has occurred
 
## Executable Code
* plotPositionAlignment.m - Visualizes the results of SPPModel2.m
* plotSwitchesAndPercentages.m - Visualizes the results of switchFrequency.m

## Outputs (examples from running plotSwitchesAndPercentages.m)
* positions.fig - A Matlab figure showing the positions of all the locusts
* positions.png - A png file of the above
* positionszoom.fig - A Matlab fig file of the positions of all locusts near a switch point, demonstrating a change in direction
* positionszoom.png - A png file of the above
* alignment.png - The average velocity of the locusts at each time step. The red line represents the alignment and the marked switch points.
* switchPercent.png - The percentage of trials that result in a switch for a given number of steps before each the three marked switch points.
* average.png - An average of the above graph

## My senior thesis
* Lavrov_2015_SeniorThesis - My thesis, in which the above code played a critical role.
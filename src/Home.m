classdef Home
    %HOME Summary of this class goes here
    %   Detailed explanation goes here
    
   properties
        dest;
        robot;
        state; 
        HomePos = [0 0 0]; %This could be put in Robot and called from there, would be cleaner but doesn't matter
    end
    
    methods
        function obj = Home(destination, robot)
            obj.dest = destination;
            obj.robot = robot;
        end
        
        function update(obj)
            
            switch(obj.state)
                case subStates.INIT
                    obj.robot.pathPlanTo(obj.HomePos);
                    obj.state = subState.ARM_WAIT;
                    
                case subStates.ARM_WAIT
                    if obj.robot.isAtTarget() == 1
                        obj.state = subState.DONE;
                    end
                            
                case subStates.DONE
                    %Clear activeColor
                    
                otherwise
                    disp("ERROR in Travel State, Incorrect State Given");
            end
        end
    end
end


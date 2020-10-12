classdef Approach

     properties
        state;
        dest;
        orbList;
        Z_Offset = 50; %In mm
     end

    methods
        function obj = Approach(orblist)
            obj.orbList = orblist;
        end

        function [obj,robot] = update(obj, robot)

            switch(obj.state)
                case subStates.INIT
                    if OrbList.length > 0
                        obj.dest = obj.orbList.getActiveOrb().finalPos;
                        obj.dest(3) = obj.dest(3) + obj.Z_Offset;
                        robot.pathPlanTo();
                        obj.state = subState.ARM_WAIT;
                    end

                case subStates.ARM_WAIT
                    if OrbList.activeOrb.hasMoved == 1 || OrbList.length == 0
                        obj.state = subStates.INIT;
                    else
                        if robot.isAtTarget() == 1
                            obj.state = subState.DONE;
                        end
                    end

                case subStates.DONE

                otherwise
                    disp("ERROR in Home State, Incorrect State Given");
            end
        end
    end
end

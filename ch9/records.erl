-module(records).
-compile(export_all).

-record(robot, {name,
                type=industrial,
                hobbies,
                details=[]
                }).

first_robot() ->
    #robot{name="Mechatron",
            type=handmade,
            details=["Move by a small man inside"]}.

car_factory(CorpName) ->
    #robot{name=CorpName,hobbies="Build Cars"}.

repairman(Rob) ->
    Details = Rob#robot.details,
    NewRobot = Rob#robot{details=["Repaired by repairman"|Details]},
    NewRobot.
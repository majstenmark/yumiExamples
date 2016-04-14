MODULE Module1

VAR syncident sync1;
VAR syncident sync2;

VAR syncident syncMoveStart;
VAR syncident syncMoveStop;

TASK PERS wobjdata flangeRobL := [FALSE, FALSE, "ROB_L", [[0, 0, 0],[1, 0, 0, 0]],
                        [[0, 0, 0],[1, 0, 0, 0]]];

PERS tasks tasklist{2} := [["T_ROB_L"], ["T_ROB_R"]];
    
    CONST robtarget Target_10:=[[403.480954736,-390.917748918,198.627868762],[0.066008543,-0.842420529,-0.111215363,-0.523069468],[0,-1,1,11],[-131.267763506,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_20:=[[108.49884894,-560.713869962,585.950395417],[0.482100792,0.84524977,0.093430956,0.210718552],[-1,-1,1,11],[52.867718844,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_30:=[[515.201792615,-274.76395632,332.898973058],[0.223333883,0.604589633,0.76084106,-0.075592557],[-1,-1,1,11],[108.181150462,9E9,9E9,9E9,9E9,9E9]];
    CONST jointtarget home:=[[71.685096132,-108.499556211,7.78119312,-82.851253312,26.271291284,124.618317709],[-40.625736372,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40:=[[564.826087681,-37.302946144,467.082748463],[0.206056283,0.452572376,0.817289172,0.291131349],[-1,-1,1,11],[133.932998507,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_100:=[[548.048,-269.826,474.458],[0.057553352,0.809019405,0.584312555,0.027460014],[0,-1,1,11],[126.961442073,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_110:=[[548.048682659,-435.160668349,366.882735658],[0.057553278,0.809019337,0.584312696,0.027459187],[0,-1,0,11],[126.961371806,9E9,9E9,9E9,9E9,9E9]];
    
    PROC main()
        VAR robtarget tmp;
        !MoveAbsJ home,v1000,z100,tool0\WObj:=wobj0;
        !WaitSyncTask sync1, tasklist; ! This is a sync point, the motions for each arm are still "independent".
        
	    !MoveJ Target_20,v1000,z100,tool0\WObj:=wobj0;
        
	   ! MoveJ Target_30,v1000,z100,tool0\WObj:=wobj0;
       ! WaitSyncTask sync2, tasklist;
        
        ! [...]
        ! No the cool stuff starts ...
        SyncMoveOn syncMoveStart, tasklist;
        ! Syncrhonized motions, where motions with the same ID are carried out simultaniously,
        ! that is, they start and stop at the same time and the speed is thus changed.
        MoveJ Target_20\ID:=1, v1000, z50, tool0\WObj:=wobj0;
        MoveJ Target_110\ID:=2, v1000, fine, tool0\WObj:=wobj0;
        
        ! Now, let's go crazy :). Let the left hand be dominant and let the right follow the left with at constant offset.
     !   tmp := CRobT(\WObj:=flangeRobL);
        tmp := CRobT(\WObj:=flangeRobL);
        MoveJ tmp\ID:=3, v1000, fine, tool0\WObj:=flangeRobL;
        
        MoveJ tmp\ID:=4, v1000, fine, tool0\WObj:=flangeRobL; ! zone data has to be the same in both motions.
        
     !   MoveJ tmp\ID:=5, v1000, fine, tool0\WObj:=flangeRobL; ! zone data has to be the same in both motions.
        
        SyncMoveOff syncMoveStop;
        
    ENDPROC
    PROC Path_30()
        MoveL Target_100,v1000,z100,tool0\WObj:=wobj0;
		MoveL Target_110,v1000,z100,tool0\WObj:=wobj0;
    ENDPROC
    
ENDMODULE
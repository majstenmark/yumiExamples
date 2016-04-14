MODULE Module1
    
VAR syncident sync1;
VAR syncident sync2;

VAR syncident syncMoveStart;
VAR syncident syncMoveStop;  


 PERS tooldata tool1 := [TRUE, [[0, 0, 0], [1, 0, 0, 0]],
                        [0.001, [0, 0, 0.001],[1, 0, 0, 0], 0, 0, 0]];

PERS tasks tasklist{2} := [["T_ROB_L"], ["T_ROB_R"]];
    
	CONST robtarget Target_20:=[[184.988495526,570.159694654,484.135771027],[0.576608891,-0.801891481,0.084690926,-0.131604284],[0,1,-3,11],[-105.724645602,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_30:=[[429.234535335,436.98213993,386.649052941],[0.480516532,-0.698276112,0.529304569,-0.036756046],[0,1,-3,11],[-106.180312647,9E9,9E9,9E9,9E9,9E9]];
	CONST jointtarget home:=[[-88.59457497,-85.12227755,9.547940224,174.285677504,24.448452106,-226.129313154],[63.21741009,9E9,9E9,9E9,9E9,9E9]];
	CONST robtarget Target_150:=[[644.154387534,-66.552444228,497.393898651],[0.026282348,-0.80295123,0.595141922,-0.019612596],[-2,1,-2,11],[-161.505256797,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Target_40:=[[552.204300929,80.871949156,629.525504682],[0.374763626,-0.428003502,0.515082347,-0.641136025],[0,1,-3,11],[-143.896462089,9E9,9E9,9E9,9E9,9E9]];
	
    
    
    PROC main()
        
        MoveAbsJ home,v1000,z100,tool0\WObj:=wobj0;
       ! WaitSyncTask sync1, tasklist;  ! This is a sync point, the motions for each arm are still "independent".
        
	   ! MoveJ Target_20,v1000,z100,tool0\WObj:=wobj0;
        
	   ! MoveJ Target_30,v1000,z100,tool0\WObj:=wobj0;
        
	  !  MoveJ Target_40,v1000,z100,tool0\WObj:=wobj0;
      !  MoveJ Target_20, v1000, z50, tool0\WObj:=wobj0;
      !  WaitSyncTask sync2, tasklist;
        
        
        ! [...]
        ! No the cool stuff starts ...
        SyncMoveOn syncMoveStart, tasklist;
        ! Syncrhonized motions, where motions with the same ID are carried out simultaniously,
        ! that is, they start and stop at the same time and the speed is thus changed.

        MoveJ Target_30\ID:=1, v1000, z50, tool0\WObj:=wobj0;
        MoveJ Target_150\ID:=2, v1000, fine, tool0\WObj:=wobj0;
        
        MoveJ Offs(Target_150, -30, 0,0)\ID:=3, v1000, fine, tool0\WObj:=wobj0;
        
        MoveJ Offs(Target_150, 0, 0,0)\ID:=4, v1000, fine, tool0\WObj:=wobj0;
      !  MoveJ Offs(Target_150, 0, 0, -100)\ID:=4, v1000, fine, tool0\WObj:=wobj0;
        
      !  MoveJ Offs(Target_150, 0, 100, 100)\ID:=5, v1000, fine, tool0\WObj:=wobj0;
        
        SyncMoveOff syncMoveStop;
        
    ENDPROC
    PROC Path_40()
        MoveL Target_150,v1000,z100,tool0\WObj:=wobj0;
    ENDPROC
   
ENDMODULE
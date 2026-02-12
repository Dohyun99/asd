sequenceDiagram
    participant SCH as Scheduler (SCH)
    participant SB as Software Bus (SB)
    participant SC as Stored Command (SC)
    participant TBL as Table Services (TBL)
    participant TIME as Time Services (TIME)
    participant Target as Target App (System)

    Note over SCH, SC: 1. Wake-up Cycle Initiation (1Hz)
    SCH->>SB: Publish SC_WAKEUP_MID
    SB->>SC: Receive Wakeup Message
    
    activate SC
    Note over SC: 2. Housekeeping (Optional Pre-check)
    SC->>SC: Check Verify/Status Limits

    Note over SC: 3. Process ATS (Absolute Time Sequence)
    opt If ATS is Active
        SC->>TBL: Access Active ATS Table Buffer
        SC->>TIME: Get Current Spacecraft Time
        SC->>SC: Compare [Current Time] vs [Next Cmd Time]
        
        alt Current Time >= Next Cmd Time
            SC->>SB: Publish Command Packet (CMD)
            SB->>Target: Route Command to App
            SC->>SC: Increment ATS Cmd Pointer
            SC->>SC: Mark Command as Executed
        else Time Not Reached
            SC->>SC: Wait for next cycle
        end
    end

    Note over SC: 4. Process RTS (Relative Time Sequence)
    loop Check All RTS (1 to 64)
        opt If RTS(N) is Active
            SC->>SC: Check/Update RTS Timer
            
            alt Timer >= Next Cmd Delay Time
                SC->>TBL: Access RTS Table Buffer
                SC->>SB: Publish Command Packet (CMD)
                SB->>Target: Route Command to App
                SC->>SC: Update Next Cmd Pointer
                SC->>SC: Reset RTS Timer (for next cmd)
            end
        end
    end

    Note over SC: 5. Finalize Cycle
    SC->>SB: Publish HK Telemetry (SC_HK_TLM_MID)
    deactivate SC

I need you to implement the following design doc: $ARGUMENTS

In doing this use the following steps:
Step 1: Read the design doc and then explore the code base and to understand how it will fit into the existing code.
    - make heavy use of subagents (Agent tool) here and tell them to ultrathink as hard as possible on their subtask.
    - create TODOs to track each subtask described in the design doc make sure you order them appropriately

Step 2: For each subtask have a subagent implement the subtask
    - Tell the subagent to ultrathink about its task and give it the design doc as context. Tell the subagent to make heavy use of subagents to understand the relevant existing code Make sure to tell the subagent to manually test the game still works after the change using scripts/perform_action.py


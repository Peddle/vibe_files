I need you to design then implemeht the following
<task>
$ARGUMENTS
</task>

In doing this use the following steps:
Step 1: Explore the code base and to understand how this task will fit into the existing code.
     - make heavy use of subagents (Agent tool) here and tell them to ultrathink as hard as possible on their subtask.
     - create TODOs to track what you understand and what you still need to learn

Step 2: ultrathink as hard as you can on the ideal plan to implement this feature in a way that would pass production grade
  code review
     - Consider what refactors (if any) may be required keeping in mind we want to avoid code debt in any planned 
 implementation
     - Remember also that backwards compatibility is never a requirement
     - save your plan as a .md file

Step 3: Ask a subagent to find flaws in your plan and iterate
     - Instruct the subagent to ultrathink as hard as possible about the plan and to explore any relevant code to try and 
 find flaws
     - Use TODOs to track how many times you've run this step (you should run it at least 5 times)
     - Integrate the feedback from the subagent before moving on to the next iteration

Step 4: create a subagent to implement the plan. Give it the following instructions:
```subagent_instructions
   I need you to implement the following design doc: "design doc name"

   In doing this use the following steps:
   Step 1: Read the design doc and then explore the code base and to understand how it will fit into the existing code.
       - make heavy use of subagents (Agent tool) here and tell them to ultrathink as hard as possible on their subtask.
       - create TODOs to track each subtask described in the design doc make sure you order them appropriately

   Step 2: For each subtask have a subagent implement the subtask
       - Tell the subagent to ultrathink about its task and give it the design doc as context. Tell the subagent to make 
 heavy use of subagents to understand the relevant existing code 
 ```

 Step 5: review acceptance criteria:
   - follow any acceptance / validation criteria outlined in CLAUDE.md


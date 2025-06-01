I need you to clean up the code from $ARGUMENTS and get it ready to pass code review

In doing this use the following steps:
Step 1: For each code file that needs to be cleaned up, start a subagent to review the code and provide code quality suggestions
    - create TODOs to track which subagents you still need to make
    - Instruct the subagent as follows:
        - Ask the subagent to read relevant files to the main file it's focused on, but explicitly tell it not to write any code just yet. Tell the subagent to use subagents to verify details or investiage particular questions it might have.
        - Ask the subagent to make a plan for how to approach a specific problem. We recommend using the word "ultrathink" to trigger extended thinking mode, which gives the subagent additional computation time to evaluate alternatives more thoroughly.
    - after each subagent completes update your plan which should be saved as a .md in the root directory

Step 2: Ask a subagent to find flaws in your plan and iterate
    - Instruct the subagent to ultrathink as hard as possible about the plan and to explore any relevant code to try and find flaws
    - Use TODOs to track how many times you've run this step (you should run it at least 5 times)
    - Integrate the feedback from the subagent before moving on to the next iteration

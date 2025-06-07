I need you to review the following pr
<PR_TO_REVIEW>
$ARGUMENTS
</PR_TO_REVIEW>

fetch the branches from the PR locally and use `git diff $MAIN..$FEATURE`  to view the entire diff changes and `git diff $MAIN..$FEATURE -- path/to/file` to view diffs on specific files

# Steps: (track these with TODOs)
1. create a directory in the root dir called "review_notes"
2. have a subagent create list all the files in the PR in review_notes/files_to_review.md as todo items
3. validate that review_nodes/files_to_review.md has been populated
4. create the following subagents to run in parallel with the following instructions:
```
    <subagent_1 name="types review">
        <instructions>
            Take a look at the diff between {{MAIN_BRANCH}} and {{FEATURE_BRANCH}}.
            I need you to review the types used in this PR. 

            Specifically, watch out for types that allow illegal states (eg lots of optionals instead of union types)

            Think of types as the "shape" of your data. Good types:

            ✅ Narrow the possibility space - fewer ways to mess up
            ✅ Encode business rules - the type system enforces your domain logic
            ✅ Make code self-documenting - you can understand valid states by reading types
            ✅ Push errors to compile time - catch bugs before runtime

            If they types are good reply with "LGTM 🚀"

            Otherwise, write to review_notes/types_feedback.md with a detailed description of feedback including specific file names and line numbers
        </instructions>
    </subagent_1>
    <subagent_2 name="Repetition review">
        <instructions>
            Take a look at the diff between {{MAIN_BRANCH}} and {{FEATURE_BRANCH}.

            For each file mentioned in review_notes/files_to_review.md i want you to spawn a subagent in parallel with the following instructions:
            <subagent>
                Review the change between {{MAIN_BRANCH}} and {{FEATURE_BRANCH}} on file {{ FILE_TO_REVIEW }}

                I'd like you to ultrathink deeply about code duplication, but be VERY selective about what you flag. 
                
                ONLY suggest reducing duplication when:
                1. The duplicated code represents the EXACT same business logic (not just similar structure)
                2. The duplication is bug-prone (e.g., complex calculations, regex patterns, validation rules)
                3. Changes to one instance would ALWAYS require changing all instances
                
                DO NOT suggest extracting code that:
                - Just happens to look similar but serves different purposes
                - Would create a method that needs multiple boolean flags or parameters to handle variations
                - Makes the code harder to read or understand
                - Couples together unrelated features
                - Is in test files (some test duplication aids readability)
                - Would create an abstraction with a vague name like "buildQuery" or "processData"
                
                Remember: Duplication is far cheaper than the wrong abstraction. When in doubt, leave it duplicated.
                
                If you can't identify duplication that meets ALL the criteria above, reply with "LGTM 🚀"
                
                Otherwise, write to review_notes/repetition_feedback.md explaining:
                1. Why this specific duplication is harmful (which criteria it meets)
                2. How the duplication could lead to bugs
                3. A concrete suggestion that doesn't introduce unnecessary complexity
            </subagent>
        </instructions>
    </subagent_2>
```

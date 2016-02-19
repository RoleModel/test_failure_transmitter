# Ideas
- [x] Show summary of failure frequency at the end of the test run
- [x] Don't show tests that haven't failed in the summary
- [x] Print number of runs in summary
- [ ] Add some color to the summary
  - Yellow if under certain failure rate, red if over?
- [ ] Rake task to run with this formatter only on the master branch with no uncommitted changes
- [x] Figure out what to show if there are no known failures
- [ ] Package up in an easily-includable form (Gem?)
- [ ] Export to CSV
- [ ] Rake task to print report on test failure frequency
- [ ] Track tags on examples (see if `:js` tag or something causes problems)

# Things to figure out

When should data reset or be removed? (make sure failure data is up-to-date for current test runs)
Way to mark a test as fixed?

# Problem Statement

For a test suite with a lot of intermittent failures (such as the one for CVP), it would be helpful to have some metrics on which tests fail most often so we can know which ones to fix first. ([CircleCI](https://circleci.com/build-insights))

# Overview of initial research or spike

- Discussed what the tool should do
- Looked up how to make custom formatters for RSpec
- Got to a working prototype that just dumped data to a YAML file
- Discussed ideas for improvements
- Implemented a few ideas to make the output better
  - Show a summary of the worst offenders at the end of the test run (with a failure percentage)
  - Include number of runs per test in the summary
- Run a bunch of tests to play with it
  - Tried with a small suite with intentionally intermittently failing tests
  - Tried with one of the worst offenders in CVP (session_timeout_spec)

# Next steps

- Clean up from spike (add some tests)
- Track some other metrics?
- Save data in a format that we can filter by date or some sort of time
- Store data on an external service (even if it's one we build. Perhaps Google Spreadsheets?)
  - See both all-time failures and emerging (new problem) failures
- Allow output file to be easily specified
- Limit summary to only tests that were in that run
  - If you only run a few tests, you probably only want to see data on the tests you ran

## Existing Failures

- See most frequent
- Tests must have been run a certain amount of times to count as "Existing"
  - How many times must tests have been run?
- Filter by date (filter out ones that have been fixed)
- Goal is to prioritize which should be fixed first to have the greatest impact on the entire suite

## Emerging Failures

- Tests are "Emerging" failures for some period of time after their first failure is logged
  - How long are they counted as "Emerging"?
- Goal is to keep new intermittent failures from being introduced (or stop them quickly)
- Should also show failure percentage to aid prioritization of fixes
  - More likely to be inaccurate given the expected smaller amount of data

# What Was Learned

- There's still UI/UX design for a terminal-based utility
- Making a custom formatter for RSpec is really easy

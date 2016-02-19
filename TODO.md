# Ideas
- [ ] Better querying of data
- [x] Show summary of failure frequency at the end of the test run
- [x] Don't show tests that haven't failed in the summary
- [ ] Print number of runs in summary
- [ ] Add some color to the summary
  - Yellow if under certain failure rate, red if over?
- [ ] Rake task to run with this formatter only on the master branch with no uncommitted changes
- [ ] Figure out what to show if there are no known failures
- [ ] Package up in an easily-includable form (Gem?)
- [ ] Export to CSV
- [ ] Rake task to print report on test failure frequency

# Things to figure out

When should data reset or be removed? (make sure failure data is up-to-date for current test runs)
Way to mark a test as fixed?

# Next steps

Clean up from spiking (add some tests)
Track some other metrics?
Store data on an external service (even if it's one we build. Perhaps Google Spreadsheets?)
Save data in a format that we can filter by date or some sort of time
User specified output file
Find other data to track

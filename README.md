# Digital Origin Bank Transfers TEST
This rails app has not any controller or view yet, the focus was on models, jobs 
and rspec.

## Installation
Do a git clone of the app as

```
git clone git@github.com:gguerrero/do_banking_test.git
```

Then enter the project and bundle it

```
cd do_banking_test
bundle install
```

## Up and running
Run the following rakes for having Database UP and some seeds:

```
rake db:create db:migrate db:seed
```

## Running tests
Run tests with:

```
rspec --format doc
```

There are some missing models without testing at the moment (Transfer and TransferType) but they are 
covered on Jobs testing section.

## Running in rails console
This would be the way you can run an test on a rails console for unit testing:

```ruby
aa = Bank.first.accounts.first
ab = Bank.last.accounts.first

puts "CREDIT BEFORE FOR A: #{aa.current_credit}"
puts "CREDIT BEFORE FOR B: #{ab.current_credit}"

TransferAgentJob.perform_now(account_from_id: aa.id, account_to: ab.id, quantity_to_transfer: 3505)

Transfer.all { |t| pp t.inspect }
puts "CREDIT AFTER FOR A: #{aa.current_credit}"
puts "CREDIT AFTER FOR B: #{ab.current_credit}"
```

## Questions

### How would you improve your solution?
* More testing
* More validations on model section
* Abstraction of transfer type logic for deciding commission and max (jobs/transfer_agent_job.rb:23)

### How would you adapt your solution if transfers are not instantaneous?
The current solution is almost ready to be executed with ```perform_later``` feature from 
**rails 5 ActiveJob**, so this would be the aswer for non sync transfer. Just have to improve the way the async transations are made to not collapse when saving in the database.

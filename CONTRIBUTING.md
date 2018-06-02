# Style guidelines

Run `bundle exec rake app:lint` to check for style errors. Pay special attention to:

 - Indent with tabs, not with 2 spaces: This way everyone can adjust their tab width on their preferred editor.
 - Use spaces around parentheses, brackets, etc:

```ruby
def method( some_array )
   some_array[ some_index ] = some_array.size
end
```

 - Use spaces after commas, for example: `call_some_method argument1, argument2, argument3`.
 - Don't ommit parentheses on method definitions when the method takes arguments.
 - Use **&&**, **||** and **!** instead of **and**, **or** and **not**: The latter operators have precedende problems.
 - Use guard clauses instead of wrapping the code inside a conditional expression:

Don't do this:
```ruby
if some_condition
   some_code
end
```

Do this:
```ruby
some_code if some_condition
```

 - Use *_* or *_variable_name* when an argument is not used.
   This clearly indicates the argument is required by protocol/interface but is not really used.

 - Use `unless` instead of `if` for negative conditions:

Don't do this:
```ruby
do_something if !some_condition
```

Do this:
```ruby
do_something unless some_condition
```

 - Don't use `unless` with an `else`. Use the positive case first with `if`.

 - Don't use unnecessary blocks when manipulating collections, it lends itself to undescriptive variable names.
   Just pass the message to send to the elements of the collection.

Don't do this:
```ruby
some_collection.map { |str| str.strip }
```

Do this:

```ruby
some_collection.map( &:strip )
```

 - Use `fail` instead of `raise`. Use `raise` only when re-throwing an exception. `fail` indicates intention better.

 - Call lambadas with short syntax

Don't do this:
```ruby
some_lambda.call( some_arguments )
```

Do this:
```ruby
some_lambda.( some_arguments )
```

 - Don't use braces {} for multi-line blocks.

# Tests

 - It's not completely necessary to test rails controllers, nor views.
 - DO test business core logic functionality.
 - Use code coverage reports to address non-tested code.
 - Stub first, then mock.
 - Test stubs and mocks against interfaces to avoid drift.
 - If collaborators respect the following rules, don't stub them, just use them. Don't waste time.
   - Objects with no relationship to others (for example, value objects).
	- Objects with 1 or 2 relationship to simpler objects.
	- Objects with simple functionality.
 - Don't mock framework classes (yo don't own them, yo don't understand them).
 - Don't test outgoing query messages (if you need, return a valid result from a mock).
 - Do test outgoing command messages.

# Controllers

 - Very thin, they should have no logic whatsoever.
 - Should not interact directly with models.
 - Should only interact with views and interactors.

# Code quality

Run the reports tasks to check

 - Code quality.
 - Code style.
 - Test coverage.

# Documentation

Add all API documentation to the RAML documentation on [docs/api](/docs/api) directory.

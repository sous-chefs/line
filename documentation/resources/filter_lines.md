# Resource: filter_lines

## Actions

| Action | Description |
| ------ | ----------- |
| edit   | Use a proc  |

## Properties

| Properties     | Description                       | Type                   | Values and Default                  |
| -------------- | --------------------------------- | ---------------------- | ----------------------------------- |
| path           | String                            | Path to file           | Required, no default                |
| filters        | Array of filters, Proc, Method    | See the filter grammar | Required, no default                |
| ignore_missing | Don't fail if the file is missing | true or false          | Default is true                     |
| eol            | Alternate line end characters     | String                 | default \n on unix, \r\n on windows |
| backup         | Backup before changing            | Boolean, Integer       | default false                       |

## Example Usage

```ruby

filter_lines 'Shift lines to at least 8 leading spaces' do
  path '/some/file'
  filter proc { |current| current.map(|line| line =~ /^ {8}/ ? line : "       #{line}") }
end
```

```ruby
insert_lines = %w(line1 line2 line3)

match_pattern = /^COMMENT ME|^HELLO/
filter_lines 'Insert lines after match' do
  path '/some/file'
  filter after: [match_pattern, insert_lines]
end

filter_lines 'Built in example filters' do
  path '/tmp/multiple_filters'
  sensitive false
  filters(
    [
    # insert lines after the last match
      { after:  [match_pattern, insert_lines, :last] },
    # insert lines before the first  match
      { before: [match_pattern, insert_lines, :first]  },
    ]
  )
end
```

## Notes

The filter_lines resource passes the contents of the path file in an array of lines to a Proc or Method
filter. The filter should return an array of lines. The output array will be written to the file or passed to the next filter.
The built in filters are usable examples of what can be done with a filter, please write your own when you have specific needs.
The built in filters all take an array of positional arguments.

## Filter Grammar

```text
filters ::= filter | [<filter>, ...]
filter  ::= <code> | { <code> => <args>  }
args    ::= <String> | <Array>
code    ::= <Symbol> | <Method> | <Proc>
Symbol  ::= :after | :before | :between | :comment | :replace | :stanza | :substitute
            Symbols are translated to methods in Line::Filter
Method  ::= A reference to a method that has a signature of method(current lines is Array, args is Array)
            and that  returns an array
Proc    ::= A reference to a proc that has a signature of proc(current lines is Array, args is Array)
            and returns an array
```

## Filters

| Built in Filter | Description                                 | Arguments        | arg1                               | arg2                                                       | arg3 |
| --------------- | ------------------------------------------- | ---------------- | ---------------------------------- | ---------------------------------------------------------- | ---- |
| `:after`        | Insert lines after a matching line          | Pattern to match | String or Array of lines to insert | `:each`, `:first`, or `:last` to select the matching lines |
| `:before`       | Insert lines before a matching line         | Pattern to match | String or Array of lines to insert | :each, :first, or :last to select the matching lines       |
| `:missing`      | Insert lines before or after existing lines | Pattern to match | String or Array of lines to insert | `:before`, `:after`                                        |

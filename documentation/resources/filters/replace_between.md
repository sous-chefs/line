# Examples for the replace_between filter

## Original file
````text
line1
line2
line3
````

## Output file
```ruby
line1
rep1
rep2
line3
````

## Filter
````ruby
replines = "rep1\nrep2\n"
filter_lines '/example/replace_between' do
 filters(replace_between: [/^line1$/, /^line2$/, replines])
end

## Original file
````text
line1
line2
line3
````

## Output file
````text
rep1
rep2
````

## Filter
````ruby
replines = "rep1\nrep2\n"
filter_lines '/example/replace_between_include_bounds' do
 filters(replace_between: [/^line1$/, /^line2$/, replines, :include])
end

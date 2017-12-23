# JobSpec

A ruby gem for defining job specifications in a nice DSL that enables composition of expectations between roles.

## Installing

To use from the command line:

```
gem install job_spec
```

## Usage

Create a job specification for a role:

``` ruby
JobSpec::Role.definition "Engineer" do
  expected "to be cool"
end
```

Save that into a file `roles/engineer.rb`. Now from the command line in the directory that contains the `roles/` directory:

```
jobspec build roles
```

And you will see your job roles printed out.

## Examples

See the [`example/`](example) directory and also the RSpec examples in [`spec/`](spec).

## License

MIT

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :specs do
  guard :rspec, :cli => '--color --format doc --fail-fast' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^(lib/.+)\.rb$})                { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')             { 'spec' }
  end
end
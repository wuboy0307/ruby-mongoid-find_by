require 'bundler'

Pry::Commands.block_command 'clear' do
  system('clear');
end

Bundler.require(:default, :development)
Pry.print = proc { |out, value| out.puts value.ai }

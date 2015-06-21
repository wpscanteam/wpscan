# encoding: UTF-8

require 'spec_helper'

describe 'wpscan main checks' do

  it 'should check for errors on running the mainscript' do
    a = %x[#{RbConfig.ruby} #{ROOT_DIR}/wpscan.rb]
    expect(a).to match /No argument supplied/
  end

  it 'should check for valid syntax' do
    result = ''
    Dir.glob('**/*.rb') do |file|
      res = %x{#{RbConfig.ruby} -c #{ROOT_DIR}/#{file} 2>&1}.split("\n")
      ok = res.select {|msg| msg =~ /Syntax OK/}
      result << ("####################\nSyntax error in #{file}:\n#{res.join("\n").strip}\n") if ok.size != 1
    end
    fail(result) unless result.empty?
  end
end

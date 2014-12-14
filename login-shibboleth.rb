#!/usr/bin/env ruby

require "mechanize"
require "yaml"

begin
  path = File.expand_path(File.dirname(__FILE__))
  SETTINGS = YAML::load(open(path+"/userinfo.conf"))
rescue
  puts "Config file load failed."
  exit
end

USER = SETTINGS["user"]
PASS = SETTINGS["password"]

agent = Mechanize.new
agent.user_agent_alias = "Linux Firefox"
agent.keep_alive = false
agent.get("http://10.10.10.10/")

sleep 3

agent.page.form_with(name: "Login") do |form|
  form.field_with(name: "uid").value = USER
  form.field_with(name: "pwd").value = PASS
  form.click_button
end

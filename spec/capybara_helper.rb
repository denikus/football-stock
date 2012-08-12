#add role attribute to capybara selectors
Capybara.add_selector(:role) do
  xpath { |role| XPath.descendant[XPath.attr(:role) == role.to_s] }
end

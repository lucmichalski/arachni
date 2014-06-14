=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    All rights reserved.
=end

class Arachni::Reporters::HTML

#
# HTML formatter for the results of the HealthMap plugin
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
#
class PluginFormatters::HealthMap < Arachni::Plugin::Formatter
    include TemplateUtilities

    def run
        ERB.new( tpl ).result( binding )
    end

    def tpl
        <<-HTML
            <style type="text/css">
                a.without_issues {
                    color: blue;
                }
                a.with_issues {
                    color: red;
                }
            </style>

            <div class="row">
                <div class="col-md-2">
                    <strong>Total</strong>: <%= results['total'] %> <br/>
                    <strong>Safe</strong>: <%= results['without_issues'] %> <br/>
                    <strong>Unsafe</strong>: <%= results['with_issues'] %> <br/>
                    <strong>Issue percentage</strong>: <%= results['issue_percentage'] %>%
                </div>

                <div class="col-md-10">
                    <ul>
                    <% results['map'].each do |entry|
                            state, url = entry.to_a.first
                        %>

                        <li>
                            <a class="<%= state %>" href="<%= escapeHTML url %>"><%= escapeHTML url %></a>
                        </li>
                    <% end %>

                    </ul>
                </div>
            </div>
        HTML
    end

end
end

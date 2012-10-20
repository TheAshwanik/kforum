ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #  span :class => "blank_slate" do
    #    span "Welcome to Active Admin. This is the default dashboard page."
    #    small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #  end
    #end
 
    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      
       column do
         panel "Recent Posts" do
           table_for Post.order("created_at desc") do
                column("Posts") {|post| link_to "#{post.content}", post_path(post) }
                column("Date"){|order| pretty_format(order.created_at) }
                #column("Total") {|post| number_to_currency order.total_price }
                column("User"){|post| link_to(post.user.username, admin_user_path(post.user)) }

            end
         end
       end
       

      column do
        panel "Recent Customers" do
          table_for User.order('id desc').limit(10).each do |user|
            column("User") { |user| link_to(user.username, admin_user_path(user)) }
            column(:email) { |user| mail_to(user.email) }
          end
        end
      end


       
       
    end
    
  end # content
  
      # Define your dashboard sections here. Each block will be
    # rendered on the dashboard in the context of the view. So just
    # return the content which you would like to display.
    
    # The dashboard is organized in rows and columns, where each row
    # divides the space for its child columns equally.

    # To start a new row, open a new 'columns' block, and to start a
    # new column, open a new 'colum' block. That way, you can exactly
    # define the position for each content div.

    # == Simple Dashboard Column
    # Here is an example of a simple dashboard column
    #
    # column do
    # panel "Recent Posts" do
    # content_tag :ul do
    # Post.recent(5).collect do |post|
    # content_tag(:li, link_to(post.title, admin_post_path(post)))
    # end.join.html_safe
    # end
    # end
    # end
    
    # == Render Partials
    # The block is rendererd within the context of the view, so you can
    # easily render a partial rather than build content in ruby.
    #
    # column do
    # panel "Recent Posts" do
    # render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
    # end
    # end
end

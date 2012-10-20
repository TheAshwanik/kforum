ActiveAdmin.register User, :as => "User" do
    
  config.batch_actions = true
 
  controller { with_role :admin }
  
  # Filter to hide/show data
  #
  filter :username
  filter :email
  filter :created_at
  #
  
  # Form to show only needed fields
  #
  form do |f|
  f.inputs "User Details" do
    f.input :username
    f.input :email
    f.input :password
    f.input :password_confirmation
    f.input :admin
    f.input :mail_subscription
  end
    f.buttons
  end
  #

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    default_actions
  end
  
  show :title => :email do
    panel "Posts History" do
      table_for(user.posts.order('created_at desc')) do
          column("Posts", :sortable => :id) {|post| link_to "#{post.content}", post_path(post) }
          column("Date", :sortable => :created_at){|order| pretty_format(order.created_at) }
      end
    end
    active_admin_comments
  end

  sidebar "User Details", :only => :show do
    attributes_table_for user, :username, :email, :created_at
  end

  sidebar "Posting History", :only => :show do
    attributes_table_for user do
      row("Total Posts") { user.posts.count }
      #row("Total Value") { number_to_currency user.orders.complete.sum(:total_price) }
    end
  end

  #sidebar "Active Admin Demo" do
    #render('/admin/sidebar_links', :model => 'users')
  #end
end
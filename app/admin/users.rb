ActiveAdmin.register User do
	index do
    column :email
    column :password
    column :username
    column "Role" do |user|
      (user.roles.map{ |p| p.name }).join(' ')
    end
    default_actions                   

  end

  filter :email                       

  form do |f|
    f.inputs do
      f.input :email
      f.input :roles # add roles input here
      f.has_many :topics, :allow_destroy => true, :heading => 'Themes', :new_record => false do |cf|
       cf.input :title
       cf.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
      end
	  f.has_many :posts, :allow_destroy => true, :heading => 'Themes', :new_record => false do |cf|
       cf.input :body
       cf.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
      end
    end
    f.actions                         
  end

  show do
    div :class => 'panel' do
      h3 'User Details'
      div :class => 'panel_contents' do
        div :class => 'attributes_table user' do
          table do
            tr do
              th { 'Email' }
              td { user.email }
            end
            tr do
              th { 'Roles' }
              td { (user.roles.map { |p| p.name }).join(' ') }
            end
            tr do
            	th{'Topics'}
				td{(user.topics.map { |p| p.title }).join(' ')}
            end
			tr do
            	th{'Posts'}
				td{(user.posts.map { |p| p.title }).join(' ')}
            end
          end # table
        end # attributes_table
      end # panel_contents
    end # panel
  end # show
end

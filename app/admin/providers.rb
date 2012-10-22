ActiveAdmin.register Provider do
  actions :index, :show, :new, :edit, :create, :update

  index do
    column(:establishment_name){|provider| link_to provider.establishment_name, admin_provider_path(provider)}
    column(:name){|provider| "#{provider.fname} #{provider.lname}"}
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end 

  filter :establishment_name, :as => :string
  filter :email, :as => :string
  filter :fname, :as => :string, label: "First Name"
  filter :lname, :as => :string, label: "Last Name"

  show do
    attributes_table do
      row :_type
      row :id
      row :establishment_name
      row :email
      row :fname
      row :lname
      row :phone_number
    end

    panel "Clients" do
      table_for provider.clients do |c|
        c.column :name
        c.column :phone_number
        c.column :email
        c.column :created_at
      end
    end
  end

  sidebar "Tracking Details", :only => :show do
    attributes_table_for provider do
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
  end

  sidebar "Confirmation Details", :only => :show do
    attributes_table_for provider do
      row :confirmation_token
      row :confirmation_sent_at
      row :confirmed_at
      row :unconfirmed_email
    end
  end

  sidebar "Password Details", :only => :show do
    attributes_table_for provider do
      row :remember_created_at
      row :encrypted_password
      row :reset_password_token
      row :reset_password_sent_at
    end
  end
  
end

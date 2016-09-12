ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :rut, :name, :user
  actions :all

  index do
    column :id
    column :name
    column :rut
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :rut
    end
    f.actions
  end

  controller do
    def create
      @user = User.new({rut: params[:user][:rut], name: params[:user][:name], template: 'template'})
      if @user.valid?
        register_finger_print
      else
        redirect_to admin_users_path, :alert => "Rut ya existe o está incorrecto, intente nuevamente"
      end
    end

    def register_finger_print
      begin
        clean_register_finger_print
      rescue Cocaine::ExitStatusError => e
        redirect_with_user_creation_error_message
      rescue ActiveRecord::ActiveRecordError => e
        redirect_with_user_creation_error_message
      end
    end

    def clean_register_finger_print
      line = Cocaine::CommandLine.new("caregister #{@user.rut} #{@user.name}")
      @user.template = line.run.chomp
      @user.save!
      redirect_to admin_users_path
    end

    def redirect_with_user_creation_error_message
      redirect_to admin_users_path, :alert => "Error al crear usuario, intente nuevamente"
    end
  end
end
